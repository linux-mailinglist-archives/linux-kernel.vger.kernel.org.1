Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87412E8BDA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbhACLHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 06:07:25 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59135 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbhACLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 06:07:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A11D6275;
        Sun,  3 Jan 2021 06:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 06:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jb/i2UCQx+8gx
        zanVJoTiDULrP/D/wg+dgI19BaOfYw=; b=PpIotdJdBm+IVR5zlxpp2B3n9CJl5
        fuRVd5cjfAsauduynj0neXoA5X7bmNOpu51woYTKrPSR8sBxKOlAe73AuRnEEwey
        M4SpBPujimDLyRxkjHp3g2gMgwTDK59OxEbkoDjUTHvT016CY+28BT9eB37SdeLn
        qrV12aMfMPjBHOTkWBaNc3sLR6yKcLauy6WOHtK9zkHwb6fLJErkV+e+BhW17EgG
        cWFjIRMVozUPEaH13sBPPavd6rsYJOBSLc8s9cHR8CVItjJ7q1vGFNLigP6INfXh
        RnZiLOvliC1YdVFQzQFGgiNcEwg9F2Ai9e3JfZLbsuS32F2ZkVNX3FqXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jb/i2UCQx+8gxzanVJoTiDULrP/D/wg+dgI19BaOfYw=; b=UeKRgcDk
        SIJTG1gS4o7ajgL92w0LF+Ow7Zv42PKUjNK+2C53YqZH+BJljDmo8gC651zWlHsC
        lRUF/ZJoHCtkm9kRxjLktzd2Wnpa/8puQkh21ZXaKwDSFSma3Y0Rosg79jn1Ylzb
        Csar6zZtbXLaxhIpRR5W9MtSNfgK1qlHQwRXYkAMM6d9ycrL70ms7CN0itR/c8kq
        iu72esYwND960nBQIjIpvvOOTgjZnLjEB07djsT9xT2/+/7VehtGNmNDEQ3jZIlz
        wqlw0tW98cMJfF+aBkao5stJudDJ+VZ3Z3IHrldItPE8V0zXPwCgMGVFTMnIhSyK
        t9sKkh624J0mKA==
X-ME-Sender: <xms:PaXxXxjg-KFxymogylX9XBeWdpztJQnaYfFzJhBY1jMypLQu7SLk_w>
    <xme:PaXxX2AWYz5bwLeqT6PUQpF_DQlnJAs01yPjdbeWkO1UQqlTheNcGKUdPlWrZg-tG
    3jzhg6zAkIMr44plA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:PaXxXxEfK24cnoPaAFTBHlEBp93GObxptLXpXT2aaa6N4PlJJHnz3Q>
    <xmx:PaXxX2Ts1EzfnrugD_8DGpOSnMxJPeVXPfxg0ZobB9fBL-EXBr66Cg>
    <xmx:PaXxX-xCfuPjmFYFVOu_BFYX9cNAJsN98o-at8ZAem4NsIj008FieA>
    <xmx:PqXxX1rwSUQxLVn7MfzeNhrtB5hXLaV7UMmTfpOKsp8e2s8z1dmhdg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E125240062;
        Sun,  3 Jan 2021 06:06:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/4] bus: sunxi-rsb: Implement runtime power management
Date:   Sun,  3 Jan 2021 05:06:35 -0600
Message-Id: <20210103110635.34823-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103110635.34823-1-samuel@sholland.org>
References: <20210103110635.34823-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gate the clock to save power while the controller is idle.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bus/sunxi-rsb.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index efd222f36cdc..ba5100dfc413 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -46,6 +46,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -337,6 +338,10 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 		return -EINVAL;
 	}
 
+	ret = pm_runtime_resume_and_get(rsb->dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&rsb->lock);
 
 	writel(addr, rsb->regs + RSB_ADDR);
@@ -352,6 +357,9 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 unlock:
 	mutex_unlock(&rsb->lock);
 
+	pm_runtime_mark_last_busy(rsb->dev);
+	pm_runtime_put_autosuspend(rsb->dev);
+
 	return ret;
 }
 
@@ -379,6 +387,10 @@ static int sunxi_rsb_write(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 		return -EINVAL;
 	}
 
+	ret = pm_runtime_resume_and_get(rsb->dev);
+	if (ret)
+		return ret;
+
 	mutex_lock(&rsb->lock);
 
 	writel(addr, rsb->regs + RSB_ADDR);
@@ -389,6 +401,9 @@ static int sunxi_rsb_write(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 
 	mutex_unlock(&rsb->lock);
 
+	pm_runtime_mark_last_busy(rsb->dev);
+	pm_runtime_put_autosuspend(rsb->dev);
+
 	return ret;
 }
 
@@ -672,10 +687,29 @@ static int sunxi_rsb_hw_init(struct sunxi_rsb *rsb)
 
 static void sunxi_rsb_hw_exit(struct sunxi_rsb *rsb)
 {
+	/* Keep the clock and PM reference counts consistent. */
+	if (pm_runtime_status_suspended(rsb->dev))
+		pm_runtime_resume(rsb->dev);
 	reset_control_assert(rsb->rstc);
 	clk_disable_unprepare(rsb->clk);
 }
 
+static int __maybe_unused sunxi_rsb_runtime_suspend(struct device *dev)
+{
+	struct sunxi_rsb *rsb = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rsb->clk);
+
+	return 0;
+}
+
+static int __maybe_unused sunxi_rsb_runtime_resume(struct device *dev)
+{
+	struct sunxi_rsb *rsb = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(rsb->clk);
+}
+
 static int __maybe_unused sunxi_rsb_suspend(struct device *dev)
 {
 	struct sunxi_rsb *rsb = dev_get_drvdata(dev);
@@ -758,6 +792,12 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(dev, "Initialize device mode failed: %d\n", ret);
 
+	pm_suspend_ignore_children(dev, true);
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
 	of_rsb_register_devices(rsb);
 
 	return 0;
@@ -768,6 +808,7 @@ static int sunxi_rsb_remove(struct platform_device *pdev)
 	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
 
 	device_for_each_child(rsb->dev, NULL, sunxi_rsb_remove_devices);
+	pm_runtime_disable(&pdev->dev);
 	sunxi_rsb_hw_exit(rsb);
 
 	return 0;
@@ -777,10 +818,13 @@ static void sunxi_rsb_shutdown(struct platform_device *pdev)
 {
 	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
 	sunxi_rsb_hw_exit(rsb);
 }
 
 static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(sunxi_rsb_runtime_suspend,
+			   sunxi_rsb_runtime_resume, NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sunxi_rsb_suspend, sunxi_rsb_resume)
 };
 
-- 
2.26.2

