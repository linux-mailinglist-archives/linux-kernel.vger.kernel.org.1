Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045AA2B03A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgKLLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:13:38 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48994 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgKLLNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:13:35 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kdAXi-0000Ny-2a; Thu, 12 Nov 2020 12:13:30 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 05/25] soc: rockchip: io-domain: Remove incorrect and incomplete comment header
Date:   Thu, 12 Nov 2020 12:13:29 +0100
Message-ID: <40131312.rmDrfLbc3i@diego>
In-Reply-To: <20201112103344.GF1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org> <20201103152838.1290217-6-lee.jones@linaro.org> <20201112103344.GF1997862@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. November 2020, 11:33:44 CET schrieb Lee Jones:
> On Tue, 03 Nov 2020, Lee Jones wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/soc/rockchip/io-domain.c:57: warning: Cannot understand  * @supplies: voltage settings matching the register bits.
> > 
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/soc/rockchip/io-domain.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> > index eece97f97ef8f..d13d2d497720b 100644
> > --- a/drivers/soc/rockchip/io-domain.c
> > +++ b/drivers/soc/rockchip/io-domain.c
> > @@ -53,9 +53,6 @@
> >  
> >  struct rockchip_iodomain;
> >  
> > -/**
> > - * @supplies: voltage settings matching the register bits.
> > - */
> >  struct rockchip_iodomain_soc_data {
> >  	int grf_offset;
> >  	const char *supply_names[MAX_SUPPLIES];
> 
> Any idea who will pick this up?

me :-)



