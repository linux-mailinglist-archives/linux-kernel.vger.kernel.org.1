Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8629DB82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbgJ2ABu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbgJ2ABW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:01:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:01:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so1194621ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5Ax3LBB3MaDs1VNveAhKnujcR2I/QqmbY5PUOksVSA=;
        b=Xz5lJP9PVYMJ839Z2eQD9nTSk0WPo+iALxRWVFigznIBGNnByN/6iqN320/zj1PXPQ
         z7RER+qgqoSL/vo7XEmcphpXxn7hC3BupY4Y3zgZI+pGNVDb9/3jShXX6o80V6RVAM3N
         ULDFZZSQdnUTDEVMVZ8bThWmpmb5U+auqe+KLAlZfwZvk+Q1EjHmc7G75WtJpvfqwHDs
         FqXkL63XAAyo7Apu63htaS/tx6QPq1bbbfLZ0+EscwdH1qzElqYnK17zevFXMKfnh8+4
         O2ZieHwP/le7hRcz06i8uIsQDecXa6eGpqFGoVMB08I7olh6x/TEMi9knVGWeXP1ol3p
         52mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5Ax3LBB3MaDs1VNveAhKnujcR2I/QqmbY5PUOksVSA=;
        b=M6Xx1Kq89f9F2OfKnsNE4e0Hv1G9auURNArUniBBIOnNnaAzHfrYJZqJpREsI4E3YW
         KXr2LfQ1+3E0d9dL/eQCdAr+18viXiQU8L+Sz8tyFm5OdEu+PtKAwGAszpJ8opOcyZPY
         c2N8xrBgKN4V0n0BkK/WQKPhqAFKTQmeG47l4aKthg52Fs8N3+L8iRVInvvmxtJ5xZja
         4k8hi5FS30x+mf+ySDmEiZcgI62d9bFSXvP9bKJu1jMyAh4M6NoWWx3Ltht++v4NdhJH
         L9xwdN+egSzviznyZpzcnH0PNI4JLKl+hsu0bvYjv74kixgnsFDEKqk7nq7Y8ANBNYE8
         Pzuw==
X-Gm-Message-State: AOAM532S7ART+Jv0pM5zTI2AIQ+o7O767IAS+unQOSWC1mbm9VI0mlJn
        xM5RH9ZrEI5f7+xjaUbTPZqRyQ36Nr55j3rA26dE+eDJN0A=
X-Google-Smtp-Source: ABdhPJyy6IXth0grY9TvlAj7pXiRysD/Em+vWPKSc1toQZQ/d5rOI+hnXAj2R8TNHM730gGC1A/Uv4jxb3aQ0WsiQ7U=
X-Received: by 2002:a05:6000:1185:: with SMTP id g5mr3552473wrx.42.1603891850012;
 Wed, 28 Oct 2020 06:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200708144555.718404-1-maxime@cerno.tech>
In-Reply-To: <20200708144555.718404-1-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 28 Oct 2020 13:30:32 +0000
Message-ID: <CAPY8ntDgx67bba2NtNVToEZaLrX5cmrdTB51=0L7qV5F5UOJiw@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: hdmi: Add a name to the codec DAI component
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 15:46, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Since the components for a given device in ASoC are identified by their
> name, it makes sense to add one even though it's not strictly necessary.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 15a11cd4de25..a057db0d9baa 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -983,6 +983,7 @@ static const struct snd_soc_dapm_route vc4_hdmi_audio_routes[] = {
>  };
>
>  static const struct snd_soc_component_driver vc4_hdmi_audio_component_drv = {
> +       .name                   = "vc4-hdmi-codec-dai-component",
>         .controls               = vc4_hdmi_audio_controls,
>         .num_controls           = ARRAY_SIZE(vc4_hdmi_audio_controls),
>         .dapm_widgets           = vc4_hdmi_audio_widgets,
> --
> 2.26.2
>
