Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC91E2A75CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbgKEC5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:57:12 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:4060 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388455AbgKEC5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:57:10 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CRSq80gJrz8p;
        Thu,  5 Nov 2020 03:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604545028; bh=ftTu3GVhpENCklOKbGWhySdZBk/3XyASkUeEvoboYxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coIYJ4QFqThVJlAPSGs2RnDKZzFWxTyG88+X0vtqmLPKM28BghZsxExYdrns4OMbl
         zvEOvpEVqNiEbe9QAZ0VdnAYgtHZyvGL/CB5nt4hLdJtT43JO+jLiKiPvPmbtScR2O
         ulNwUE4yRcwmDwgy7qbMmRFN6rqqMLTNXKJ54ijCD1OO3cntFYkSuvYmRT7GYxHuiQ
         b+lnQCTzfHoqvr3gUzNnAju75nl8ZSElDxcv5KJbpyFPGFHi95Mig1VoX8L3aIPFMn
         GnDWJTc0xwJJe3FQKux780JbHY33qVCsSqmClKMGUw6ft/+KpxLa9vFCeJijkMO4zN
         XuW9o03CGBoMA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 5 Nov 2020 03:57:06 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, lgirdwood@gmail.com,
        mripard@kernel.org, linux-kernel@vger.kernel.org, wens@csie.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
Message-ID: <20201105025706.GE17266@qmqm.qmqm.pl>
References: <20201021183149.GA8436@Red>
 <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red>
 <20201024115307.GA2745@qmqm.qmqm.pl>
 <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
 <20201102202727.GA20042@qmqm.qmqm.pl>
 <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 11:28:45AM +0100, Ahmad Fatoum wrote:
> Hello,
> 
> On 11/2/20 9:27 PM, Micha³ Miros³aw wrote:
> > On Mon, Nov 02, 2020 at 01:48:54PM +0100, Ahmad Fatoum wrote:
> >> Hello Micha³,
> >>
> >> CC += linux-stm32
> >>
> >> On 10/24/20 1:53 PM, Micha³ Miros³aw wrote:
> >>> On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
> >>>> On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
> >>>>> On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
> >>>>> I have just saw thoses 3 lines which are probably the real problem.
> >>>>> I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
> >>>>>
> >>>>
> >>>> I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
> >>>> Reverting this fix my problem.
> >>
> >> The change broke boot on all the STM32MP1 boards, because the STPMIC driver
> >> has a vref_ddr regulator, which does not have a dedicated supply, but without
> >> a vref_ddr-supply property the system now no longer boots.
> > [...]
> > 
> > Can you catch debug logs for the bootup in question? I'm not sure what's
> > the failure mode in your case. I guess this is not a bypassed regulator?
> 
> Boot up with v5.10-rc2 + your cf1ad559a2 ("regulator: defer probe when trying
> to get voltage from unresolved supply") hangs:
> 
> [    1.151489] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
> [    1.180698] stpmic1 1-0033: PMIC Chip Version: 0x10
> [    1.189526] vddcore: supplied by regulator-dummy
> [    1.195633] vdd_ddr: supplied by regulator-dummy
> [    1.201672] vdd: supplied by regulator-dummy
> [    1.207452] v3v3: supplied by 5V2
> [    1.211997] v1v8_audio: supplied by v3v3
> [    1.218036] v3v3_hdmi: supplied by 5V2
> [    1.223626] vtt_ddr: supplied by regulator-dummy
> [    1.227107] vdd_usb: supplied by regulator-dummy
> [    1.234532] vdda: supplied by 5V2
> [    1.239497] v1v2_hdmi: supplied by v3v3
[...]

Can you try with the patches I just sent and with debug logs enabled?

The first one just plugs a memory leak, but if there is some state
changed/saved in the rdev->constraints (can't find that code, though),
this might prevent it from being overwritten.

The second patch will just tell us if you hit the early resolve case.

Best Regards,
Micha³ Miros³aw
