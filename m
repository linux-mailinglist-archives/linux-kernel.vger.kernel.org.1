Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB392B065B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgKLNXy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 08:23:54 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49792 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgKLNXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:23:53 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kdCZp-0002Aj-4Z; Thu, 12 Nov 2020 14:23:49 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 05/25] soc: rockchip: io-domain: Remove incorrect and incomplete comment header
Date:   Thu, 12 Nov 2020 14:23:48 +0100
Message-ID: <2215873.HjEmSL4Tfo@diego>
In-Reply-To: <20201112132224.GJ1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org> <40131312.rmDrfLbc3i@diego> <20201112132224.GJ1997862@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. November 2020, 14:22:24 CET schrieb Lee Jones:
> On Thu, 12 Nov 2020, Heiko Stübner wrote:
> 
> > Am Donnerstag, 12. November 2020, 11:33:44 CET schrieb Lee Jones:
> > > On Tue, 03 Nov 2020, Lee Jones wrote:
> > > 
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.
> > > > 
> > > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > Cc: Doug Anderson <dianders@chromium.org>
> > > > Cc: linux-rockchip@lists.infradead.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/soc/rockchip/io-domain.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> > > > index eece97f97ef8f..d13d2d497720b 100644
> > > > --- a/drivers/soc/rockchip/io-domain.c
> > > > +++ b/drivers/soc/rockchip/io-domain.c
> > > > @@ -53,9 +53,6 @@
> > > >  
> > > >  struct rockchip_iodomain;
> > > >  
> > > > -/**
> > > > - * @supplies: voltage settings matching the register bits.
> > > > - */
> > > >  struct rockchip_iodomain_soc_data {
> > > >  	int grf_offset;
> > > >  	const char *supply_names[MAX_SUPPLIES];
> > > 
> > > Any idea who will pick this up?
> > 
> > me :-)
> 
> Well, that's certainly a start. :)
> 
> What are your plans?

the usual, my rockchip-tree -> armsoc driver branch -> torvalds -> 5.11 ;-)



