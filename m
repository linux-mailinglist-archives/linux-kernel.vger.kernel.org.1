Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09826AE04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgIOTsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:48:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48894 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727737AbgIOTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600199229;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur1rWbZNT5UsC7ZqJ5DKcCpE8+s/eiYwscnRZFIyoQs=;
        b=EuSih+q8ZCUOgC8b+bQ70tbqPnRENBsmQBWQ7m1QYYnd2+D6gp5EMZu1J9RdafdZr9+9tz
        LIRlrmn3km+2ZVh4S+vM6Re1rYHgJcBJIL14sP/PYAzys/l6SPkWCY4yDvBnC0aSmaqw8L
        YEUrALZxGEQfFr2kj9lDO1P0ba84P2A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-IigLgnYXM8W85NgOT_WQmw-1; Tue, 15 Sep 2020 15:47:04 -0400
X-MC-Unique: IigLgnYXM8W85NgOT_WQmw-1
Received: by mail-qt1-f200.google.com with SMTP id t56so256036qtt.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ur1rWbZNT5UsC7ZqJ5DKcCpE8+s/eiYwscnRZFIyoQs=;
        b=WHW5MN3tqEbEE+pcqpeDFq7s3PD/iptpzKBOCR4nAwYY3uF2rMl1fj1E+rYXjjKoy+
         XSavr5cJXyxYzF2CHU6y+FI+jZGYosFNb/fWp3eiqAbaDsR9tU1HEXlpFyhDMUOnEFHR
         AF1mswHNHbr7K8M80wgHGPpvBqgq3DN7caCPMx3PCSIE3l10AJu6Aqlyacpw1zehD/c1
         pw6PbY9YRVLcrQfgP17zrV6O6belc2+YuvzjxxlnaZEoxC5v038kHUACZGRg6d/kE/Ee
         I5vB0HOMlKqSVD7BtYYibyq57gYvPU8xMHOeGMebm/5Ji2KiJWzkvJpsytLXN4ADnrWD
         8UZA==
X-Gm-Message-State: AOAM532a+c++rWL1Vic7jREPanrTnZ33Itht8SfmHoZu8zc6hlT7X32i
        quhgpr77DeXlnPmijB+v/ULwn6qBl2sIQqG0FDwFpdg/ydXXJ6C3OM1gAwRyvpfW+kdrEIA8abn
        DgovnJKUoNm2lzr52/VqLpQ5z
X-Received: by 2002:a05:620a:546:: with SMTP id o6mr20184489qko.296.1600199223748;
        Tue, 15 Sep 2020 12:47:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl+UYJSBul/q+CmYfqBZANubEc6SGBWhb3uWTdUm1eqMbnBd9q1e9hw6A3qtxfsEH1x2NVqA==
X-Received: by 2002:a05:620a:546:: with SMTP id o6mr20184447qko.296.1600199223404;
        Tue, 15 Sep 2020 12:47:03 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 8sm17307041qkd.47.2020.09.15.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:47:02 -0700 (PDT)
Message-ID: <b1b77b7022f9e388808bc3835f8fc88cda0718bc.camel@redhat.com>
Subject: Re: [RFC 1/5] drm/i915/dp: Program source OUI on eDP panels
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        thaytan@noraisin.net, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Manasi Navare <manasi.d.navare@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Date:   Tue, 15 Sep 2020 15:47:01 -0400
In-Reply-To: <20200915190639.GC503362@intel.com>
References: <20200915172939.2810538-1-lyude@redhat.com>
         <20200915172939.2810538-2-lyude@redhat.com>
         <20200915190639.GC503362@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-15 at 15:06 -0400, Rodrigo Vivi wrote:
> On Tue, Sep 15, 2020 at 01:29:35PM -0400, Lyude Paul wrote:
> > Since we're about to start adding support for Intel's magic HDR
> > backlight interface over DPCD, we need to ensure we're properly
> > programming this field so that Intel specific sink services are exposed.
> > Otherwise, 0x300-0x3ff will just read zeroes.
> > 
> > We also take care not to reprogram the source OUI if it already matches
> > what we expect. This is just to be careful so that we don't accidentally
> > take the panel out of any backlight control modes we found it in.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: thaytan@noraisin.net
> > Cc: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c | 32 +++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 4bd10456ad188..b591672ec4eab 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -3428,6 +3428,7 @@ void intel_dp_sink_set_decompression_state(struct
> > intel_dp *intel_dp,
> >  void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
> >  {
> >  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > +	u8 edp_oui[] = { 0x00, 0xaa, 0x01 };
> 
> what are these values?

I wish I knew, my assumption is this is the OUI that Intel's GPU driver uses on
other platforms, but I don't have any documentation mentioning this (in fact,
the few documents I do have on this backlight interface don't seem to make any
mention of it). I only managed to find this when looking through the last
attempt someone did at adding support for this backlight interface:

https://patchwork.freedesktop.org/patch/334989/

I think it should be fairly safe to write, as I know nouveau always programs a
source OUI (we don't do it from our driver, but nvidia hardware seems to do it
automatically) and I don't believe I've seen it ever change any behavior besides
making things appear in the 0x300-0x3ff register range.

AFAICT though, the backlight interface won't advertise itself without this being
set early on. If you could find anyone from Intel who knows more about it though
I'd definitely appreciate it (and just in general for the rest of the patch
series as well)

> 
> >  	int ret, i;
> >  
> >  	/* Should have a valid DPCD by this point */
> > @@ -3443,6 +3444,14 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp,
> > int mode)
> >  	} else {
> >  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
> >  
> > +		/* Write the source OUI as early as possible */
> > +		if (intel_dp_is_edp(intel_dp)) {
> > +			ret = drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI,
> > edp_oui,
> > +						sizeof(edp_oui));
> > +			if (ret < 0)
> > +				drm_err(&i915->drm, "Failed to write eDP source
> > OUI\n");
> > +		}
> > +
> >  		/*
> >  		 * When turning on, we need to retry for 1ms to give the sink
> >  		 * time to wake up.
> > @@ -4530,6 +4539,23 @@ static void intel_dp_get_dsc_sink_cap(struct intel_dp
> > *intel_dp)
> >  	}
> >  }
> >  
> > +static void
> > +intel_edp_init_source_oui(struct intel_dp *intel_dp)
> > +{
> > +	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
> > +	u8 oui[] = { 0x00, 0xaa, 0x01 };
> > +	u8 buf[3] = { 0 };
> > +
> > +	if (drm_dp_dpcd_read(&intel_dp->aux, DP_SOURCE_OUI, buf, sizeof(buf)) <
> > 0)
> > +		drm_err(&i915->drm, "Failed to read source OUI\n");
> > +
> > +	if (memcmp(oui, buf, sizeof(oui)) == 0)
> > +		return;
> > +
> > +	if (drm_dp_dpcd_write(&intel_dp->aux, DP_SOURCE_OUI, oui, sizeof(oui)) <
> > 0)
> > +		drm_err(&i915->drm, "Failed to write source OUI\n");
> > +}
> > +
> >  static bool
> >  intel_edp_init_dpcd(struct intel_dp *intel_dp)
> >  {
> > @@ -4607,6 +4633,12 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp)
> >  	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv))
> >  		intel_dp_get_dsc_sink_cap(intel_dp);
> >  
> > +	/*
> > +	 * Program our source OUI so we can make various Intel-specific AUX
> > +	 * services available (such as HDR backlight controls)
> > +	 */
> > +	intel_edp_init_source_oui(intel_dp);
> 
> I believe we should restrict this to the supported platforms: cfl, whl, cml,
> icl, tgl
> no?
> 
> > +
> >  	return true;
> >  }
> >  
> > -- 
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

