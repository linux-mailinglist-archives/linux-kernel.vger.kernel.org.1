Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AD26B676
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgIPAFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbgIPAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 20:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600214710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjZa40MjlMQHEg6VysBK1I3Rn/FQZQF1fQa44n3WO6k=;
        b=WsERhkWc3AbE9uMLsIb19Jw+W4CY9104PbTBjEZGawF9P84uBJrwOG7Qw5y2FmDyO9WHQR
        YCzWO2dbVZAb2JJSwbsD/eYetfQ4uR5iWh7QVWA1I/P9Bl8wHjpA93LWNyjqE2P0dUErCF
        WR7K5F0JCricL+oTwKrLqR1y6Jh7aLs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-3Oe0lXmtOlGhAEEdvkklHw-1; Tue, 15 Sep 2020 20:05:04 -0400
X-MC-Unique: 3Oe0lXmtOlGhAEEdvkklHw-1
Received: by mail-qk1-f199.google.com with SMTP id 139so4506304qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 17:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=VjZa40MjlMQHEg6VysBK1I3Rn/FQZQF1fQa44n3WO6k=;
        b=ZkkqyPi7d0gIuUU/Nxx6rWmAnE60zniLSgimzfHPR3hnoj/BVGKfzjov3+W/kSMhN8
         WwvgjdDxzj6w34dalQK6f/ofVlEX4OUZ5zJbtsG87XC1KeWABlitinjwBuoPv6hNvzmC
         nbDYBsceCpZ+bZWWOI1ECxsS+ogfcegoChCg7/YFLMYgCTgoWQ55FR6UaNHcd1mHdpOR
         llCAXbmmtQQWjFV4Y0IwYBsjJfrTzihD4zVeelFWK22Jol/abg4Q91HV1oWAjBuFclVL
         1NCp8zvkQQvmQHDGnXEX6kC5H+VRv9L3i3nTzu69KtDaf2LYP4rkVrrzACxY+C2YURSC
         rMFA==
X-Gm-Message-State: AOAM533CLfCbmO4au4qVwwmzQ1AKQOyABHVZYExlF7lrC8qV9VqwCFtL
        auQYoGe/Hzu3hnOxPUG84PocN/yTYC5HucEBVwPcPwbZXzLJ7l5P9CToFdeqIo/o6W+JPvDNbd9
        saHDaoJBog6jRmmYp2QgBz18e
X-Received: by 2002:ac8:4e81:: with SMTP id 1mr21705676qtp.62.1600214704313;
        Tue, 15 Sep 2020 17:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyODPABpreP655peyCUe7notNMLlNOaVBru1ukZ/HwVrAukGlTgX9PPDDwkE5P37N1uXnJlew==
X-Received: by 2002:ac8:4e81:: with SMTP id 1mr21705661qtp.62.1600214704041;
        Tue, 15 Sep 2020 17:05:04 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id o35sm6208974qte.23.2020.09.15.17.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 17:05:03 -0700 (PDT)
Message-ID: <7a86180ed7013a0a52d71cf38a4bc371c7ffd4ab.camel@redhat.com>
Subject: Re: [RFC 1/5] drm/i915/dp: Program source OUI on eDP panels
From:   Lyude Paul <lyude@redhat.com>
To:     "Navare, Manasi" <manasi.d.navare@intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        thaytan@noraisin.net, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Wambui Karuga <wambui.karugax@gmail.com>
Date:   Tue, 15 Sep 2020 20:05:04 -0400
In-Reply-To: <20200915223841.GA14183@labuser-Z97X-UD5H>
References: <20200915172939.2810538-1-lyude@redhat.com>
         <20200915172939.2810538-2-lyude@redhat.com>
         <20200915190639.GC503362@intel.com>
         <b1b77b7022f9e388808bc3835f8fc88cda0718bc.camel@redhat.com>
         <20200915223841.GA14183@labuser-Z97X-UD5H>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-15 at 15:38 -0700, Navare, Manasi wrote:
> On Tue, Sep 15, 2020 at 03:47:01PM -0400, Lyude Paul wrote:
> > On Tue, 2020-09-15 at 15:06 -0400, Rodrigo Vivi wrote:
> > > On Tue, Sep 15, 2020 at 01:29:35PM -0400, Lyude Paul wrote:
> > > > Since we're about to start adding support for Intel's magic HDR
> > > > backlight interface over DPCD, we need to ensure we're properly
> > > > programming this field so that Intel specific sink services are
> > > > exposed.
> > > > Otherwise, 0x300-0x3ff will just read zeroes.
> > > > 
> > > > We also take care not to reprogram the source OUI if it already
> > > > matches
> > > > what we expect. This is just to be careful so that we don't
> > > > accidentally
> > > > take the panel out of any backlight control modes we found it in.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Cc: thaytan@noraisin.net
> > > > Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/i915/display/intel_dp.c | 32
> > > > +++++++++++++++++++++++++
> > > >  1 file changed, 32 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > > > b/drivers/gpu/drm/i915/display/intel_dp.c
> > > > index 4bd10456ad188..b591672ec4eab 100644
> > > > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > > > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > > > @@ -3428,6 +3428,7 @@ void
> > > > intel_dp_sink_set_decompression_state(struct
> > > > intel_dp *intel_dp,
> > > >  void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
> > > >  {
> > > >  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > > > +	u8 edp_oui[] = { 0x00, 0xaa, 0x01 };
> > > 
> > > what are these values?
> 
> We in i915 typically use the OUI number for adding any eDP specific
> quirks. I have seen these getting spit out in the dmesg log at thebeginning.
> AFAIK It is some kind of OEM identification number for a display panel.

Are you sure you're not confusing this with the sink OUI btw? We're setting
the source OUI (so, identifying ourselves to the display panel instead of the
other way around) here to tell the panel to expose the Intel specific
backlight controls. My assumption is the { 0x00, 0xaa, 0x01 } is some Intel
driver OUI, it's just I'm not really sure where it comes from other then the
patch I linked to down below

> 
> Manasi
> > I wish I knew, my assumption is this is the OUI that Intel's GPU driver
> > uses on
> > other platforms, but I don't have any documentation mentioning this (in
> > fact,
> > the few documents I do have on this backlight interface don't seem to make
> > any
> > mention of it). I only managed to find this when looking through the last
> > attempt someone did at adding support for this backlight interface:
> > 
> > https://patchwork.freedesktop.org/patch/334989/
> > 
> > I think it should be fairly safe to write, as I know nouveau always
> > programs a
> > source OUI (we don't do it from our driver, but nvidia hardware seems to
> > do it
> > automatically) and I don't believe I've seen it ever change any behavior
> > besides
> > making things appear in the 0x300-0x3ff register range.
> > 
> > AFAICT though, the backlight interface won't advertise itself without this
> > being
> > set early on. If you could find anyone from Intel who knows more about it
> > though
> > I'd definitely appreciate it (and just in general for the rest of the
> > patch
> > series as well)
> > 
> > > >  	int ret, i;
> > > >  
> > > >  	/* Should have a valid DPCD by this point */
> > > > @@ -3443,6 +3444,14 @@ void intel_dp_sink_dpms(struct intel_dp
> > > > *intel_dp,
> > > > int mode)
> > > >  	} else {
> > > >  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
> > > >  
> > > > +		/* Write the source OUI as early as possible */
> > > > +		if (intel_dp_is_edp(intel_dp)) {
> > > > +			ret = drm_dp_dpcd_write(&intel_dp->aux,
> > > > DP_SOURCE_OUI,
> > > > edp_oui,
> > > > +						sizeof(edp_oui));
> > > > +			if (ret < 0)
> > > > +				drm_err(&i915->drm, "Failed to write
> > > > eDP source
> > > > OUI\n");
> > > > +		}
> > > > +
> > > >  		/*
> > > >  		 * When turning on, we need to retry for 1ms to give
> > > > the sink
> > > >  		 * time to wake up.
> > > > @@ -4530,6 +4539,23 @@ static void intel_dp_get_dsc_sink_cap(struct
> > > > intel_dp
> > > > *intel_dp)
> > > >  	}
> > > >  }
> > > >  
> > > > +static void
> > > > +intel_edp_init_source_oui(struct intel_dp *intel_dp)
> > > > +{
> > > > +	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > > > +	u8 oui[] = { 0x00, 0xaa, 0x01 };
> > > > +	u8 buf[3] = { 0 };
> > > > +
> > > > +	if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf,
> > > > sizeof(buf)) <
> > > > 0)
> > > > +		drm_err(&i915->drm, "Failed to read source OUI\n");
> > > > +
> > > > +	if (memcmp(oui, buf, sizeof(oui)) == 0)
> > > > +		return;
> > > > +
> > > > +	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui,
> > > > sizeof(oui)) <
> > > > 0)
> > > > +		drm_err(&i915->drm, "Failed to write source OUI\n");
> > > > +}
> > > > +
> > > >  static bool
> > > >  intel_edp_init_dpcd(struct intel_dp *intel_dp)
> > > >  {
> > > > @@ -4607,6 +4633,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
> > > >  	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
> > > >  		intel_dp_get_dsc_sink_cap(intel_dp);
> > > >  
> > > > +	/*
> > > > +	 * Program our source OUI so we can make various Intel-
> > > > specific AUX
> > > > +	 * services available (such as HDR backlight controls)
> > > > +	 */
> > > > +	intel_edp_init_source_oui(intel_dp);
> > > 
> > > I believe we should restrict this to the supported platforms: cfl, whl,
> > > cml,
> > > icl, tgl
> > > no?
> > > 
> > > > +
> > > >  	return true;
> > > >  }
> > > >  
> > > > -- 
> > > > 2.26.2
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > -- 
> > Sincerely,
> >       Lyude Paul (she/her)
> >       Software Engineer at Red Hat
> > 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

