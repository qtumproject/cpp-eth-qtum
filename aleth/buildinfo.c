/* Cable: CMake Bootstrap Library.
 * Copyright 2018 Pawel Bylica.
 * Licensed under the Apache License, Version 2.0. See the LICENSE file.
 */

#include "buildinfo.h"

const struct buildinfo* aleth_get_buildinfo()
{
    static const struct buildinfo buildinfo = {
        .project_name = "aleth",
        .project_version = "1.5.2",
        .project_name_with_version = "aleth-1.5.2",
        .git_commit_hash = "f693331f2d4ea73c4913eebbec462e51138ade8f",
        .system_name = "",
        .system_processor = "",
        .compiler_id = "",
        .compiler_version = "",
        .build_type = "",
    };
    return &buildinfo;
}
