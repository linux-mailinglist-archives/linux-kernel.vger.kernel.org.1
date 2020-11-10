Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468DA2AD05C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgKJHWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:22:46 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B453C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:22:46 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so11462712wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pgYTv/xDlwDGx17SGvB/gmIGQuabjes19DWEJkyXO6Y=;
        b=cwHDLKEkoU3j/6kaUgRxnWyiP409LDccPLWTOyHyBR0pT/tPbRhXPW9aCPehvwdKow
         1hVCnfPhvw0c29TtlfHBUl1QHajuqTtQnbN93IixMRcxlLLJWITG46Qd9L5T51+EBHz1
         WXOsGB9CbqRiZwVruhdW8wNXrIDqnI70w0NUbKmFDFgSdQB71aEV8cSUrz+v0Viwxy0s
         ldGSbxePw57Te9VGYcynnwfZqeNgVMNXkCa3we0adZQpcPkjRseKARXjj/GN9ZRafwXY
         j9/fg7Kr9azoWvLybrRKXCe+y3xhgWtyPAXg5kZ/NSlVgXadm4e1tPR5cW82icqTZYdx
         XjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pgYTv/xDlwDGx17SGvB/gmIGQuabjes19DWEJkyXO6Y=;
        b=BGtfG7LDMWtLwTBnVIM5Fxq2p1rqjx4NrDnhCeSku34I17QROkECLMYoL8TCXA/cIb
         5qepSspO6wWa2pknTOwGVUWgR88dq3Zb7wmAVlC43RzkUFD51GZvIczZmoCF4I1HprjJ
         BoydlLuEwb+g2TR+qU1DvQfFERfdiTAUoox+uwOiFvdmmOJ9LiWfhBR50HBrqJvsurs6
         /bT2Dr7QH3gLhHmBsw9Mu3h1VGBQVMPK457014JFszFZlpR6aRXoebrKyGnXudziaw4F
         +v7SObOOFAHYR6c5sbqV/5Ot/W84lM78Iy25Qav4/i6XgIVweQ1oNxhrDrc/OHywDfgG
         BrfQ==
X-Gm-Message-State: AOAM530SJHrVIsCzjDB4VKuQWi8U67x0yTqVOs2qNfDjBFCNhpGSHhlQ
        WsvsmgObPYEIgx+bwTx804X90w==
X-Google-Smtp-Source: ABdhPJytbodfPNciSJGHPfGDtp2n8M8AqMAnaG/IPVy9kKlEQBc0JnB43SLpHstkACTrQQIVaCMtfQ==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr21704418wrl.325.1604992965012;
        Mon, 09 Nov 2020 23:22:45 -0800 (PST)
Received: from dell ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id n10sm5685079wrv.77.2020.11.09.23.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 23:22:44 -0800 (PST)
Date:   Tue, 10 Nov 2020 07:22:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
Message-ID: <20201110072242.GF2063125@dell>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
 <20201109211855.3340030-16-lee.jones@linaro.org>
 <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Alex Deucher wrote:

> On Mon, Nov 9, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/radeon/r600_hdmi.c:177:6: warning: no previous prototype for ‘r600_hdmi_update_acr’ [-Wmissing-prototypes]
> >  177 | void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> >  | ^~~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/radeon/r600_hdmi.c:217:6: warning: no previous prototype for ‘r600_set_avi_packet’ [-Wmissing-prototypes]
> >  217 | void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
> >  | ^~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/radeon/r600_hdmi.c:314:6: warning: no previous prototype for ‘r600_hdmi_audio_set_dto’ [-Wmissing-prototypes]
> >  314 | void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
> >  | ^~~~~~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/radeon/r600_hdmi.c:340:6: warning: no previous prototype for ‘r600_set_vbi_packet’ [-Wmissing-prototypes]
> >  340 | void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset)
> >  | ^~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/radeon/r600_hdmi.c:351:6: warning: no previous prototype for ‘r600_set_audio_packet’ [-Wmissing-prototypes]
> >  351 | void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset)
> >  | ^~~~~~~~~~~~~~~~~~~~~
> >  drivers/gpu/drm/radeon/r600_hdmi.c:393:6: warning: no previous prototype for ‘r600_set_mute’ [-Wmissing-prototypes]
> >  393 | void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute)
> >  | ^~~~~~~~~~~~~
> >  drivers/gpu/drm/radeon/r600_hdmi.c:469:6: warning: no previous prototype for ‘r600_hdmi_enable’ [-Wmissing-prototypes]
> >  469 | void r600_hdmi_enable(struct drm_encoder *encoder, bool enable)
> >  | ^~~~~~~~~~~~~~~~
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/radeon/r600d.h        | 14 ++++++++++++++
> >  drivers/gpu/drm/radeon/radeon_audio.c | 11 +----------
> >  2 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/r600d.h b/drivers/gpu/drm/radeon/r600d.h
> > index 2e00a5287bd2d..db4bcc8bee4e5 100644
> > --- a/drivers/gpu/drm/radeon/r600d.h
> > +++ b/drivers/gpu/drm/radeon/r600d.h
> > @@ -27,6 +27,20 @@
> >  #ifndef R600D_H
> >  #define R600D_H
> >
> > +struct radeon_crtc;
> > +struct radeon_hdmi_acr;
> > +
> > +void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> > +void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
> > +void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
> > +       struct radeon_crtc *crtc, unsigned int clock);
> > +void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
> > +       unsigned char *buffer, size_t size);
> > +void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> > +       const struct radeon_hdmi_acr *acr);
> > +void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> > +void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
> > +
> 
> the *d.h headers are supposed to just be hardware definitions.  I'd
> prefer to keep driver stuff out of them.

That's fine (I did wonder if that were the case).

I need an answer from you and Sam whether I can create new headers.

For me, it is the right thing to do.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
