Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD632B9114
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKSLdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgKSLdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:33:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB7A20867;
        Thu, 19 Nov 2020 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605785589;
        bh=IwzuzZJdgwM/mSCg/YGq4DFiccAa0AMjMOfLhF3JG8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KSMYoLedOZpStbTVjCff3VA/bScZg/ZBa6KN2hth62ft0nkMImZm0kHTF5TDUuxCj
         8rQwrf/w655P5dRXoelEcF1FC8r9D+7nMXVCDEv3HaDhKKjvQJ9u9NmQg1lZbGu2BT
         Z8cIAWKKIxlLFh7MZ+3urSr8owbFL0odZfYyGCpI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kfiBW-00Bw2g-MO; Thu, 19 Nov 2020 11:33:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 19 Nov 2020 11:33:06 +0000
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
Message-ID: <48731911dbbe869a6d3bdafd819fa9ff@kernel.org>
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

The crashing platform also boots with u-boot. What is the difference?
No HDMI support?

> The solution would be to revert and do some check in 
> meson_dw_hdmi_init() to
> check if already enabled and do nothing.

It looks more subtle than that, as it also depends on which DT is 
provided
(an early meson_dw_hdmi_init() works with the kernel DT, and breaks with 
the
u-boot DT). So whatever difference is between the two DTs causes havoc.
u-boot obviously only uses its own DT, so we are looking at a kernel bug 
here.

Not having this patch also breaks module reinsertion (HDMI clocks are 
disabled
on unbind), so *something* has to be done late.

So here are my questions:
- What breaks in my config when I boot using u-boot's DT?
- How to detect early that the registers are clocked or not?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
