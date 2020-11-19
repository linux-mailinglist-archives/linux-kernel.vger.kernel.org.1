Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0882B91EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgKSL6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgKSL6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:58:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF0B2225B;
        Thu, 19 Nov 2020 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605787103;
        bh=CpurNvymhEWKV47Naleb+jCbGoAPm0c5mF+oQi1St9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QEL3+I9G3+7VCLlsQ9STWPFfiYIAuoxrLymg70K4sqH7rM2AmWzUgGRz15jJ3Ey9a
         WE/+P0J1pf7t9iqipB1tCA8Vdvb5rZGynKZ8jEO/0iQfTmcMYwpMdagMnR7jlYBjeY
         qNHoLfxYdRN2Z1j7jb3ftnFEBcB0o+pCDv1gDLF4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kfiZx-00BwVd-E7; Thu, 19 Nov 2020 11:58:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 19 Nov 2020 11:58:20 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.dmesg.emerg on meson-gxbb-p200
In-Reply-To: <3f54de27-0fef-c5a1-8991-0a0614c90667@baylibre.com>
References: <5fb5e094.1c69fb81.a2014.2e62@mx.google.com>
 <a0bec7c4-9bec-8858-4879-52f4688d9992@collabora.com>
 <630e00e83cdd07ee5a0eaba9d3479554@kernel.org>
 <3f54de27-0fef-c5a1-8991-0a0614c90667@baylibre.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <c76273f5fe483766e6a7f509f82d928a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: narmstrong@baylibre.com, guillaume.tucker@collabora.com, kernelci-results@groups.io, khilman@baylibre.com, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com, airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 10:26, Neil Armstrong wrote:
> On 19/11/2020 11:20, Marc Zyngier wrote:
>> On 2020-11-19 08:50, Guillaume Tucker wrote:
>>> Please see the automated bisection report below about some kernel
>>> errors on meson-gxbb-p200.
>>> 
>>> Reports aren't automatically sent to the public while we're
>>> trialing new bisection features on kernelci.org, however this one
>>> looks valid.
>>> 
>>> The bisection started with next-20201118 but the errors are still
>>> present in next-20201119.  Details for this regression:
>>> 
>>>   https://kernelci.org/test/case/id/5fb6196bfd0127fd68d8d902/
>>> 
>>> The first error is:
>>> 
>>>   [   14.757489] Internal error: synchronous external abort: 96000210
>>> [#1] PREEMPT SMP
>> 
>> Looks like yet another clock ordering setup. I guess different Amlogic
>> platforms have slightly different ordering requirements.
>> 
>> Neil, do you have any idea of which platform requires which ordering?
>> The variability in DT and platforms is pretty difficult to follow (and
>> I don't think I have such board around).
> 
> The requirements should be the same, here the init was done before 
> calling
> dw_hdmi_probe to be sure the clocks and internals resets were 
> deasserted.
> But since you boot from u-boot already enabling these, it's already 
> active.
> 
> The solution would be to revert and do some check in 
> meson_dw_hdmi_init() to
> check if already enabled and do nothing.

A better fix seems to be this, which makes it explicit that there is
a dependency between some of the registers accessed from 
meson_dw_hdmi_init()
and the iahb clock.

Guillaume, can you give this a go on your failing box?

Thanks,

         M.

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c 
b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 7f8eea494147..52af8ba94311 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -146,6 +146,7 @@ struct meson_dw_hdmi {
  	struct reset_control *hdmitx_ctrl;
  	struct reset_control *hdmitx_phy;
  	struct clk *hdmi_pclk;
+	struct clk *iahb_clk;
  	struct clk *venci_clk;
  	struct regulator *hdmi_supply;
  	u32 irq_stat;
@@ -1033,6 +1034,13 @@ static int meson_dw_hdmi_bind(struct device *dev, 
struct device *master,
  	}
  	clk_prepare_enable(meson_dw_hdmi->hdmi_pclk);

+	meson_dw_hdmi->iahb_clk = devm_clk_get(dev, "iahb");
+	if (IS_ERR(meson_dw_hdmi->iahb_clk)) {
+		dev_err(dev, "Unable to get iahb clk\n");
+		return PTR_ERR(meson_dw_hdmi->iahb_clk);
+	}
+	clk_prepare_enable(meson_dw_hdmi->iahb_clk);
+
  	meson_dw_hdmi->venci_clk = devm_clk_get(dev, "venci");
  	if (IS_ERR(meson_dw_hdmi->venci_clk)) {
  		dev_err(dev, "Unable to get venci clk\n");
@@ -1071,6 +1079,8 @@ static int meson_dw_hdmi_bind(struct device *dev, 
struct device *master,

  	encoder->possible_crtcs = BIT(0);

+	meson_dw_hdmi_init(meson_dw_hdmi);
+
  	DRM_DEBUG_DRIVER("encoder initialized\n");

  	/* Bridge / Connector */
@@ -1095,8 +1105,6 @@ static int meson_dw_hdmi_bind(struct device *dev, 
struct device *master,
  	if (IS_ERR(meson_dw_hdmi->hdmi))
  		return PTR_ERR(meson_dw_hdmi->hdmi);

-	meson_dw_hdmi_init(meson_dw_hdmi);
-
  	next_bridge = of_drm_find_bridge(pdev->dev.of_node);
  	if (next_bridge)
  		drm_bridge_attach(encoder, next_bridge,


-- 
Jazz is not dead. It just smells funny...
