Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAC1AACD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410127AbgDOQDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:03:14 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48932 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406161AbgDOQDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:03:06 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 492Rw74SFZzCQ;
        Wed, 15 Apr 2020 18:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586966583; bh=hS64iOJBBZqYHdq9+fLkyhdl437vkr0jh4NKqFkG8CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmnOO84iIiXL10sycPaTPnem8P1OlLjB6vZXic9Ms5JizjPQBig63uxY5hRY/kEvY
         gcd4RjjptB5Kc13weKFxAM75S23v2QXIEEoT5auGyia5wp9swH6f5zUIs+ctydMdxA
         eMzW80dEc9IB4mW5yGlf9Oll0uTTUGOmjkGb6tGRE0PL5dO465c/fLm5oF6fGhF5Qv
         9rOxbkTSAzXe0Z2mWaAw0mrvdtNcL6vwiFQSei3NdWbFjh0fFNGWjXnctdYep7LJXH
         aPBNUjNfrM1JZKv4S7iglwImAJqcXVbO5gP+cNdIjxX0iOdJJh2iJYaJILVrP4h0ab
         RYD3llI1IMIgg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 15 Apr 2020 18:03:02 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Suneel Garapati <suneel.garapati@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/7] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
Message-ID: <20200415160302.GB19897@qmqm.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <eb105eedaa387ced14bb687e38d3aa33d4fcf70a.1585827904.git.mirq-linux@rere.qmqm.pl>
 <67dc68ce-d8ec-4486-f4f9-3fb2580d2675@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67dc68ce-d8ec-4486-f4f9-3fb2580d2675@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:06:02PM +0300, Adrian Hunter wrote:
> On 2/04/20 2:54 pm, Micha³ Miros³aw wrote:
> > Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.
> 
> Does this change anything, because it looks the same to me?

The value of real_div is fixed this way. With previous code after
applying the quirk you would have real_div = 1 instead of real_div = 2.

Best Regards,
Micha³ Miros³aw

> 
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > Cc: stable@kernel.vger.org
> > Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
> > ---
> >  drivers/mmc/host/sdhci.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index b2dc4f1cfa5c..a043bf5e3565 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1807,9 +1807,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  
> >  		if (!host->clk_mul || switch_base_clk) {
> >  			/* Version 3.00 divisors must be a multiple of 2. */
> > -			if (host->max_clk <= clock)
> > +			if (host->max_clk <= clock) {
> >  				div = 1;
> > -			else {
> > +				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> > +					&& host->max_clk <= 25000000)
> > +					div = 2;
> > +			} else {
> >  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
> >  				     div += 2) {
> >  					if ((host->max_clk / div) <= clock)
> > @@ -1818,9 +1821,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >  			}
> >  			real_div = div;
> >  			div >>= 1;
> > -			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> > -				&& !div && host->max_clk <= 25000000)
> > -				div = 1;
> >  		}
> >  	} else {
> >  		/* Version 2.00 divisors must be a power of 2. */
> > 
> 
