Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26902B9A55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgKSSE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:04:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKSSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:04:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id C26961F45AC6
Subject: Re: next/master bisection: baseline.dmesg.emerg on meson-gxbb-p200
To:     Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     kernelci-results@groups.io, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <5fb5e094.1c69fb81.a2014.2e62@mx.google.com>
 <a0bec7c4-9bec-8858-4879-52f4688d9992@collabora.com>
 <630e00e83cdd07ee5a0eaba9d3479554@kernel.org>
 <3f54de27-0fef-c5a1-8991-0a0614c90667@baylibre.com>
 <c76273f5fe483766e6a7f509f82d928a@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <f59922c6-69f5-c70e-b424-0659bf91a4fd@collabora.com>
Date:   Thu, 19 Nov 2020 18:04:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <c76273f5fe483766e6a7f509f82d928a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 19/11/2020 11:58, Marc Zyngier wrote:
> On 2020-11-19 10:26, Neil Armstrong wrote:
>> On 19/11/2020 11:20, Marc Zyngier wrote:
>>> On 2020-11-19 08:50, Guillaume Tucker wrote:
>>>> Please see the automated bisection report below about some kernel
>>>> errors on meson-gxbb-p200.
>>>>
>>>> Reports aren't automatically sent to the public while we're
>>>> trialing new bisection features on kernelci.org, however this one
>>>> looks valid.
>>>>
>>>> The bisection started with next-20201118 but the errors are still
>>>> present in next-20201119.  Details for this regression:
>>>>
>>>>   https://kernelci.org/test/case/id/5fb6196bfd0127fd68d8d902/
>>>>
>>>> The first error is:
>>>>
>>>>   [   14.757489] Internal error: synchronous external abort: 96000210
>>>> [#1] PREEMPT SMP
>>>
>>> Looks like yet another clock ordering setup. I guess different Amlogic
>>> platforms have slightly different ordering requirements.
>>>
>>> Neil, do you have any idea of which platform requires which ordering?
>>> The variability in DT and platforms is pretty difficult to follow (and
>>> I don't think I have such board around).
>>
>> The requirements should be the same, here the init was done before calling
>> dw_hdmi_probe to be sure the clocks and internals resets were deasserted.
>> But since you boot from u-boot already enabling these, it's already active.
>>
>> The solution would be to revert and do some check in meson_dw_hdmi_init() to
>> check if already enabled and do nothing.
> 
> A better fix seems to be this, which makes it explicit that there is
> a dependency between some of the registers accessed from meson_dw_hdmi_init()
> and the iahb clock.
> 
> Guillaume, can you give this a go on your failing box?

I confirm it solves the problem.  Please add this to your fix
patch if it's OK with you:

  Reported-by: "kernelci.org bot" <bot@kernelci.org>
  Tested-by: Guillaume Tucker <guillaume.tucker@collabora.com>


For the record, it passed all the tests when applied on top of
the "bad" revision found by the bisection:

  http://lava.baylibre.com:10080/scheduler/alljobs?search=v5.10-rc3-1021-gb8668a2e5ea1

and the exact same test on the "bad" revision without the fix
consistently showed the error:

  http://lava.baylibre.com:10080/scheduler/job/374176


Thanks,
Guillaume


> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 7f8eea494147..52af8ba94311 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -146,6 +146,7 @@ struct meson_dw_hdmi {
>      struct reset_control *hdmitx_ctrl;
>      struct reset_control *hdmitx_phy;
>      struct clk *hdmi_pclk;
> +    struct clk *iahb_clk;
>      struct clk *venci_clk;
>      struct regulator *hdmi_supply;
>      u32 irq_stat;
> @@ -1033,6 +1034,13 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>      }
>      clk_prepare_enable(meson_dw_hdmi->hdmi_pclk);
> 
> +    meson_dw_hdmi->iahb_clk = devm_clk_get(dev, "iahb");
> +    if (IS_ERR(meson_dw_hdmi->iahb_clk)) {
> +        dev_err(dev, "Unable to get iahb clk\n");
> +        return PTR_ERR(meson_dw_hdmi->iahb_clk);
> +    }
> +    clk_prepare_enable(meson_dw_hdmi->iahb_clk);
> +
>      meson_dw_hdmi->venci_clk = devm_clk_get(dev, "venci");
>      if (IS_ERR(meson_dw_hdmi->venci_clk)) {
>          dev_err(dev, "Unable to get venci clk\n");
> @@ -1071,6 +1079,8 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
> 
>      encoder->possible_crtcs = BIT(0);
> 
> +    meson_dw_hdmi_init(meson_dw_hdmi);
> +
>      DRM_DEBUG_DRIVER("encoder initialized\n");
> 
>      /* Bridge / Connector */
> @@ -1095,8 +1105,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>      if (IS_ERR(meson_dw_hdmi->hdmi))
>          return PTR_ERR(meson_dw_hdmi->hdmi);
> 
> -    meson_dw_hdmi_init(meson_dw_hdmi);
> -
>      next_bridge = of_drm_find_bridge(pdev->dev.of_node);
>      if (next_bridge)
>          drm_bridge_attach(encoder, next_bridge,
> 
> 

