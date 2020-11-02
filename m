Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571382A3517
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgKBU1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:27:36 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:40807 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBU1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:27:36 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CQ4GX0ZWfz6r;
        Mon,  2 Nov 2020 21:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1604348854; bh=WK11YnyQEwN2KcQnNU2MIZhQIDNo2+h26QG/omCesAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtprQsP4+xMhD1EN+MeixU5nEa4DUFL3FjfiVo8Whu81aisNIHBvQ2Hsv6jHi7AQL
         9NNJKvaLSUk2eySBa+rkhK+L9aCoUXKctp6XirYjBbfIz95zRxByOYq+nWuTJPZfhr
         PsHqcSModOggZCV4NNq0zWyiLZJLmgKf2rGPl3YQnBoeWzkrsLzTTcYvMNcH9QQM3R
         QLiDS4QbSl3BDxaCjufOk+JdS5V3BWho9hv3kkdXiuj3i/Df7spTS8/X7plhQ7iqtk
         Wlp7ZQlIJe1BMFb2NLMNe8uVG+b0OpWxMJ6+8cFEUQ8BVLLZqCTqPVBmELxZ/cO+NH
         jWIMlvzEgokcg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 2 Nov 2020 21:27:27 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, lgirdwood@gmail.com,
        mripard@kernel.org, linux-kernel@vger.kernel.org, wens@csie.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
Message-ID: <20201102202727.GA20042@qmqm.qmqm.pl>
References: <20201021183149.GA8436@Red>
 <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red>
 <20201024115307.GA2745@qmqm.qmqm.pl>
 <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:48:54PM +0100, Ahmad Fatoum wrote:
> Hello Micha³,
> 
> CC += linux-stm32
> 
> On 10/24/20 1:53 PM, Micha³ Miros³aw wrote:
> > On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
> >> On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
> >>> On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
> >>> I have just saw thoses 3 lines which are probably the real problem.
> >>> I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
> >>>
> >>
> >> I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
> >> Reverting this fix my problem.
> 
> The change broke boot on all the STM32MP1 boards, because the STPMIC driver
> has a vref_ddr regulator, which does not have a dedicated supply, but without
> a vref_ddr-supply property the system now no longer boots.
[...]

Can you catch debug logs for the bootup in question? I'm not sure what's
the failure mode in your case. I guess this is not a bypassed regulator?

Best Regards,
Micha³ Miros³aw

