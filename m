Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44EF29512D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503243AbgJUQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503236AbgJUQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603299378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YpWDrSQ0xS4iFl6zf0HLMlyff6mhU5Ears3TWXC/4Ho=;
        b=EV0zodmVWO4hXI+oHamzrLId58LDwWPavX7LGPhFHP/vnA1PnSBP2qWLZ5OpGVL7hmHo8L
        85RVMZY5Gualoog7fM41SHm0hGTBMxizUHmVaXmtOtekv0uEYTnoFNCb7XAtHbqbvUEUh0
        0i+5f1fFbyR0mSMuC6yKvXD/9mRtNlQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-f7GWQmtIMaWVEQ2XzDT5yA-1; Wed, 21 Oct 2020 12:56:14 -0400
X-MC-Unique: f7GWQmtIMaWVEQ2XzDT5yA-1
Received: by mail-qv1-f70.google.com with SMTP id s9so1687819qvd.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YpWDrSQ0xS4iFl6zf0HLMlyff6mhU5Ears3TWXC/4Ho=;
        b=TsyN5RAYngtK0JFo9EWahUAMeYVFqkW0H7Q4Beieip8dUQbgudyiYtopVOMbwBrSrG
         Kz7P5nsWwnbKE30TtETXyRjYGYe9mICLubM/46Kph0svT+J6rptAag9E9nxHAfhQ96CI
         mex7FX/jfJ0fRyCSKMyMRvGereG1e6jzIp4hk8rJwyJi6sO2d2wwtUk/klMGFCb5zYkZ
         5GVAFyr1Tw+8Hb8653Aaa68RL8oDDAgS0pnJxSihcao3XWDwaYe+JWVQJmNwaswmOCx9
         l4yD8MFPRuPsxZ4iG4dK85pt0aoZP3FkuYPDOqaG1j2x92w5DX1K4RBTJcepiBu0l1UB
         YsbA==
X-Gm-Message-State: AOAM533i71iJ7JPJI1rsXm+V6oMq5R3UxYn6j+PUi3C53qHfOcXb7rVw
        uXaMNU2/rxtTg2IqTFLwlbXNlUG9CttuhkN2J+aipka8n2d2LbJVi4oERz36n/i4wVtlh+/Nmsg
        A9iRT/yWuGjNmLC9lCKJdqtwv
X-Received: by 2002:a05:620a:142d:: with SMTP id k13mr3922509qkj.315.1603299373817;
        Wed, 21 Oct 2020 09:56:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2v8PeoZ/a94ls9zOIyKWksYLW/NAN8enNJ9jX43dkLHUQkSE464KGbP6E/4BzXTqrq+S0iw==
X-Received: by 2002:a05:620a:142d:: with SMTP id k13mr3922487qkj.315.1603299373526;
        Wed, 21 Oct 2020 09:56:13 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 19sm1575196qki.33.2020.10.21.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:56:12 -0700 (PDT)
Message-ID: <54b001e1748fd3d80c711181521e5cf1ec6875eb.camel@redhat.com>
Subject: Re: [PATCH v2 12/24] drm/dp: fix a kernel-doc issue at drm_edid.c
From:   Lyude Paul <lyude@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 21 Oct 2020 12:56:11 -0400
In-Reply-To: <20201021121108.51972144@coco.lan>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
         <96d648f86024535e5f7d5b0caf8ebf93c7f8eaab.1602590106.git.mchehab+huawei@kernel.org>
         <b7c9b5ddc2bdd5d1a0bb5a000d88681ad0b6fabe.camel@redhat.com>
         <20201021121108.51972144@coco.lan>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, good point. It looks like you've already added the drm-misc-next and drm
maintainers to here so as long as they're aware that should be fine

On Wed, 2020-10-21 at 12:11 +0200, Mauro Carvalho Chehab wrote:
> Hi Lyude,
> 
> Em Tue, 13 Oct 2020 15:49:11 -0400
> Lyude Paul <lyude@redhat.com> escreveu:
> 
> > wait, I think there's some confusion here. these patches have already been
> > pushed
> 
> As the patch adding the warning was merged upstream at the 5.10 merge
> window, the fixup one should also be added there, instead of waiting
> until 5.11 ;-)
> 
> So, if OK for you, I'll send this upstream via my tree by the end of
> the merge window, as our goal is that 5.10 won't have doc warnings.
> 
> Regards,
> Mauro
> > 
> > On Tue, 2020-10-13 at 14:14 +0200, Mauro Carvalho Chehab wrote:
> > > The name of the argument is different, causing those warnings:
> > > 
> > > 	./drivers/gpu/drm/drm_edid.c:3754: warning: Function parameter or
> > > member
> > > 'video_code' not described in 'drm_display_mode_from_cea_vic'
> > > 	./drivers/gpu/drm/drm_edid.c:3754: warning: Excess function parameter
> > > 'vic' description in 'drm_display_mode_from_cea_vic'
> > > 
> > > Fixes: 7af655bce275 ("drm/dp: Add drm_dp_downstream_mode()")
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  drivers/gpu/drm/drm_edid.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > > index a82f37d44258..631125b46e04 100644
> > > --- a/drivers/gpu/drm/drm_edid.c
> > > +++ b/drivers/gpu/drm/drm_edid.c
> > > @@ -3741,7 +3741,7 @@ drm_add_cmdb_modes(struct drm_connector
> > > *connector, u8
> > > svd)
> > >  /**
> > >   * drm_display_mode_from_cea_vic() - return a mode for CEA VIC
> > >   * @dev: DRM device
> > > - * @vic: CEA VIC of the mode
> > > + * @video_code: CEA VIC of the mode
> > >   *
> > >   * Creates a new mode matching the specified CEA VIC.
> > >   *  
> 
> 
> Thanks,
> Mauro
> 
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

