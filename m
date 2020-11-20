Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA032BB8BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgKTWPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgKTWPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:15:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3414C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:15:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so9191541pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prvg8B1KrWWe0HEsg9Zq+0hq/o/+oUphxhhcU5YZPAc=;
        b=JjVQvz53y0sUe4tDbun89hJwEgwjFoRzlFj6sxzrLA6Fxhs2My/ERhuiMFHtKX/tJ9
         GG9vqqYcQVJFr/Jj2kHdIDT6fB70TC7kTUFL+LXqwDowbfnJsnwPpqAYzPBZ9/LbP1CF
         qlpTBXZdy0aGXTrjBS3DL5dGfwlBQMWCD8EDTuugqJWvIXt5lszkpDnGpxfNHlOgr4Mj
         FToUB5RR3jx5WHcgh+o4LPGHZNC9eSoprOjtartzv+Wrk5vVInJ5I7fYywX+z615mGVs
         Qgyt7P7KwY9do/9DzhQTO6t4LFf2C74XxWqONzVGzHi6/vqdCTsuZL+76Flym3mqwOVc
         40xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=prvg8B1KrWWe0HEsg9Zq+0hq/o/+oUphxhhcU5YZPAc=;
        b=KUaupEPjv7YvX0f35w7ezRB3fjWn3nYVufIShLz7dGW0Oc07UCEcHKErt/8UXqHWy6
         Yh1eszR9u4EYwae0iIk+DXHIJnXmAAsbCJzkEisPESPCL0Hct0VJoD4VA+JnG9Un1Ub+
         poG/kX3O2flvenlQkjaQVtV7+K4LUKZ8PPbToyxsufWXc2Q7i7vj5QKvItQX8glgHF7u
         8zpdiksUJYtTQ9sw4wejB6Ba0+9o6dL9fdKblHZXwNDJdtY5VBUlFs8a+XAIoEobkJfM
         8QNCEXNts3f9z4l0HY/7PLSjT5AX5PT14jGQir9XNobsUsMK5uAZy6gYCpC0K0aKdA82
         8u/Q==
X-Gm-Message-State: AOAM532gpOvkGUUxduPqjuJZ+hnLcKIOyw1jhgZbD1FfOCkcp9fJ+hwr
        qu9wd8iaNVEIKJMtxICHM3aNLWJ3ELAmDQ==
X-Google-Smtp-Source: ABdhPJz69AbNH3kD/vjJGU0KicZy7bG9TzXlbQcQLLB5PEQgRaLHieKXEUfYuogR05wuKTPQG/6MJw==
X-Received: by 2002:a63:d357:: with SMTP id u23mr19387230pgi.106.1605910509948;
        Fri, 20 Nov 2020 14:15:09 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
        by smtp.gmail.com with ESMTPSA id t8sm4704085pfe.65.2020.11.20.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 14:15:09 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Tejun Heo <tj@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: add local64.h to fix blk-iocost build
Date:   Sat, 21 Nov 2020 07:14:58 +0900
Message-Id: <20201120221500.3097841-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of 5.10 OpenRISC allyesconfig builds fail with the following error.

    $ make ARCH=openrisc CROSS_COMPILE=or1k-elf- block/blk-iocost.o
      CALL    scripts/checksyscalls.sh
      CALL    scripts/atomic/check-atomics.sh
      CC      block/blk-iocost.o
    block/blk-iocost.c:183:10: fatal error: asm/local64.h: No such file or directory
      183 | #include <asm/local64.h>
	  |          ^~~~~~~~~~~~~~~
    compilation terminated.

The new include of local64.h was added in commit 5e124f74325d
("blk-iocost: use local[64]_t for percpu stat") by Tejun.

Adding the generic version of local64.h to OpenRISC fixes the build
issue.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..442f3d3bcd90 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
+generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += qspinlock_types.h
 generic-y += qspinlock.h
-- 
2.26.2

