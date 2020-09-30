Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09E27EB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgI3Omj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3Omj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:42:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD02AC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:42:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so2129083wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=6v1rod49sRpblgnIYaytswYlCAQtFHY9+INnLpwKsRI=;
        b=cQOkFdHu0n/gK2VC6Pw53HVVFr+sMRhn6/aFzrYNCe7zizsTi+kfwlLL93pj2OdVwl
         ZvTEecxM05FWuhS8VL6yi10EmnLuVLatUgQxHjdXdPAyWlrIK+mfFFhOTLpn2J0GsJ5+
         SbO0juaAokzo/rGx78kvVzx0sykPLmcAbvJKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=6v1rod49sRpblgnIYaytswYlCAQtFHY9+INnLpwKsRI=;
        b=pPFavoZfd1yqj/Al/Z0TFbX2XFkaZJ1bVA5QNh6eSBRbFDqk+oaoL070H/FdanDB1r
         07Gf2Gr6InEMvSaXnuQ/NTfhj2VPh9g753+J5hXFF/RR08uZLHCvIttBC5aTXOgmnfc7
         57gaWtDsh2/rYUQanOlwxtG8bdTPIEI6T6ND1h75pThoigGW9sH7nta8BKBFKcVaP4br
         uwiMchdsFhOqnKa7c6y6ktkOaLffQl9kaxf7SDMEhFN/DJawS07o82IG7AufNJEsrhC/
         zGUIVY/helvPpg1ZTFDZfITbNWjDXp1D6T4yDzKyDQXGegJRdAtxbHKlgbAYMZZ1rxXk
         yd9w==
X-Gm-Message-State: AOAM5334oOlRDX9pD7M6D5PG+ihEhjPmR4V14mLUH8RlKjt+yrh2mdef
        +KfGKPRGfhrOgdCFCBQY2SlQ2g==
X-Google-Smtp-Source: ABdhPJz2nZa1l1VvlRHa6DFjVS+WIE6DInmcSNTyofAfBcbUicZpM6IVdQGrOIGPOy4g2tCaX7c+2g==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr3619286wrm.241.1601476957326;
        Wed, 30 Sep 2020 07:42:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k5sm3369463wmb.19.2020.09.30.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 07:42:36 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:42:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/52] drm: drm_dsc.h: fix a kernel-doc markup
Message-ID: <20200930144234.GB438822@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <3d467022325e15bba8dcb13da8fb730099303266.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d467022325e15bba8dcb13da8fb730099303266.1601467849.git.mchehab+huawei@kernel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:24:43PM +0200, Mauro Carvalho Chehab wrote:
> As warned by Sphinx:
> 
> 	./Documentation/gpu/drm-kms-helpers:305: ./include/drm/drm_dsc.h:587: WARNING: Unparseable C cross-reference: 'struct'
> 	Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
> 	  struct
> 	  ------^
> 
> The markup for one struct is wrong, as struct is used twice.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to drm-misc-fixes, thanks for your patch.
-Daniel

> ---
>  include/drm/drm_dsc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_dsc.h b/include/drm/drm_dsc.h
> index 887954cbfc60..732f32740c86 100644
> --- a/include/drm/drm_dsc.h
> +++ b/include/drm/drm_dsc.h
> @@ -588,7 +588,7 @@ struct drm_dsc_picture_parameter_set {
>   * This structure represents the DSC PPS infoframe required to send the Picture
>   * Parameter Set metadata required before enabling VESA Display Stream
>   * Compression. This is based on the DP Secondary Data Packet structure and
> - * comprises of SDP Header as defined &struct struct dp_sdp_header in drm_dp_helper.h
> + * comprises of SDP Header as defined &struct dp_sdp_header in drm_dp_helper.h
>   * and PPS payload defined in &struct drm_dsc_picture_parameter_set.
>   *
>   * @pps_header: Header for PPS as per DP SDP header format of type
> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
