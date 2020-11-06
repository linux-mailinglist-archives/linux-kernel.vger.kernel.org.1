Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2B2A9089
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgKFHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgKFHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:40:24 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C01C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:40:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c18so404605wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H/jQSiN2tGpCWcggCP9FyM2wQIVjYqAJtGxJOUgHLEY=;
        b=F7PEVrKf0rmG4ZgcbfXfewpMxLW9AzkfZdAGllK3MEI6yhABDPOknypwCvViiKILZE
         Q5ElUziTMlO1kg5hRu/mTMqPflOy1ywcdRlQcJ6M9Wsg39buUWwGtiHd/WG5b7S/jkGS
         KkbfC77NXkleedZvZGl1u5nekFTz0mclOavxh1HOIWRcxTtvH2JA0cbv0mGTZSDwSSA8
         LyOh9k0qhgs0uk8QWnJ30Xd2BVZU3BtWs9UX5JyB1jyUft6H6zbbzHhXfrjWwud2+HtA
         /CsfFKawMCyBA8NoivKUGa8rNX7YpuTSn8m9utrXXG5Me6xR/HF82v9HnGe+1MP+4i3M
         NWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H/jQSiN2tGpCWcggCP9FyM2wQIVjYqAJtGxJOUgHLEY=;
        b=UP+HAIRn1euJXReISIRxPb9DRag9CQFdnMl+68cHgfN+8BvQUBeVhdZKsIWyRUOE4w
         YLEnDLubH2OItRnjaLffZpH0OT/WvE9MiNKEHldkvpah6KHervbWv62tuloTzPWK/yjZ
         neKuPnSry/15aOMpHFxMcACTyQ6aWpwhp/WW31S+eA/6MamMou72caAm1WWYzSmAJIje
         +mPxOaJTCMmSd4ObK3I2FroKMv/60dc6XSH7GwQhgY+Bx/vpv6L76oUs2dOzz+34rWd8
         BfuNsTwIHTDo+bNqaQma8ZbbrOUPI8AN+c41w0/PMVNiAbjaWye8MMgg1UKCqMtTPIIZ
         L7jA==
X-Gm-Message-State: AOAM530gJsArwCE3S/tqBsJJKYGj1WMGIL1n0m/mnCQ/w+kmw0ONiVaG
        LrR7414+Fm9acKt3C3PUKCWXZA==
X-Google-Smtp-Source: ABdhPJxFK6IJdXXPNiq9kY9ys2Eug4k/Ug5hzS0gXVUQavIqwq02s49Lrze0b3JXpQxIHPBq/GhiJw==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr973561wme.65.1604648423307;
        Thu, 05 Nov 2020 23:40:23 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id a12sm746580wrr.31.2020.11.05.23.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:40:22 -0800 (PST)
Date:   Fri, 6 Nov 2020 07:40:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Henrik Rydberg <rydberg@bitmath.org>,
        Peter Osterlund <petero2@telia.com>,
        Stefan Gmeiner <riddlebox@freesurf.ch>,
        "C. Scott Ananian" <cananian@alumni.priceton.edu>,
        Bruce Kalk <kall@compass.com>,
        this to <linux-input@vger.kernel.org>
Subject: Re: [PATCH 10/20] input: mouse: synaptics: Place braces around empty
 if() body
Message-ID: <20201106074020.GT4488@dell>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
 <20201104162427.2984742-11-lee.jones@linaro.org>
 <20201106072630.GD1003057@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106072630.GD1003057@dtor-ws>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Dmitry Torokhov wrote:

> Hi Lee,
> 
> On Wed, Nov 04, 2020 at 04:24:17PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/input/mouse/synaptics.c: In function ‘synaptics_process_packet’:
> >  drivers/input/mouse/synaptics.c:1110:6: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Henrik Rydberg <rydberg@bitmath.org>
> > Cc: Peter Osterlund <petero2@telia.com>
> > Cc: Stefan Gmeiner <riddlebox@freesurf.ch>
> > Cc: "C. Scott Ananian" <cananian@alumni.priceton.edu>
> > Cc: Bruce Kalk <kall@compass.com>
> > Cc: this to <linux-input@vger.kernel.org>
> > Cc: linux-input@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/input/mouse/synaptics.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index 82577095e175e..07835939d83b9 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -1106,8 +1106,9 @@ static void synaptics_process_packet(struct psmouse *psmouse)
> >  					num_fingers = hw.w + 2;
> >  				break;
> >  			case 2:
> > -				if (SYN_MODEL_PEN(info->model_id))
> > +				if (SYN_MODEL_PEN(info->model_id)) {
> >  					;   /* Nothing, treat a pen as a single finger */
> > +				}
> 
> This gives me:
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> from checkpatch.

Yes, because checkpatch just sees it as a normal single statement,
rather than an empty one.  It complains about macros that can be
compiled out too, which is even more dangerous.

GCC wins this one though, as it *knows* it's an empty statement.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
