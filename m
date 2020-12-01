Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0246C2CA232
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgLAMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbgLAMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:37 -0500
Received: from mail.kernel.org (unknown [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D22B217A0;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=vGmcDXA03lfxieNTlcRhqrC56dAdlluWJz5B0nNYBiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTuTIs3i7FNZ0EU21Mm0jhlJJaar0QlljykEPlH7OZZJNGMS683h6dTedsxNGr8Jm
         F5XQ8Xi5KSuxShcQ6ARbPW32QQl28L+WlNZloX4kLYQekJhC1/bjSie3wekVjmISjl
         HO6UGXej3gGoiYR907Zo+SZDnaMTkD+RRIbcGG98=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdK-6s; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/16] w1: fix a kernel-doc markup
Date:   Tue,  1 Dec 2020 13:09:05 +0100
Message-Id: <dff3c118118e1c1d8edc0d68da31f76abb210d4b.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
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
@@ -251,65 +251,65 @@ void w1_remove_master_device(struct w1_bus_master *master);
  * @chip_info: pointer to struct hwmon_chip_info
  */
 struct w1_family_ops {
 	int  (*add_slave)(struct w1_slave *sl);
 	void (*remove_slave)(struct w1_slave *sl);
 	const struct attribute_group **groups;
 	const struct hwmon_chip_info *chip_info;
 };
 
 /**
  * struct w1_family - reference counted family structure.
  * @family_entry:	family linked list
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
 int w1_reset_resume_command(struct w1_master *);
 void w1_next_pullup(struct w1_master *, int);
 
 static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
 {
 	return container_of(dev, struct w1_slave, dev);
 }
 
 static inline struct w1_slave* kobj_to_w1_slave(struct kobject *kobj)
 {
 	return dev_to_w1_slave(container_of(kobj, struct device, kobj));
 }
-- 
2.28.0

