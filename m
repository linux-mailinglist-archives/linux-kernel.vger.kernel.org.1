Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895362F75D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbhAOJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:49:37 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:39167 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbhAOJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:49:35 -0500
Received: by mail-lf1-f51.google.com with SMTP id a12so12275719lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=L90kymGCCJZ9J5R9kMuNINZa7AWjXHLHOwuL6Ekp254=;
        b=Uueej4NRIJur7wyhsl/Sc8EA14RV+QH88Iz5SKIVsYgwrBFQzSwnkt0xyqfwAPpDO8
         gwR/6r25q21+oNcPepdWjlztO/fbgu/D3b6Wxslq62ynPw7D11uZoCDNIU925jL6ehVs
         2ABTc8YZymgK/SJoyBOvRYWA0Igfodboo4fAUdaqRWHEHenOSSzXgntLPQ/vLZeZTbja
         QBgEef+0XbcjbX16BH1+AFahWvupAlU+aWb2viqxve49BnpFmO/5x71Qa1q9UFNIPa5q
         ykmMwnWyHUqy/rzpTONT4ab1dB0Dm9uGBVXN4fRYgTtpepT96Mrvq7IxtJT2ukiFBqvA
         yPtg==
X-Gm-Message-State: AOAM531Ak/zOEM7b3+VvmeJMhFLeQQNIeor+R5VGMDCQ5Y9T4N+ei6pY
        7MSkSkuknz6OBEZpdLCppH4=
X-Google-Smtp-Source: ABdhPJyi++6f0TlZzoeObznf8vWg8JubTjDu+O69qiP4W/n3DiD6NfRYnJamBjkEyKLQ6Z+ZykwsjA==
X-Received: by 2002:ac2:539c:: with SMTP id g28mr4960951lfh.382.1610704143100;
        Fri, 15 Jan 2021 01:49:03 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id e15sm840204lft.224.2021.01.15.01.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 01:49:02 -0800 (PST)
Message-ID: <87b957f904fc2621f0eca1dbd732828e1b24bf9a.camel@fi.rohmeurope.com>
Subject: Re: [PATCH 11/15] regulator: rohm-regulator: SNVS dvs and linear
 voltage support
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
In-Reply-To: <20210115082636.GF3975472@dell>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
         <f0af653b3d3d56bd1852468502518a54b31b1f10.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
         <20210115082636.GF3975472@dell>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 15 Jan 2021 11:48:58 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
On Fri, 2021-01-15 at 08:26 +0000, Lee Jones wrote:
> On Fri, 08 Jan 2021, Matti Vaittinen wrote:
> 
> > The helper for obtaining HW-state based DVS voltage levels
> > currently only
> > works for regulators using linear-ranges. Extend support to
> > regulators with
> > simple linear mappings and add also proper error path if pickable-
> > ranges
> > regulators call this.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/regulator/rohm-regulator.c | 23 +++++++++++++++++++++--
> >  include/linux/mfd/rohm-generic.h   |  6 +++++-
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/regulator/rohm-regulator.c
> > b/drivers/regulator/rohm-regulator.c
> > index 399002383b28..9248bd63afa9 100644
> > --- a/drivers/regulator/rohm-regulator.c
> > +++ b/drivers/regulator/rohm-regulator.c
> > @@ -22,13 +22,26 @@ static int set_dvs_level(const struct
> > regulator_desc *desc,
> >  			return ret;
> >  		return 0;
> >  	}
> > -
> > +	/* If voltage is set to 0 => disable */
> >  	if (uv == 0) {
> >  		if (omask)
> >  			return regmap_update_bits(regmap, oreg, omask,
> > 0);
> >  	}
> > +	/* Some setups don't allow setting own voltage but do allow
> > enabling */
> > +	if (!mask) {
> > +		if (omask)
> > +			return regmap_update_bits(regmap, oreg, omask,
> > omask);
> > +
> > +		return -EINVAL;
> > +	}
> >  	for (i = 0; i < desc->n_voltages; i++) {
> > -		ret = regulator_desc_list_voltage_linear_range(desc,
> > i);
> > +		/* NOTE to next hacker - Does not support pickable
> > ranges */
> > +		if (desc->linear_range_selectors)
> > +			return -EINVAL;
> > +		if (desc->n_linear_ranges)
> > +			ret =
> > regulator_desc_list_voltage_linear_range(desc, i);
> > +		else
> > +			ret = regulator_desc_list_voltage_linear(desc,
> > i);
> >  		if (ret < 0)
> >  			continue;
> >  		if (ret == uv) {
> > @@ -79,6 +92,12 @@ int rohm_regulator_set_dvs_levels(const struct
> > rohm_dvs_config *dvs,
> >  				mask = dvs->lpsr_mask;
> >  				omask = dvs->lpsr_on_mask;
> >  				break;
> > +			case ROHM_DVS_LEVEL_SNVS:
> > +				prop = "rohm,dvs-snvs-voltage";
> > +				reg = dvs->snvs_reg;
> > +				mask = dvs->snvs_mask;
> > +				omask = dvs->snvs_on_mask;
> > +				break;
> >  			default:
> >  				return -EINVAL;
> >  			}
> > diff --git a/include/linux/mfd/rohm-generic.h
> > b/include/linux/mfd/rohm-generic.h
> > index e99e569d3cc1..2f5fbfd0c6b3 100644
> > --- a/include/linux/mfd/rohm-generic.h
> > +++ b/include/linux/mfd/rohm-generic.h
> > @@ -27,7 +27,8 @@ enum {
> >  	ROHM_DVS_LEVEL_IDLE,
> >  	ROHM_DVS_LEVEL_SUSPEND,
> >  	ROHM_DVS_LEVEL_LPSR,
> > -	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
> > +	ROHM_DVS_LEVEL_SNVS,
> > +	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_SNVS,
> >  };
> 
> Does this actually work?
> 
> The code that consumes it looks like:
> 
>     for (i = 0; i < ROHM_DVS_LEVEL_MAX && !ret; i++)
> 
> So it will loop through like:
> 
> 0 (ROHM_DVS_LEVEL_IDLE)
> 1 (ROHM_DVS_LEVEL_SUSPEND)
> 2 (ROHM_DVS_LEVEL_LPSR)
> 3 (ROHM_DVS_LEVEL_SNVS)
> 
> Then break, since 'i' will be (== 4) not (< 4).
> 
> So the following will never be used:
> 
> 4 (ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_SNVS)
> 
> Unless I'm missing something, I think MAX should be the last entry.

I did some further digging. The first enum member is
ROHM_DVS_LEVEL_UNKNOWN => first valid value is 1 (ROHM_DVS_LEVEL_RUN).

=> logic for this part was correct.

But I think there is a problem in how these enum values are used!

for example at bd718x7_regulator.c

.level_map = ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |  
                                     ROHM_DVS_LEVEL_SUSPEND


This works for values 1 & 2 - but fails miserably for 3...

I see these levels are also used by various boards - so I wonder how
they have worked - and I wonder if fixing this will cause problems...

I will any way send a patch (separately from this series as I guess
this should be fixed rather sooner than later) to fix this.

> 
> >  /**
> > @@ -66,6 +67,9 @@ struct rohm_dvs_config {
> >  	unsigned int lpsr_reg;
> >  	unsigned int lpsr_mask;
> >  	unsigned int lpsr_on_mask;
> > +	unsigned int snvs_reg;
> > +	unsigned int snvs_mask;
> > +	unsigned int snvs_on_mask;
> >  };
> >  
> >  #if IS_ENABLED(CONFIG_REGULATOR_ROHM)


