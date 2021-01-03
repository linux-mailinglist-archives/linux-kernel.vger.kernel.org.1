Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B262E8BDE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 12:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhACLHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 06:07:55 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34337 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbhACLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 06:07:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C5760542;
        Sun,  3 Jan 2021 06:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 06:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eiXmcA+mRsHUH
        aYx5zquPjpU06fK14Zb7hMHBXjnmy8=; b=amYS3bs3zSCXVyHRUQm64I2JXGUjy
        kzs4a6MoHvoyY0ylnkvzOAgUATaYmmNZLT6cpsIWn95Hs8/XFOQTSblwQdF5mEwc
        i3bS4bUrxIO3Ss9vkuq/jUCe58xHPIipjeIzMVf18WHYOogEw1hRXlGbIZRLcP7t
        +wQa7oBby8Dkia+iFwGKoVlHz3g1zuP4X8wtUqHKigf7bd7oUG3HrneeFUKPZHpo
        ciHnAvtU4+QNTMe+U1hl+/nJ65dGmhPjCwSTx0YrdXFJtCIMvp7thhpXcef2gtw6
        HOdmO5WJD+UTJ2PhJaG8qZaFOs9XI+SNoafLd4t6w/1UEw0EGrEmgpODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eiXmcA+mRsHUHaYx5zquPjpU06fK14Zb7hMHBXjnmy8=; b=AT+16bHI
        qzNOfY8w/++x4R0+Zt3H7qDDracIhDEDbl+r2ESVlH5GJM+mqyztW0mXok8udn/R
        yrcfULwrLpzOTtRr06v4xNvcSoUc/p/+RAv+lrxiv6eVZwSf4QUxKRE4fLHWXSRg
        uP0KYeWvKgwWKXsgdnUzELkbl03bukGNRniGHB/SpR3sNfrZmYAPVn5vh2f9FmWT
        U93FQ8HXztIKUkqGKuLseMFWouvnjLFVqjQ0F27yF6TEWtRv+v6BrDcE0D2hD9OS
        V3UvfUZsOAt5qyKXB6meP111YXLll2xWFIfCCF7oALjmAE+vDZtPUYkkommCaubL
        7QwIf7Qz/zxCWA==
X-ME-Sender: <xms:PaXxX3WiaoNB27KVVSAGN03DxKdFspTzX41EtACxGzK5xCSiW-xuSw>
    <xme:PaXxX_llLkSEWUl9cWGB4yTpMrrozfy7fx3fe0chJARjdBDH6gYmR9_cg_hmxfMq8
    BvEvalVxQMWip26Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:PaXxXzZ5S55n9nTlxEKG5njACIXfS5pDpGweAfrRHYz7j1nOOluIvg>
    <xmx:PaXxXyWMtAvDftKQPZqijj-1rty5W1Kbj9fJtXDSAiK6i6Z4Z4-Dfw>
    <xmx:PaXxXxmuKLZI4hALCFhsp3O8Ad7Quj7PFy2Vg1bM5BRdstI4KBOvPA>
    <xmx:PqXxX0tUHKlFrwXUyL5Sl7TEIKT62yLLqGA5h50SN382DEoNr0wl_Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22FF524005E;
        Sun,  3 Jan 2021 06:06:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/4] bus: sunxi-rsb: Implement suspend/resume/shutdown callbacks
Date:   Sun,  3 Jan 2021 05:06:34 -0600
Message-Id: <20210103110635.34823-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103110635.34823-1-samuel@sholland.org>
References: <20210103110635.34823-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since system firmware is likely to use the RSB bus to communicate with a
PMIC while the system is suspended, we cannot make any assumptions about
the controller state after resuming. Thus it is important to completely
reinitialize the controller.

The RSB bus needs to be ready as soon as IRQs are enabled, to handle
wakeup event IRQs coming from the PMIC. Thus it uses NOIRQ callbacks.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bus/sunxi-rsb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 3f290da45619..efd222f36cdc 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -45,6 +45,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -675,6 +676,22 @@ static void sunxi_rsb_hw_exit(struct sunxi_rsb *rsb)
 	clk_disable_unprepare(rsb->clk);
 }
 
+static int __maybe_unused sunxi_rsb_suspend(struct device *dev)
+{
+	struct sunxi_rsb *rsb = dev_get_drvdata(dev);
+
+	sunxi_rsb_hw_exit(rsb);
+
+	return 0;
+}
+
+static int __maybe_unused sunxi_rsb_resume(struct device *dev)
+{
+	struct sunxi_rsb *rsb = dev_get_drvdata(dev);
+
+	return sunxi_rsb_hw_init(rsb);
+}
+
 static int sunxi_rsb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -756,6 +773,17 @@ static int sunxi_rsb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void sunxi_rsb_shutdown(struct platform_device *pdev)
+{
+	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
+
+	sunxi_rsb_hw_exit(rsb);
+}
+
+static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sunxi_rsb_suspend, sunxi_rsb_resume)
+};
+
 static const struct of_device_id sunxi_rsb_of_match_table[] = {
 	{ .compatible = "allwinner,sun8i-a23-rsb" },
 	{}
@@ -765,9 +793,11 @@ MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
 static struct platform_driver sunxi_rsb_driver = {
 	.probe = sunxi_rsb_probe,
 	.remove	= sunxi_rsb_remove,
+	.shutdown = sunxi_rsb_shutdown,
 	.driver	= {
 		.name = RSB_CTRL_NAME,
 		.of_match_table = sunxi_rsb_of_match_table,
+		.pm = &sunxi_rsb_dev_pm_ops,
 	},
 };
 
-- 
2.26.2

