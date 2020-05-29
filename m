Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC75C1E773B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2Hln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:41:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47064 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgE2HlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id p21so1002669pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBgsWCIFjc1dCALH3PIiiJW4ZW3ozJ7JvpAnInxDZto=;
        b=HPcQBBp7oO+YDRSbRobSBLH5GiQL2bXvX/bbp/BXxAf3Xnb2uJlZc9ibvPMHkfBvtJ
         4LxOjOw6XUTZAHLry4UYwR8TWXETHRCHYqc+aBVwBJL1rH7Zli77VPXhYU/DGdC3gKQB
         LB+IvPdHVJNIDZbZ6zpLKKFo6wgypv73xyQ7zAPKK6JhB2IozS2y0y2A58Ms0pE0fPoj
         QaVIKrmc/NMic5nNC61HQbY9ZUMWlWDCvBN5YoxHqfaAuV6OpTqjUX3FuHp06wPKT5TX
         4wOsLq3BP4uXeCaVXekEAjmx311qYOkMXIT4cYZ8zUqa64bD+RQXkyZihPKmTJmIl9IC
         9d/g==
X-Gm-Message-State: AOAM532rcEKSB6sIq5QRa7vYVKAquCZ2Baj/qIlWBgcFJ4wQzZpY25bC
        x1cTgVKaIMCvweK9ssd+lHw=
X-Google-Smtp-Source: ABdhPJzuX8lSSg8Aasn2k4DvlaVD+6USysUPj9KRkIoQC5Conauc3KXazu1gR/0/ORcChuqRpyUMwQ==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr7127671pfr.51.1590738080556;
        Fri, 29 May 2020 00:41:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p19sm6115830pfn.216.2020.05.29.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C929442341; Fri, 29 May 2020 07:41:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 07/13] test_sysctl: use new sysctl subdir helper register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:02 +0000
Message-Id: <20200529074108.16928-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code considerably. The following coccinelle
SmPL grammar rule was used to transform this code.

// pycocci sysctl-subdir.cocci lib/test_sysctl.c

@c1@
expression E1;
identifier subdir, sysctls;
@@

static struct ctl_table subdir[] = {
	{
		.procname = E1,
		.maxlen = 0,
		.mode = 0555,
		.child = sysctls,
	},
	{ }
};

@c2@
identifier c1.subdir;

expression E2;
identifier base;
@@

static struct ctl_table base[] = {
	{
		.procname = E2,
		.maxlen = 0,
		.mode = 0555,
		.child = subdir,
	},
	{ }
};

@c3@
identifier c2.base;
identifier header;
@@

header = register_sysctl_table(base);

@r1 depends on c1 && c2 && c3@
expression c1.E1;
identifier c1.subdir, c1.sysctls;
@@

-static struct ctl_table subdir[] = {
-	{
-		.procname = E1,
-		.maxlen = 0,
-		.mode = 0555,
-		.child = sysctls,
-	},
-	{ }
-};

@r2 depends on c1 && c2 && c3@
identifier c1.subdir;

expression c2.E2;
identifier c2.base;
@@
-static struct ctl_table base[] = {
-	{
-		.procname = E2,
-		.maxlen = 0,
-		.mode = 0555,
-		.child = subdir,
-	},
-	{ }
-};

@r3 depends on c1 && c2 && c3@
expression c1.E1;
identifier c1.sysctls;
expression c2.E2;
identifier c2.base;
identifier c3.header;
@@

header =
-register_sysctl_table(base);
+register_sysctl_subdir(E2, E1, sysctls);

Generated-by: Coccinelle SmPL
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_sysctl.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 84eaae22d3a6..b17581307756 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -128,26 +128,6 @@ static struct ctl_table test_table[] = {
 	{ }
 };
 
-static struct ctl_table test_sysctl_table[] = {
-	{
-		.procname	= "test_sysctl",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= test_table,
-	},
-	{ }
-};
-
-static struct ctl_table test_sysctl_root_table[] = {
-	{
-		.procname	= "debug",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= test_sysctl_table,
-	},
-	{ }
-};
-
 static struct ctl_table_header *test_sysctl_header;
 
 static int __init test_sysctl_init(void)
@@ -155,7 +135,8 @@ static int __init test_sysctl_init(void)
 	test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
 	if (!test_data.bitmap_0001)
 		return -ENOMEM;
-	test_sysctl_header = register_sysctl_table(test_sysctl_root_table);
+	test_sysctl_header = register_sysctl_subdir("debug", "test_sysctl",
+						    test_table);
 	if (!test_sysctl_header) {
 		kfree(test_data.bitmap_0001);
 		return -ENOMEM;
-- 
2.26.2

