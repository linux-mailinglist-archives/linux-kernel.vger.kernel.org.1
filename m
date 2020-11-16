Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5DF2B40E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgKPKTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgKPKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDE92419B;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=f9tWm2JzuB3ZU4Tr7DYnkDGWstm1h/bF75LW7XM/DrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdrNreE4lLWpQcvJy5TpYVHWJLldjWvGlyF/8hnb2aM6/S4rl290qC1FD8qsZijn+
         nR+hQeX0SQ/3RESWyzSaxjOni0QC6nxWg2MLMtnsG3sdqHe2k+5Up60aGGLl/DRjoP
         +LZPjrCsrVePwdfgU09GyL7pWAtTezcSc+wQp9jM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEi-K5; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 22/27] w1: fix a kernel-doc markup
Date:   Mon, 16 Nov 2020 11:18:18 +0100
Message-Id: <5acc0c56219589ffcd0a1d5a816f6df79ed6349c.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A function has a different name between their prototype
and its kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/w1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 949d3b10e531..9a2a0ef39018 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -263,41 +263,41 @@ struct w1_family_ops {
  * @fid:		8 bit family identifier
  * @fops:		operations for this family
  * @of_match_table: open firmware match table
  * @refcnt:		reference counter
  */
 struct w1_family {
 	struct list_head	family_entry;
 	u8			fid;
 
 	const struct w1_family_ops *fops;
 
 	const struct of_device_id *of_match_table;
 
 	atomic_t		refcnt;
 };
 
 int w1_register_family(struct w1_family *family);
 void w1_unregister_family(struct w1_family *family);
 
 /**
- * module_w1_driver() - Helper macro for registering a 1-Wire families
+ * module_w1_family() - Helper macro for registering a 1-Wire families
  * @__w1_family: w1_family struct
  *
  * Helper macro for 1-Wire families which do not do anything special in module
  * init/exit. This eliminates a lot of boilerplate. Each module may only
  * use this macro once, and calling it replaces module_init() and module_exit()
  */
 #define module_w1_family(__w1_family) \
 	module_driver(__w1_family, w1_register_family, \
 			w1_unregister_family)
 
 u8 w1_triplet(struct w1_master *dev, int bdir);
 u8 w1_touch_bit(struct w1_master *dev, int bit);
 void w1_write_8(struct w1_master *, u8);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
 void w1_touch_block(struct w1_master *, u8 *, int);
 u8 w1_read_block(struct w1_master *, u8 *, int);
 int w1_reset_select_slave(struct w1_slave *sl);
-- 
2.28.0

