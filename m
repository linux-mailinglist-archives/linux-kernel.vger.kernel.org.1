Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CFF2CB5D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgLBHjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgLBHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:39:43 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC8C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:39:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ga15so1996915ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPSb3LIXJz9yjgJuLrgI8qtwWP2+jAOV2L+weq9SiGc=;
        b=1qcWbxe3PwuoM4G/LqobEBCACzqr7bqIiRseFwkSh8f3G28rPFSXqlM/eWggABlxJ1
         N/MwazYOIzkccw9wRp7nZ66lZWmfoDhHKCxyTO95rPZOv4QwF78l2LdILilJOJ7AUktN
         LBqL/0CHIhoz0woKY+hNwhVsTVlYEK9QlZ+MbHKLVLikYpioVuBzxU2WRor+8IYkJR5s
         cLqnfSrCUt2idTGuwgU4/lMALi5iZ3nx0fCulKoYxfqUkU6gSVaqqCS4cjsShnmneMST
         omC4b7nZbNaPvmIAcd8uP7iZAUzfW4EqXnUGvE/w1Eu3L54h67PEVdTB9RlGXfKO0jFk
         hY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mPSb3LIXJz9yjgJuLrgI8qtwWP2+jAOV2L+weq9SiGc=;
        b=WqMFj4whJWaPEKknVX4Esz019SbdvwEe2/OFNWVA0IbVT8jCu4LAXRMhohJBRedyBX
         14QfCAdztxHvHA5bXEbcTjcXtWlbhvcXwb1IfzRzlNUV0B0IDowjIyNgp9i8Lv4cO/ho
         le60xtvJHv6RK6cOYEfwdO5De0jZG1sRQ1TGlx3Z53+aqNDchHitfPVOFTNnXQKsRnAr
         ilHov4d8qNknhhwwE+ykyrLHFF0P04DiyGFS0l3OSoSEsdFETHTNVkI46Hd0hBi+S6QJ
         kaYGVacR41YaEsdLr95hBvbLoOj75oRZWuSiY2B6REXGe/CXiAZF7FK/PTDwhVXdgQ1Y
         B2Yw==
X-Gm-Message-State: AOAM533jibOIMhjV9gwWTaQWCKjB/WZc1EikWFDupW+79gw0BpFLIGHR
        heWoQVoanAc75bX/0xgEBqtdRBaHsiqt/CHl
X-Google-Smtp-Source: ABdhPJyUnEbYEgWI4g5iaY+v4XaJ40wBO5Eq1lpSY2XyT8na+eiyqDtEtscqx4djZP79FMi2Di5rhQ==
X-Received: by 2002:a17:906:710b:: with SMTP id x11mr1139536ejj.433.1606894740930;
        Tue, 01 Dec 2020 23:39:00 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id u1sm538945edf.65.2020.12.01.23.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 23:39:00 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] firmware: xilinx: Add a blank line after function declaration
Date:   Wed,  2 Dec 2020 08:38:49 +0100
Message-Id: <7b6007e05f6c01214861a37f198cd5bee62a4d3e.1606894725.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606894725.git.michal.simek@xilinx.com>
References: <cover.1606894725.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all these issues which are also reported by checkpatch --strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

(no changes since v1)

 include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 0db9005782d6..0e7e72650ed3 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -363,107 +363,132 @@ static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
 	return ERR_PTR(-ENODEV);
 }
+
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
 				       u32 *out)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_enable(u32 clock_id)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_disable(u32 clock_id)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 					     u32 *status)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_init_finalize(void)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_set_suspend_mode(u32 mode)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 					 const u32 qos,
 					 const enum zynqmp_pm_request_ack ack)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_release_node(const u32 node)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_set_requirement(const u32 node,
 					const u32 capabilities,
 					const u32 qos,
@@ -471,39 +496,48 @@ static inline int zynqmp_pm_set_requirement(const u32 node,
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_fpga_load(const u64 address, const u32 size,
 				      const u32 flags)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_fpga_get_status(u32 *value)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_read_ggs(u32 index, u32 *value)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_write_pggs(u32 index, u32 value)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
 	return -ENODEV;
 }
+
 static inline int zynqmp_pm_set_boot_health_status(u32 value)
 {
 	return -ENODEV;
-- 
2.29.2

