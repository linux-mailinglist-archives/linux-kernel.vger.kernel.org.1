Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BE92CA775
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgLAPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgLAPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:51:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47DAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:50:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lt17so5104099ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auGCW8YPbdZIzROZxR8+D5j3oe46Hbfhflky1HlmyJ4=;
        b=Vu69Rm/PpP4+agRnCbvTZQUVwDvMcN3v0YOZTSNwKI84ozuFFxhmsSANQtv6BiZBhE
         9e6q1G6IzzWrldrlz070rHHo8+enJq7LdoOzWTjwOTM8l5shY/OAIbGIkRUEpe2Avqtk
         tC9RN81jSyxUHqVqBHBPpGs5abySmrXNXcBuHX4nXmT7KjzMAIYJ59fcuOuXkMw9wQSW
         Wn0LioBCovKYJJueQ23spsQpRh/1l7XzEgJrOu200WppDKsCd2CClp0oKXXueQaRcKkG
         F8k17h0ZN73GgNhN2KmDiljyw+eHsO8ij4NuV6uHUbKURolF7SA6Zo2FKqU/QrKpGAHv
         p7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=auGCW8YPbdZIzROZxR8+D5j3oe46Hbfhflky1HlmyJ4=;
        b=O/2PqtzAvVodb/sGhsXhHJz7iupeRg1JRffWWQivKAYzUYijPRNKuuWf8YMUkH9DOQ
         VlIKe4glvw59KeZd1ghxChbKdXVhj/blHNnLEObNEL9TgOrOCoe8dRtdaKurfO/Qts7q
         zMDEXq6P8w+8wq77eEzBdhuMv9MYJ9Rhkj4p0cWhrN0N/cpZTqyeQSWchuFll6yIIuaz
         Evr1jPphGWxlvsIX1pyvF28rT4f/sMFfJF6Jh9lXMzDBj7qet+3VpzLTRqbxVD89sz91
         3uRslB94qhE5szxiR+PtzxYwtPs5WNYGHLAAwbBoxb1PDgUcDIWIcPo7AadRl11j6bcC
         avsA==
X-Gm-Message-State: AOAM532eKl8vtIGvBkGSnX5GqcaPCNebesHaqakp98R6Q9WF17mgh0bG
        edS1KRGi1EOQznQyAzKq3wYcbSFee1Fa0Lbs
X-Google-Smtp-Source: ABdhPJwuEQ48Xec2+XfXLGR6wImi7HNFDVsumFNBhSRhUWFZmNJJTAyrpiLybjevhIT0Qo1vzJvr6Q==
X-Received: by 2002:a17:907:20cc:: with SMTP id qq12mr3788761ejb.316.1606837833206;
        Tue, 01 Dec 2020 07:50:33 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s12sm123090edu.28.2020.12.01.07.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 07:50:32 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] firmware: xilinx: Add a blank line after function declaration
Date:   Tue,  1 Dec 2020 16:50:25 +0100
Message-Id: <7b6007e05f6c01214861a37f198cd5bee62a4d3e.1606837822.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606837822.git.michal.simek@xilinx.com>
References: <cover.1606837822.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all these issues which are also reported by checkpatch --strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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

