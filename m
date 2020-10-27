Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7F29C8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829526AbgJ0T0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:26:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54456 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441551AbgJ0TXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:23:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id w23so2447576wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/YQzLo+xoKlsG0a7NL1LNhQR3WpxUD3R+vAi/OnWfW8=;
        b=O2CAJu78UGUOEi4Xc/BPb7wK1FL93c+jsFNe+Yi1iBAjjnj4juWvFui6xgTytrGyXA
         IfcVXGDr98N54cWGV2NbVrpQMhSMKuPp2l4Zc/Fwda3OAyc9bFyhVwiC7W0fpPjElP+n
         ELmRy7VEKz73d7ORmDt1DBFovrVUubwA/6Dys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/YQzLo+xoKlsG0a7NL1LNhQR3WpxUD3R+vAi/OnWfW8=;
        b=TNdo0yraDZyhF/Wnk7GdxCdE9ml1LlUurwyShFf0fWCLARfQIeL/zqUMFIThFQW03h
         1LxthcIpeBBCXa1dHyLTG/7iRpIi5aTt3bdNYj+LdtR0eV/FqQ3Ae1tUQ9sZVwYZFpJZ
         NWx4rUCRlp2dcdWMfQed1+I3xcOAxwlt5HpCjfuFuhoSUOyZejVyp2ghgAkI5gLQkvaA
         PkmqoYn6Vq2BBRiuIp/6742V4Bi98M1EGFUhG0zncAlrd/IZs5+NTxttu/2nh3yMCTU6
         D701OEg8eGUzx2JM6qYjLiYuFRzSRHR+pusODVDAILa3odiAxpRBhjvPehw3Xrl6XJ+D
         oIvg==
X-Gm-Message-State: AOAM530k8jD2hz/OsjAvHtgfmNqoSx3iFzVtUBcSUMBQw+4xOKwX2+kV
        DDxmFYBapczi8UxbI++i5xOaeQ==
X-Google-Smtp-Source: ABdhPJxOHRYEQnF6IiD4ylGtkmpksOj8tOpUYCFlPvKL9rDCAdhxr3VjReayHl47qQUkuSx2JIO6Jw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr4235285wmf.67.1603826601373;
        Tue, 27 Oct 2020 12:23:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f13sm3053361wrp.12.2020.10.27.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:23:20 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:23:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>, robdclark@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: panel: simple: Allow timing constraints, not
 fixed delays
Message-ID: <20201027192318.GR401619@phenom.ffwll.local>
Mail-Followup-To: Thierry Reding <thierry.reding@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>, robdclark@chromium.org,
        Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20201027094553.1.I31c4f8b111dbef1ab658f206764655ae983bc560@changeid>
 <20201027171459.GA2097755@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027171459.GA2097755@ulmo>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 06:14:59PM +0100, Thierry Reding wrote:
> On Tue, Oct 27, 2020 at 09:45:54AM -0700, Douglas Anderson wrote:
> > The simple panel code currently allows panels to define fixed delays
> > at certain stages of initialization.  These work OK, but they don't
> > really map all that clearly to the requirements presented in many
> > panel datasheets.  Instead of defining a fixed delay, those datasheets
> > provide a timing diagram and specify a minimum amount of time that
> > needs to pass from event A to event B.
> > 
> > Because of the way things are currently defined, most panels end up
> > over-delaying.  One prime example here is that a number of panels I've
> > looked at define the amount of time that must pass between turning a
> > panel off and turning it back on again.  Since there is no way to
> > specify this, many developers have listed this as the "unprepare"
> > delay.  However, if nobody ever tried to turn the panel on again in
> > the next 500 ms (or whatever the delay was) then this delay was
> > pointless.  It's better to do the delay only in the case that someone
> > tried to turn the panel on too quickly.
> > 
> > Let's support specifying delays as constraints.  We'll start with the
> > one above and also a second one: the minimum time between prepare
> > being done and doing the enable.  On the panel I'm looking at, there's
> > an 80 ms minimum time between HPD being asserted by the panel and
> > setting the backlight enable GPIO.  By specifying as a constraint we
> > can enforce this without over-delaying.  Specifically the link
> > training is allowed to happen in parallel with this delay so adding a
> > fixed 80 ms delay isn't ideal.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> >  drivers/gpu/drm/panel/panel-simple.c | 51 ++++++++++++++++++++++++----
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> This has always been bugging me a bit about the current setup, so I very
> much like this idea.
> 
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 2be358fb46f7..cbbe71a2a940 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -92,6 +92,19 @@ struct panel_desc {
> >  		unsigned int unprepare;
> >  	} delay;
> >  
> > +	/**
> > +	 * @prepare_to_enable_ms: If this many milliseconds hasn't passed after
> > +	 *                        prepare finished, add a delay to the start
> > +	 *                        of enable.
> > +	 * @unprepare_to_prepare_ms: If this many milliseconds hasn't passed
> > +	 *                           unprepare finished, add a delay to the
> > +	 *                           start of prepare.
> 
> I find this very difficult to understand and it's also not clear from
> this what exactly the delay is. Perhaps this can be somewhat clarified
> Something like the below perhaps?
> 
> 	@prepare_to_enable_ms: The minimum time, in milliseconds, that
> 	    needs to have passed between when prepare finished and enable
> 	    may begin. If at enable time less time has passed since
> 	    prepare finished, the driver waits for the remaining time.

Also maybe split the kerneldoc into the sub-structure (this should work I
think), so that you can go really wild on formatting :-)

You could even include diagrams or at least ascii art and stuff ...
-Daniel


> 
> > +	 */
> > +	struct {
> > +		unsigned int prepare_to_enable_ms;
> > +		unsigned int unprepare_to_prepare_ms;
> > +	} timing_constraints;
> > +
> >  	u32 bus_format;
> >  	u32 bus_flags;
> >  	int connector_type;
> > @@ -99,10 +112,12 @@ struct panel_desc {
> >  
> >  struct panel_simple {
> >  	struct drm_panel base;
> > -	bool prepared;
> 
> I understand how you're trying to reuse the value of prepared_time to
> replace this flag, but I find the logic very hard to understand now.
> 
> >  	bool enabled;
> >  	bool no_hpd;
> >  
> > +	ktime_t prepared_time;
> > +	ktime_t unprepared_time;
> > +
> >  	const struct panel_desc *desc;
> >  
> >  	struct regulator *supply;
> > @@ -230,6 +245,21 @@ static int panel_simple_get_non_edid_modes(struct panel_simple *panel,
> >  	return num;
> >  }
> >  
> > +static void panel_simple_enforce_constraint(ktime_t start_ktime,
> > +					    unsigned int min_ms)
> > +{
> > +	ktime_t now_ktime, min_ktime;
> > +
> > +	if (!min_ms)
> > +		return;
> > +
> > +	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
> > +	now_ktime = ktime_get();
> > +
> > +	if (ktime_before(now_ktime, min_ktime))
> > +		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
> > +}
> > +
> >  static int panel_simple_disable(struct drm_panel *panel)
> >  {
> >  	struct panel_simple *p = to_panel_simple(panel);
> > @@ -249,18 +279,19 @@ static int panel_simple_unprepare(struct drm_panel *panel)
> >  {
> >  	struct panel_simple *p = to_panel_simple(panel);
> >  
> > -	if (!p->prepared)
> > +	if (!p->prepared_time)
> >  		return 0;
> 
> Here for example I now need to actively think about what exactly
> !prepared_time actually means, when all it really means is that we're
> checking if the panel has already been enabled.
> 
> Perhaps we could provide a tiny helper to make this clearer?
> 
> 	static inline bool panel_simple_prepared(struct drm_panel *panel)
> 	{
> 		return p->prepared_time != 0;
> 	}
> 
> I think that clarifies what's meant here. We could even add a comment
> explaining what's going on here if that's still not clear.
> 
> Actually, looking at that, I think the explicit comparison alone makes
> this clearer, so this already seems better to me as well:
> 
> 	if (p->prepared_time != 0)
> 		return 0
> 
> Then again, this may just be me. If everyone else thinks this is clear
> enough, feel free to leave it as-is.
> 
> Another alternative would be to leave the current flag and logic in
> place and not rely on a special value for prepared_time to control the
> flow. That's slightly redundant, but it's really just one flag.
> 
> >  	gpiod_set_value_cansleep(p->enable_gpio, 0);
> >  
> >  	regulator_disable(p->supply);
> >  
> > +	p->prepared_time = 0;
> > +	p->unprepared_time = ktime_get();
> > +
> >  	if (p->desc->delay.unprepare)
> >  		msleep(p->desc->delay.unprepare);
> >  
> > -	p->prepared = false;
> > -
> >  	return 0;
> >  }
> >  
> > @@ -296,9 +327,12 @@ static int panel_simple_prepare(struct drm_panel *panel)
> >  	int err;
> >  	int hpd_asserted;
> >  
> > -	if (p->prepared)
> > +	if (p->prepared_time)
> >  		return 0;
> >  
> > +	panel_simple_enforce_constraint(p->unprepared_time,
> > +					p->desc->timing_constraints.unprepare_to_prepare_ms);
> 
> Looking at this, perhaps we can come up with shorter names for these?
> 
> Thierry



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
