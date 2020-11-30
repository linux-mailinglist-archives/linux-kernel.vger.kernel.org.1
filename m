Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC02C920C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgK3XHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730310AbgK3XHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606777566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6frRBBzQXaMeT/8bnTK/8rFpMmloGyYxD+8Uj5KjWgo=;
        b=E10q+Gqdt2G+Mep6e5faiLjx4GEw0FLg5gZcwee3p9LZt5sO3UA54SiVDTM5N+oZXWuzfQ
        x8Ch5o24eN0wtNLwETfuFeeFDkmg1h7EgB92MElFr+6wweHCIpMVy2o9sxJ7Y/AX00jKGK
        pp4Hs3itxw2yMhNKqTeYQlPw9umKdjk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-eUBoLY-INI-t_kOm8wWUKQ-1; Mon, 30 Nov 2020 18:06:04 -0500
X-MC-Unique: eUBoLY-INI-t_kOm8wWUKQ-1
Received: by mail-qk1-f200.google.com with SMTP id b11so10887932qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6frRBBzQXaMeT/8bnTK/8rFpMmloGyYxD+8Uj5KjWgo=;
        b=T8gO7sG6JOoG+48mVXNeM6/AWcQh60SXwS8fi1MNEbFRdtp2IUCWQYbzBT4EGCMOkf
         DAyJnKYnVrYaxLUTaCEuVlt0+OmZe0vkp/Yz3VzeLIf+uDRHQEPPajcep68aoe8cDPgP
         hY7cOcpnQtEduzMOFuC7zcN6gAmKe0i00SY/9MJhmc5xMiMnsJ8fdgCkWRE4Pm0OJC5X
         VdsDJ5UwxwORbhCwVoNvByfwC3qlEIAxehng7ZuXW0Q2ZmCTdAiaPRjycIHqxtxY3dQ9
         FgKSUNsK4OzPcXHiL5+cK0MeEvFqzEwLTg41U2bylpUzVARvqNR/q1uvgOO1A8etNF+C
         8kSw==
X-Gm-Message-State: AOAM533C049UpWRXNyKjZBfz3U0QOSDAFr2InTtCCGqIRfVdhUUUaeI3
        rTEo1GFtIkKfEoykWKmK+sQx5lcPiKU6iTKwDXy2Y4ApbncbelcIU8n3Jp5Oj+9ZUVWg+FnQyBv
        yyF21oBxS7BmwjbOEP6KgWkIM
X-Received: by 2002:ac8:46cf:: with SMTP id h15mr23615622qto.99.1606777563005;
        Mon, 30 Nov 2020 15:06:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPPVXc2CJiyNmc2S2hfwQESzG7j5pEG12mmoAlT+/dieclhE3Gw6dgwp8JFgE1caYlZzxhpg==
X-Received: by 2002:ac8:46cf:: with SMTP id h15mr23615598qto.99.1606777562748;
        Mon, 30 Nov 2020 15:06:02 -0800 (PST)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id r89sm16845878qtd.16.2020.11.30.15.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:06:01 -0800 (PST)
Message-ID: <53161495c2915ad60f749a0917bc606259a78e7c.camel@redhat.com>
Subject: Re: [RFC v2 1/8] drm/i915/dp: Program source OUI on eDP panels
From:   Lyude Paul <lyude@redhat.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     thaytan@noraisin.net, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Manasi Navare <manasi.d.navare@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Date:   Mon, 30 Nov 2020 18:06:00 -0500
In-Reply-To: <87v9dsl7ap.fsf@intel.com>
References: <20200916171855.129511-1-lyude@redhat.com>
         <20200916171855.129511-2-lyude@redhat.com> <87v9dsl7ap.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-26 at 12:51 +0200, Jani Nikula wrote:
> On Wed, 16 Sep 2020, Lyude Paul <lyude@redhat.com> wrote:
> > Since we're about to start adding support for Intel's magic HDR
> > backlight interface over DPCD, we need to ensure we're properly
> > programming this field so that Intel specific sink services are exposed.
> > Otherwise, 0x300-0x3ff will just read zeroes.
> > 
> > We also take care not to reprogram the source OUI if it already matches
> > what we expect. This is just to be careful so that we don't accidentally
> > take the panel out of any backlight control modes we found it in.
> > 
> > v2:
> > * Add careful parameter to intel_edp_init_source_oui() to avoid
> >   re-writing the source OUI if it's already been set during driver
> >   initialization
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: thaytan@noraisin.net
> > Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c | 33 +++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 4bd10456ad188..7db2b6a3cd52e 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -3424,6 +3424,29 @@ void intel_dp_sink_set_decompression_state(struct
> > intel_dp *intel_dp,
> >                             enable ? "enable" : "disable");
> >  }
> >  
> > +static void
> > +intel_edp_init_source_oui(struct intel_dp *intel_dp, bool careful)
> > +{
> > +       struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > +       u8 oui[] = { 0x00, 0xaa, 0x01 };
> 
> Nitpick, could be static const.
> 
> > +       u8 buf[3] = { 0 };
> > +
> > +       /*
> > +        * During driver init, we want to be careful and avoid changing
> > the source OUI if it's
> > +        * already set to what we want, so as to avoid clearing any state
> > by accident
> > +        */
> 
> Did you actually observe any ill behaviour with unconditionally writing
> the source OUI?
> 
> I mean it's easy to add the "careful" mode afterwards if there are
> concrete issues, but it'll be hard to remove because it'll be a
> functional change potentially causing regressions.

I haven't yet, although I'll give a test on some of the other machines I've
got lying around.

FWIW, relevant spec info:

   A Sink device that does not support the Source-device specified behavior
   specified by the owner of the IEEE OUI written to in DPCD Addresses 00300h
   through 00302h as being associated with the Source Identification shall
   AUX_ACK all writes, but take no other action, and shall respond to reads
   with an AUX_ACK and the value 00h.

> 
> > +       if (careful) {
> > +               if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf,
> > sizeof(buf)) < 0)
> > +                       drm_err(&i915->drm, "Failed to read source
> > OUI\n");
> > +
> > +               if (memcmp(oui, buf, sizeof(oui)) == 0)
> > +                       return;
> > +       }
> > +
> > +       if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui,
> > sizeof(oui)) < 0)
> > +               drm_err(&i915->drm, "Failed to write source OUI\n");
> > +}
> > +
> >  /* If the sink supports it, try to set the power state appropriately */
> >  void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
> >  {
> > @@ -3443,6 +3466,10 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp,
> > int mode)
> >         } else {
> >                 struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
> >  
> > +               /* Write the source OUI as early as possible */
> > +               if (intel_dp_is_edp(intel_dp))
> > +                       intel_edp_init_source_oui(intel_dp, false);
> > +
> 
> This hunk conflicts, will need a rebase.
> 
> BR,
> Jani.
> 
> 
> >                 /*
> >                  * When turning on, we need to retry for 1ms to give the
> > sink
> >                  * time to wake up.
> > @@ -4607,6 +4634,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
> >         if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
> >                 intel_dp_get_dsc_sink_cap(intel_dp);
> >  
> > +       /*
> > +        * If needed, program our source OUI so we can make various Intel-
> > specific AUX services
> > +        * available (such as HDR backlight controls)
> > +        */
> > +       intel_edp_init_source_oui(intel_dp, true);
> > +
> >         return true;
> >  }
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

