Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21332BA6DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgKTJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgKTJ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:59:05 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE7722240;
        Fri, 20 Nov 2020 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866344;
        bh=/9Svc1nB4x4FQpTn7Lh51eg63FO1h5B4OU0Pfe7eNec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wJtvxMFtDr40TCmI+wTiQIU2yKxHb8Jp3i/Ci+irezyklhocG0CV+5L7Xx7DEPAE9
         86BPbtTyVEgag5qIdvDQRBG4jMeZV10ZbTKDynFeOMfsIv31QoSAZ49MOMowo4j8lc
         8sZhm0o2zr5UIgNt79JWXQt4QMgVbk6V/hwxt6YU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg3C2-00CDVO-29; Fri, 20 Nov 2020 09:59:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Nov 2020 09:59:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io, Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.dmesg.emerg on meson-gxbb-p200
In-Reply-To: <93dcf61a-be80-8870-48f5-30e215cc56ed@baylibre.com>
References: <5fb5e094.1c69fb81.a2014.2e62@mx.google.com>
 <a0bec7c4-9bec-8858-4879-52f4688d9992@collabora.com>
 <630e00e83cdd07ee5a0eaba9d3479554@kernel.org>
 <3f54de27-0fef-c5a1-8991-0a0614c90667@baylibre.com>
 <c76273f5fe483766e6a7f509f82d928a@kernel.org>
 <f59922c6-69f5-c70e-b424-0659bf91a4fd@collabora.com>
 <1jr1op8bbc.fsf@starbuckisacylon.baylibre.com>
 <00a10c12a4eb2a9cdd9f50e88a293c3f@kernel.org>
 <93dcf61a-be80-8870-48f5-30e215cc56ed@baylibre.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <45c711c9d5fb5ef0e3b80e82b10f5998@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: narmstrong@baylibre.com, jbrunet@baylibre.com, guillaume.tucker@collabora.com, kernelci-results@groups.io, khilman@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com, airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-20 09:26, Neil Armstrong wrote:
> On 19/11/2020 19:35, Marc Zyngier wrote:
>>>>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c 
>>>>> b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>>>>> index 7f8eea494147..52af8ba94311 100644
>>>>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>>>>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>>>>> @@ -146,6 +146,7 @@ struct meson_dw_hdmi {
>>>>>      struct reset_control *hdmitx_ctrl;
>>>>>      struct reset_control *hdmitx_phy;
>>>>>      struct clk *hdmi_pclk;
>>>>> +    struct clk *iahb_clk;
>>>>>      struct clk *venci_clk;
>>>>>      struct regulator *hdmi_supply;
>>>>>      u32 irq_stat;
>>>>> @@ -1033,6 +1034,13 @@ static int meson_dw_hdmi_bind(struct device 
>>>>> *dev, struct device *master,
>>>>>      }
>>>>>      clk_prepare_enable(meson_dw_hdmi->hdmi_pclk);
>>>>> 
>>>>> +    meson_dw_hdmi->iahb_clk = devm_clk_get(dev, "iahb");
>>>>> +    if (IS_ERR(meson_dw_hdmi->iahb_clk)) {
>>>>> +        dev_err(dev, "Unable to get iahb clk\n");
>>>>> +        return PTR_ERR(meson_dw_hdmi->iahb_clk);
>>>>> +    }
>>>>> +    clk_prepare_enable(meson_dw_hdmi->iahb_clk);
> 
> 
> On previous SoCs, iahb was directly the bus clock (clk81), and on 
> recent socs
> this clock is a gate.
> 
> The question is why is it disabled. Maybe a previous failed probe 
> disabled it
> in the dw-hdmi probe failure code and this clock is needed for
> meson_dw_hdmi_init(),
> so yeah this is the right fix.
> 
> Thanks.
> 
> Could you send a revert of b33340e33acdfe5ca6a5aa1244709575ae1e0432
> and then proper fix with clk_disable_unprepare added ?

Bah. I missed that email and sent a slightly different resolution.
Hopefully that'll be good enough.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
