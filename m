Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F92CA5AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbgLAObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbgLAObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:31:17 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A88C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:30:04 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f9so4524901ejw.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WO5uI3wqo8BxEatZNnJUdmrNd6YvRjUl6nOzRzJj5ts=;
        b=tDivfi4snLHRZnjcpXGbIG3jOFgykooGKj6LDmom5rwgcJ9bA+LT4oCpxnNPitfgIG
         +gDkujk+ret3qH59dm5T9KNZG6TW/myRcKpl7HqRDHVL+zBvMLoZVGEy+wW/CIvmfYwm
         G1GFmktC6qroZT7miiE190NoI0L4AxnTx908dxDVVI0YjKjO/l0Uly+5Xau3B81c0MHK
         Z7oCNHTmNhVKdwTQQy9PMMQfdKazkGGVF2yc7sFYPKtayW7xWjSZcdVRiSFYCUPwP+0S
         SKkoFPx1a12mMXZlGTupySZD3sJvsEQswaSY56MqHQGU9Q9elTyagouVqDbzUL7Q9zS+
         WDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WO5uI3wqo8BxEatZNnJUdmrNd6YvRjUl6nOzRzJj5ts=;
        b=NJapZrLcn1QEMrsMt3NoYl6fi2GKaNRaa0derBpgm3rWdEsf/J9goda2VrfwaMKR1z
         z5GhL/yKEbr+y7hgR8cE81zi7LLPBketzUsQGnMFlsRDpRfVCvhzpN6OTjFCy322xNvn
         q7DYM1bZHCpEUfQ/uareSqZ8x85qoqZqwCDawr3IrKNxVP95wLza2ToKhSWQZtULHEcV
         XC4pz6B4ERfUduUM5L4MUhFLTLgiyiGBWGT64Ngga1z9V+0TtOERSRHdJAYHgvQss+1w
         khd++d0u+gwodiB/xoPyMK6nFD1vKHEYVvyXBsdH1x61EXflQ37Z5RORvtLBvNbDymPR
         dC8g==
X-Gm-Message-State: AOAM530ckb4Ni3ar3G37olIb0LeTO0/oGLe+FcpiC6nb7Ud3OK0cJaNH
        JKBy6Nj/yIdd4BvEf8Z7OiOcOBlYT/K1SsMr
X-Google-Smtp-Source: ABdhPJy6E1/hUVZhiVShCZ9UIUdnza6vjqzW8pG4frcVUCvFe94wBK0kPaiqudlfun797Xks+yQmBw==
X-Received: by 2002:a17:906:1405:: with SMTP id p5mr3206491ejc.282.1606833001611;
        Tue, 01 Dec 2020 06:30:01 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q5sm924676ejr.89.2020.12.01.06.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 06:30:01 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Ravi Patel <ravi.patel@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: xilinx: Fix kernel-doc warnings
Date:   Tue,  1 Dec 2020 15:29:59 +0100
Message-Id: <e606233d15bfdc594535dd34eb85472b42f61830.1606832997.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc is reporting some style issues. The patch is fixing them.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/firmware/xilinx/zynqmp.c | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d6f12c89c6f3..ddf8e4e72584 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -585,13 +585,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
 /**
  * zynqmp_pm_set_sd_tapdelay() -  Set tap delay for the SD device
  *
- * @node_id	Node ID of the device
- * @type	Type of tap delay to set (input/output)
- * @value	Value to set fot the tap delay
+ * @node_id:	Node ID of the device
+ * @type:	Type of tap delay to set (input/output)
+ * @value:	Value to set fot the tap delay
  *
  * This function sets input/output tap delay for the SD device.
  *
- * @return	Returns status, either success or error+reason
+ * Return:	Returns status, either success or error+reason
  */
 int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 {
@@ -603,12 +603,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
 /**
  * zynqmp_pm_sd_dll_reset() - Reset DLL logic
  *
- * @node_id	Node ID of the device
- * @type	Reset type
+ * @node_id:	Node ID of the device
+ * @type:	Reset type
  *
  * This function resets DLL logic for the SD device.
  *
- * @return	Returns status, either success or error+reason
+ * Return:	Returns status, either success or error+reason
  */
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
@@ -619,12 +619,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
 
 /**
  * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
- * @index	GGS register index
- * @value	Register value to be written
+ * @index:	GGS register index
+ * @value:	Register value to be written
  *
  * This function writes value to GGS register.
  *
- * @return      Returns status, either success or error+reason
+ * Return:      Returns status, either success or error+reason
  */
 int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
@@ -635,12 +635,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
 
 /**
  * zynqmp_pm_write_ggs() - PM API for reading global general storage (ggs)
- * @index	GGS register index
- * @value	Register value to be written
+ * @index:	GGS register index
+ * @value:	Register value to be written
  *
  * This function returns GGS register value.
  *
- * @return      Returns status, either success or error+reason
+ * Return:	Returns status, either success or error+reason
  */
 int zynqmp_pm_read_ggs(u32 index, u32 *value)
 {
@@ -652,12 +652,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
 /**
  * zynqmp_pm_write_pggs() - PM API for writing persistent global general
  *			     storage (pggs)
- * @index	PGGS register index
- * @value	Register value to be written
+ * @index:	PGGS register index
+ * @value:	Register value to be written
  *
  * This function writes value to PGGS register.
  *
- * @return      Returns status, either success or error+reason
+ * Return:	Returns status, either success or error+reason
  */
 int zynqmp_pm_write_pggs(u32 index, u32 value)
 {
@@ -669,12 +669,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
 /**
  * zynqmp_pm_write_pggs() - PM API for reading persistent global general
  *			     storage (pggs)
- * @index	PGGS register index
- * @value	Register value to be written
+ * @index:	PGGS register index
+ * @value:	Register value to be written
  *
  * This function returns PGGS register value.
  *
- * @return      Returns status, either success or error+reason
+ * Return:	Returns status, either success or error+reason
  */
 int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
@@ -685,12 +685,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
 /**
  * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
- * @value	Status value to be written
+ * @value:	Status value to be written
  *
  * This function sets healthy bit value to indicate boot health status
  * to firmware.
  *
- * @return      Returns status, either success or error+reason
+ * Return:	Returns status, either success or error+reason
  */
 int zynqmp_pm_set_boot_health_status(u32 value)
 {
@@ -899,10 +899,10 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_config);
  * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
  *			       master has initialized its own power management
  *
+ * Return: Returns status, either success or error+reason
+ *
  * This API function is to be used for notify the power management controller
  * about the completed power management initialization.
- *
- * Return: Returns status, either success or error+reason
  */
 int zynqmp_pm_init_finalize(void)
 {
-- 
2.29.2

