Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27512CAD18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404448AbgLAUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:13:26 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F1C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:12:40 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id k11so1874273pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GY9q7Q3SEs+LZ5nsgUd0mJEof5WxA7fLTd/LB+B0AYc=;
        b=n8Ra7U76Np/V2wMEwjTjxpX/NywIXiuFKfn1Q+Vs0h4Xeuh1g5rzA5Z+Bsv+159wr3
         J0cT50RsLNpi2vqF9yGNV+u4ahGAhQ3tUOPGn9Grwcnc0+XuhOWwkT6gWhw0z+uNrbrM
         EDCe9Nw57SnXQmuCNuyciNSo6NM/aF+stNuBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GY9q7Q3SEs+LZ5nsgUd0mJEof5WxA7fLTd/LB+B0AYc=;
        b=ltMuOFcUdXOjPI9lKa0q8p+LLQPnGxv66Gujd21dlKHolFA77qpNHDda0Qd9TOwoKo
         U/SFx/g+MP62/ezpdK9AgrFaHakbjmO6k0d6wcKkupx0mHUVhc1a94CtUprbSJKvzsbV
         0ytbqJ79zaMfsUCuWj0HZax/IlDSF5Fi9k7DM08GWTwnMS2hNeObcJr9Thd27C6kT0Rt
         nDhNqpie/LmAse5Tm/UlU1exEFIFDYSIoZobM8plnHCq6QA5xTlUQY3LN6Asf3S7xx8V
         3aEZOS4F+0ngUIyblfZKCl2Nem0Pi+eiIwCfkUsRhm9MXkD1/xvgXboAus1h6XVlZUVa
         zhVw==
X-Gm-Message-State: AOAM5300Qm+au5QhHj2LkeEt4WXpWJHWvg1/EJU1yZ/AYRqiX5ORgDH2
        Wbo7NEWUuokzsJPSXihG7GL6Ug==
X-Google-Smtp-Source: ABdhPJzTpGe05hQLK+1ccdnHuSr5Wi4dvijrv3VlnojWQYlRl1cz/N2PkOpHbnNPMfOS/e2YU1QM9Q==
X-Received: by 2002:a63:4703:: with SMTP id u3mr3595226pga.199.1606853560488;
        Tue, 01 Dec 2020 12:12:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm414129pgv.53.2020.12.01.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:12:39 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Vasile-Laurentiu Stanimir 
        <vasile-laurentiu.stanimir@windriver.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: Move kmsg_bytes default into Kconfig
Date:   Tue,  1 Dec 2020 12:12:34 -0800
Message-Id: <20201201201234.137572-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=5188d80bb08a7429f2821faecd7e4b8f43335a49; i=qXzl4k9if/tqI+qf9sQSdobkw8F/B4XyfRu25EvzWHg=; m=UaQeAnVdS9JxENrU7lkMv8luMkCW5fcEeUURc6i7C+Y=; p=7kXwmTRpUr5d8jARB34wGbgj6tGEH7YchKsTFqtUZac=
X-Patch-Sig: m=pgp; i=vasile-laurentiu.stanimir@windriver.com; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAl/Go7EACgkQiXL039xtwCYoUw/+PqU OxiNDgwBhi+xR0QSi02CzJmYwkaPzwZKelq1VvilrOMCkoP7aIjqZ3hmakASGsNyCadEMeCoigkwS BICa0jWYtDhOBe5cTYiTbKdYg7WmWuiLDC0x9zYiCL+LpBRa6ksVBAZFO7v848+j6lUMcFVUi7SAC x69FYCn98H2MlAlgS3CH4N+oOlclW/qz0X9RT3cLjDYPzwQf65e5S3pYlLgRjpnjv3PP3PTnWCkN0 fDPH078DIjXRkqSg4Nf4/RboYnVS8x+AB4GVM6KIIQmkPkSs1VRl8EVGbEV/ym9Z8yMWR24f2hrwj X0NesgKTYBptEGXsOsKWORLFAtQq9iDBfyInEO9hMYvScRHa4UO5V8yHAJOMllaibt4yzGflrnmd5 mZafCpzs35iASmtlWjT0rlvpsufN6U5bp1ncTUSO1gVrPstF5IhmKwLWyhDfezP+X8nxoi7ukiFgh 0Ai+js6W+XvQ4A3ck8rUcktT6Rxo3FIqMiP0miWCmmpi57sG+YzozbS3pTAqbFNgLEjOYEtUVgCG8 mTyZh3oV7t7MG5s7jhyASFJXN2aWYLAtXlP8Ci6S2G/JMaQYbtQmNAFRqMhDVRgWqD2pn69eLXXD3 IMc4oC7CVozpDAJz1hcCLPhI2ORYmDCkIvQ2kuCbSHh1JLryphPIfuvwWuBXOMEE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasile-Laurentiu Stanimir <vasile-laurentiu.stanimir@windriver.com>

While kmsg_bytes can be set for pstore via mount, if a crash occurs
before the mount only partial console log will be stored as kmsg_bytes
defaults to a potentially different hardcoded value in the kernel
(PSTORE_DEFAULT_KMSG_BYTES). This makes it impossible to analyze valuable
post-mortem data especially on the embedded development or in the process
of bringing up new boards. Change this value to be a Kconfig option
with the default of old PSTORE_DEFAULT_KMSG_BYTES

Signed-off-by: Vasile-Laurentiu Stanimir <vasile-laurentiu.stanimir@windriver.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This was sent off-list, so I'm resending it to lkml (with the commit log
cleaned up sligthly) before I push it into for-next/pstore.
---
 fs/pstore/Kconfig    | 8 ++++++++
 fs/pstore/inode.c    | 2 +-
 fs/pstore/internal.h | 1 -
 fs/pstore/platform.c | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index e16a49ebfe54..8adabde685f1 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -14,6 +14,14 @@ config PSTORE
 	   If you don't have a platform persistent store driver,
 	   say N.
 
+config PSTORE_DEFAULT_KMSG_BYTES
+	int "Default kernel log storage space" if EXPERT
+	depends on PSTORE
+	default "10240"
+	help
+	  Defines default size of pstore kernel log storage.
+	  Can be enlarged if needed, not recommended to shrink it.
+
 config PSTORE_DEFLATE_COMPRESS
 	tristate "DEFLATE (ZLIB) compression"
 	default y
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index c331efe8de95..93a217e4f563 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -266,7 +266,7 @@ static void parse_options(char *options)
  */
 static int pstore_show_options(struct seq_file *m, struct dentry *root)
 {
-	if (kmsg_bytes != PSTORE_DEFAULT_KMSG_BYTES)
+	if (kmsg_bytes != CONFIG_PSTORE_DEFAULT_KMSG_BYTES)
 		seq_printf(m, ",kmsg_bytes=%lu", kmsg_bytes);
 	return 0;
 }
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 7fb219042f13..801d6c0b170c 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -6,7 +6,6 @@
 #include <linux/time.h>
 #include <linux/pstore.h>
 
-#define PSTORE_DEFAULT_KMSG_BYTES 10240
 extern unsigned long kmsg_bytes;
 
 #ifdef CONFIG_PSTORE_FTRACE
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 36714df37d5d..32f64abc277c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -101,7 +101,7 @@ static char *big_oops_buf;
 static size_t big_oops_buf_sz;
 
 /* How much of the console log to snapshot */
-unsigned long kmsg_bytes = PSTORE_DEFAULT_KMSG_BYTES;
+unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
 
 void pstore_set_kmsg_bytes(int bytes)
 {
-- 
2.25.1

