Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3222CA228
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgLAMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgLAMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:09:56 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29CD92084C;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=7wlYHrSkc3UlyrB/zEVGZsYQuy7ZwlZrqJ7Cb0R2G+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=La4DEh7BHQrstbHn7RBp8VLdFxh23zpDSAcwAwvWHxrXatbKLz58yA2uJYaG2ZUqk
         l3pyBduLclFWDSaP1/4c1xX6YL66aVJEetKoUOXK+MFnNGt11XieRS/wd7CwR1bCPV
         PVaaZW5cEwt3diOoxo5ppJL9amwt0s5Q6elsBsVU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGd4-0W; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/16] pstore/zone: fix a kernel-doc markup
Date:   Tue,  1 Dec 2020 13:08:59 +0100
Message-Id: <65cf891b754cdcbbb8911ceea10ab56e8a92449d.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documented struct is psz_head and not psz_buffer.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/pstore/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 3ce89216670c..46a1610c06fa 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1,58 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Provide a pstore intermediate backend, organized into kernel memory
  * allocated zones that are then mapped and flushed into a single
  * contiguous region on a storage backend of some kind (block, mtd, etc).
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
 #include <linux/printk.h>
 #include <linux/fs.h>
 #include <linux/pstore_zone.h>
 #include <linux/kdev_t.h>
 #include <linux/device.h>
 #include <linux/namei.h>
 #include <linux/fcntl.h>
 #include <linux/uio.h>
 #include <linux/writeback.h>
 #include "internal.h"
 
 /**
- * struct psz_head - header of zone to flush to storage
+ * struct psz_buffer - header of zone to flush to storage
  *
  * @sig: signature to indicate header (PSZ_SIG xor PSZONE-type value)
  * @datalen: length of data in @data
  * @start: offset into @data where the beginning of the stored bytes begin
  * @data: zone data.
  */
 struct psz_buffer {
 #define PSZ_SIG (0x43474244) /* DBGC */
 	uint32_t sig;
 	atomic_t datalen;
 	atomic_t start;
 	uint8_t data[];
 };
 
 /**
  * struct psz_kmsg_header - kmsg dump-specific header to flush to storage
  *
  * @magic: magic num for kmsg dump header
  * @time: kmsg dump trigger time
  * @compressed: whether conpressed
  * @counter: kmsg dump counter
  * @reason: the kmsg dump reason (e.g. oops, panic, etc)
  * @data: pointer to log data
  *
  * This is a sub-header for a kmsg dump, trailing after &psz_buffer.
  */
 struct psz_kmsg_header {
 #define PSTORE_KMSG_HEADER_MAGIC 0x4dfc3ae5 /* Just a random number */
 	uint32_t magic;
 	struct timespec64 time;
 	bool compressed;
 	uint32_t counter;
-- 
2.28.0

