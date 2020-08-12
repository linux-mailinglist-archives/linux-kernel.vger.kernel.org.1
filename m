Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE3242C85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHLP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgHLP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10FEA22CF6;
        Wed, 12 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247820;
        bh=zZkjALYNm/iv28baBIJ8a2vHEnhIRNk9OZoPGceCxOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7ShRxrgOFRtqm07TAZz/cSvD7EqrRRJqLH8VxJEF+fsWDr3C/NdpoIaAaoGCsAcO
         JO8k5hghEr83HQATvGDS9Zt5ezDnzoz9Thg6ftVv11GsM3Y/ZqlgE8kMs7pp8/pOlW
         0npyJw6mC4VC6NoEH0/uwRFloyWj/dsvIGyU5OW0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t6E-4r; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/44] staging: mfd: hi6421-spmi-pmic: cleanup hi6421-spmi-pmic.h header
Date:   Wed, 12 Aug 2020 17:56:25 +0200
Message-Id: <e4cbbf10a84f06e845fe47f272265b1e3286b23c.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several external vars that are defined there, which
are not needed anymore.

Get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/mfd/hi6421-spmi-pmic.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index e0a8b50f95fc..1f986dd5f31c 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -63,34 +63,9 @@ struct hisi_pmic {
 	unsigned int g_extinterrupt_flag;
 };
 
-/* 0:disable; 1:enable */
-unsigned int get_uv_mntn_status(void);
-void clear_uv_mntn_resered_reg_bit(void);
-void set_uv_mntn_resered_reg_bit(void);
-
-/* Register Access Helpers */
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
 void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val);
 void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits);
-unsigned int hisi_pmic_reg_read(int addr);
-void hisi_pmic_reg_write(int addr, int val);
-void hisi_pmic_reg_write_lock(int addr, int val);
-int hisi_pmic_array_read(int addr, char *buff, unsigned int len);
-int hisi_pmic_array_write(int addr, char *buff, unsigned int len);
-extern int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list);
-extern int hisi_pmic_get_vbus_status(void);
-static inline u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg) { return 0; }
-static inline void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val) {}
-static inline void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits) {}
-static inline unsigned int hisi_pmic_reg_read(int addr) { return 0; }
-static inline void hisi_pmic_reg_write(int addr, int val) {}
-static inline void hisi_pmic_reg_write_lock(int addr, int val) {}
-static inline int hisi_pmic_array_read(int addr, char *buff, unsigned int len) { return 0; }
-static inline int hisi_pmic_array_write(int addr, char *buff, unsigned int len) { return 0; }
-static inline int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list) { return -1; }
-static inline int hisi_pmic_get_vbus_status(void) { return 1; }
-static inline u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg) { return 0; }
-static inline void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val) {}
 
 enum pmic_irq_list {
 	OTMP = 0,
@@ -110,4 +85,3 @@ enum pmic_irq_list {
 	PMIC_IRQ_LIST_MAX,
 };
 #endif		/* __HISI_PMIC_H */
-
-- 
2.26.2

