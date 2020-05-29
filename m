Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202EF1E7733
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE2HlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 03:41:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40128 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgE2HlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so758572plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFuOAMMzx366XD73njtfa9qdyal/YI+SEog1dnntDeg=;
        b=TIAsSYlZK0Pl5EcXWlYqbBC9/l733LCYbQd86Z9hi0ZQHKAnAp2THUrTSlmtS2IaD9
         fHI8KpaRq4HlJ115GeLfolOx9Lv77hA5M3yMwpRnx8zB2DpUJJKfvcsWkuEyICCIPLhs
         UZlnmOLkjHf7c2z6zSu5zpyZWNul08YS7s+5BFGSmibJPFsPY4E3XO69zeoY5H2E/Kln
         tqXh+c59D2jotbGwSxQW/QEf8XmfnG5s1/ic2bGUqmDCDBmz0QSAo7DvFxLF1jpt49Gu
         f6faKNVLUVPJulf+yYPknbOhCxmnHSn11Vl7z53LGcD7Of0AYhIlOztAHYiwYF9HOA46
         MlMA==
X-Gm-Message-State: AOAM533HDuv4anPbt15h9+WVq3xcH73zWuautjZFa9QHjAFybJbLOGt5
        g6cicPd1f0dTyw1kmgp404g=
X-Google-Smtp-Source: ABdhPJyWq+uNBt+z7g4lF4BNt9x39LLqlR7x3RVbHVyGUC5VKz7sfj4vqnpPnSKalsV1vnr314j4sQ==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr7568085plz.179.1590738077450;
        Fri, 29 May 2020 00:41:17 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 70sm6443717pfx.78.2020.05.29.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B233242337; Fri, 29 May 2020 07:41:10 +0000 (UTC)
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
Subject: [PATCH 05/13] macintosh/mac_hid.c: use new sysctl subdir helper register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:00 +0000
Message-Id: <20200529074108.16928-6-mcgrof@kernel.org>
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

// pycocci sysctl-subdir.cocci drivers/macintosh/mac_hid.c

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
 drivers/macintosh/mac_hid.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 28b8581b44dd..736d0e151716 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -239,33 +239,12 @@ static struct ctl_table mac_hid_files[] = {
 	{ }
 };
 
-/* dir in /proc/sys/dev */
-static struct ctl_table mac_hid_dir[] = {
-	{
-		.procname	= "mac_hid",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= mac_hid_files,
-	},
-	{ }
-};
-
-/* /proc/sys/dev itself, in case that is not there yet */
-static struct ctl_table mac_hid_root_dir[] = {
-	{
-		.procname	= "dev",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= mac_hid_dir,
-	},
-	{ }
-};
-
 static struct ctl_table_header *mac_hid_sysctl_header;
 
 static int __init mac_hid_init(void)
 {
-	mac_hid_sysctl_header = register_sysctl_table(mac_hid_root_dir);
+	mac_hid_sysctl_header = register_sysctl_subdir("dev", "mac_hid",
+						       mac_hid_files);
 	if (!mac_hid_sysctl_header)
 		return -ENOMEM;
 
-- 
2.26.2

