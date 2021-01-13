Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8E92F540B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbhAMUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbhAMUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:23:50 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D66C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:23:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c12so1941747pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=WGQke6zLtAv2uygLrV72K2fh5rxYEfT4Z5bBr6us6zY=;
        b=GJamghzOgKRi6utXXwuDtzHOkAu2Z4OLQceAsd+a656nZEdDzGd1MbCXgrXzVxggk5
         J81AlFPqw/YnRpvHiMXESmZOmirpd4Q+2zAZGxFpEFm5rZ2QTQHqkaW/KtB1+CJAESo7
         3GL3+pyz3IJBgxWo1tt4XncPohFynFLlT1X7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=WGQke6zLtAv2uygLrV72K2fh5rxYEfT4Z5bBr6us6zY=;
        b=rAItCB5ZxmdEFZ7USTmGyKp+KfVnOeMEahnQ6Buwv3tTd60X4X/v8Lj4l2hNnkKgNy
         F6GxcUYoUDrOO6qBPWnrbKCZmnYEhYfT/eMPq6Aom94B3aii6Oi+2GkF7npUi9sdG2rU
         APaeANrtIHZXebaLx9iLcElATgzbRhoMM01DMFDbctq/US2UkJTVmLHyUQTvLGOGZ2Rc
         bEQItcUAspF8QINrJcV7FWmxTCTNz98MI9AoixBDmE9Vn3Hzakrq89v0tZkJadkGI57f
         btZEk5+sLP2En+AFmS97YX207AOPTYo6YIMw9as9dNSHknfGT5OiTcC4SX+uozt+CuFN
         ShCw==
X-Gm-Message-State: AOAM532YKC+TbzZdrpouKnGS0glhvib+VhNSElC9F9z2nwZcdEqIxiHP
        vIKeZUSLS7awQhO0KM7dF2LzsQ==
X-Google-Smtp-Source: ABdhPJwUyxpvweLYeLkKvIIGRSlxt5wm3sy5MANlUgFTrlD92c4nskgH/ugzEIpRdVCdfTcbf33UIw==
X-Received: by 2002:a65:648c:: with SMTP id e12mr3735220pgv.123.1610569389573;
        Wed, 13 Jan 2021 12:23:09 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id ay21sm3725318pjb.1.2021.01.13.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:23:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e7e1e5f8808fc35a3bed9e6291c76460@codeaurora.org>
References: <y> <1610051425-20632-1-git-send-email-khsieh@codeaurora.org> <1610051425-20632-3-git-send-email-khsieh@codeaurora.org> <161039484176.3661239.14240346276437866761@swboyd.mtv.corp.google.com> <e7e1e5f8808fc35a3bed9e6291c76460@codeaurora.org>
Subject: Re: [PATCH 2/2] drm/msm/dp: unplug interrupt missed after irq_hpd handler
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     khsieh@codeaurora.org
Date:   Wed, 13 Jan 2021 12:23:07 -0800
Message-ID: <161056938760.3661239.7140156995833982843@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-01-13 09:48:25)
> On 2021-01-11 11:54, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2021-01-07 12:30:25)
> >> There is HPD unplug interrupts missed at scenario of an irq_hpd
> >> followed by unplug interrupts with around 10 ms in between.
> >> Since both AUX_SW_RESET and DP_SW_RESET clear pending HPD interrupts,
> >> irq_hpd handler should not issues either aux or sw reset to avoid
> >> following unplug interrupt be cleared accidentally.
> >=20
> > So the problem is that we're resetting the DP aux phy in the middle of
> > the HPD state machine transitioning states?
> >=20
> yes, after reset aux, hw clear pending hpd interrupts
> >>=20
> >> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> >> ---
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c=20
> >> b/drivers/gpu/drm/msm/dp/dp_catalog.c
> >> index 44f0c57..9c0ce98 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> >> @@ -190,6 +190,18 @@ int dp_catalog_aux_clear_hw_interrupts(struct=20
> >> dp_catalog *dp_catalog)
> >>         return 0;
> >>  }
> >>=20
> >> +/**
> >> + * dp_catalog_aux_reset() - reset AUX controller
> >> + *
> >> + * @aux: DP catalog structure
> >> + *
> >> + * return: void
> >> + *
> >> + * This function reset AUX controller
> >> + *
> >> + * NOTE: reset AUX controller will also clear any pending HPD related=
=20
> >> interrupts
> >> + *
> >> + */
> >>  void dp_catalog_aux_reset(struct dp_catalog *dp_catalog)
> >>  {
> >>         u32 aux_ctrl;
> >> @@ -483,6 +495,18 @@ int dp_catalog_ctrl_set_pattern(struct dp_catalog=
=20
> >> *dp_catalog,
> >>         return 0;
> >>  }
> >>=20
> >> +/**
> >> + * dp_catalog_ctrl_reset() - reset DP controller
> >> + *
> >> + * @aux: DP catalog structure
> >=20
> > It's called dp_catalog though.
> registers access are through dp_catalog_xxxx

Agreed. The variable is not called 'aux' though, it's called
'dp_catalog'.

> >=20
> >> + *
> >> + * return: void
> >> + *
> >> + * This function reset DP controller
> >=20
> > resets the
> >=20
> >> + *
> >> + * NOTE: reset DP controller will also clear any pending HPD related =

> >> interrupts
> >> + *
> >> + */
> >>  void dp_catalog_ctrl_reset(struct dp_catalog *dp_catalog)

Right here.

> >>  {
> >>         u32 sw_reset;
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c=20
> >> b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> >> index e3462f5..f96c415 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> >> @@ -1296,7 +1296,8 @@ static int dp_ctrl_setup_main_link(struct=20
> >> dp_ctrl_private *ctrl,
> >>          * transitioned to PUSH_IDLE. In order to start transmitting
> >>          * a link training pattern, we have to first do soft reset.
> >>          */
> >> -       dp_catalog_ctrl_reset(ctrl->catalog);
> >> +       if (*training_step !=3D DP_TRAINING_NONE)
> >=20
> > Can we check for the positive value instead? i.e.
> > DP_TRAINING_1/DP_TRAINING_2
> >=20

Any answer?
