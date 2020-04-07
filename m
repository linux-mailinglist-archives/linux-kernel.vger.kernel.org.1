Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B71A184C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDGWov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 18:44:51 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45163 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGWov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:44:51 -0400
Received: by mail-il1-f196.google.com with SMTP id x16so4885381ilp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oofgp/T6AW49TxBbYkC8nWUbJk1leoz17ITw6jj2QJ0=;
        b=FQwZ9WExx4B4zYVFH4rDo7FKhKj9DJhOj95gcRjYqZLyNBTbpmzDfbpfvFKHM2MSww
         HwpH/AXvsxgS7kSRpBe5si9OOfyZ0zu0rgafv0v9/J/yBCnfBY1+gCELGdPEsbadZjmu
         /x+mh7ZsLn/Cy8h9jdWhUPYtDl2XGtz0pqrRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oofgp/T6AW49TxBbYkC8nWUbJk1leoz17ITw6jj2QJ0=;
        b=nyrRlgFqcdICWmg3RGaeIatwT0a8EvU2/3uk0gUZKzHDbavjuNpxKxDQAYNb5OdD+x
         p49I+GQc9xlY7qv1DlLaZurcBXCdvBz30S/Na9C+cJJzjQBk1XNyC7FniZPQbQQLqYg6
         LG7sNNyNXPqlpBxGgZwQsv1NcNfoOycrajmtEZeT2I2N3Vmd2a9q2A5mDhsQk/jPg9An
         JkG8a+7kFBjzRaqWEYyXSienV/ZyUOuxBACi6pMLwhdPvf8emSDkM4YU2Msbn3kufR0e
         2gokOHM/iZx47F62GMMZEM1kjoK8GsI61gzS56BoJykhGxykIB87fcer9U2cDALCvkhh
         xOwQ==
X-Gm-Message-State: AGi0PuYRFmSCVgkRBX6Mc7IsGK/4BKOvspazQ8hMTD1kENXoC198cHU0
        E8xIWymEmCfLmE5XHC9NqvwTww==
X-Google-Smtp-Source: APiQypKOH2Yw4cE+ZWnzZZK0xkO4YQUmuivtdVtcuJdE5RMdeBIN8GbObMxVNUWhUJgnY95NNqIyuA==
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr5288157ilj.112.1586299490170;
        Tue, 07 Apr 2020 15:44:50 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i4sm7315788ilq.4.2020.04.07.15.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:44:49 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, rong.a.chen@intel.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix memfd test run-time regression
Date:   Tue,  7 Apr 2020 16:44:46 -0600
Message-Id: <20200407224446.1578-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d3fd949abd3e ("selftests: Fix memfd to support relocatable
build (O=objdir)") introduced regression run-time regression with
a change to include programs that should be run from shell scripts
to list of programs that run as independent tests. This fix restores
the original designation.

Fixes: d3fd949abd3e ("selftests: Fix memfd to support relocatable build (O=objdir)")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/memfd/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 0a15f9e23431..187b14cad00c 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,8 +4,9 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
+TEST_GEN_PROGS := memfd_test
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
+TEST_GEN_FILES := fuse_test fuse_mnt
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
-- 
2.20.1

