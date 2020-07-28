Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773D1230CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgG1Op2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgG1Op1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:45:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:45:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so15004543wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFSLR54AG21yXuJSgEQrikeXsmLVyETIXUBo/YY7SQI=;
        b=n+V6fb8gaxi3wvPz5q/AZLkhYBFp17gFfZqBFOk707HPWjBYa1FRt8Ltx/88IKG7qW
         6QqtyNH4gMQyQfCXhKhAzP/0HSt1ZuBRzf6T+RuL/Wzr91cYH7zl3mLYRATzYGUgG5bJ
         t3MUy688J6u6xPFQtjvcbDNyXdS5qe80q2byIpC/BLDkw4jsX4nR7TYgR6D3BmJzvzXm
         tK964nLtGTzrl9xIkcejSN0Wo7Vumd2XDIih8kw822g1+oNTLUzpWOUhZG925+s/3o81
         Ej1wF810eZTRNrJnNPdKvuImV52MbsLK/93Sc+HOessePEry5j8S2V9Rl624t9iVF5X2
         Ksew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFSLR54AG21yXuJSgEQrikeXsmLVyETIXUBo/YY7SQI=;
        b=JTPWHJSaGx86akdlnw5U8pAnCqrfwBQFBVknAFa1T+4n4HvfMbWfc2wB60FaYmo+Hz
         /KOxX03RW0+tuRx5uGhDudZDTpY+dQfdIf1TPLDSKIn0cXpzSyjYzjEDlhf2+EkHzz9t
         QK+ZOe7HeaX7rhcyGSDiLqZxf447/o9wnLrZ5T+gAdO59IedK2cd+jTPTjQpDMZhHcVl
         0pgVwk96+ByknhK9r6BNz7Avdm+lZDoinA+Anq/1D3VdjygRXdxSLV6lmgDotmlXC50S
         dyJbrzad6QKdSoqSo84VPq3RzvPygTbVFODHXRbW+XuJ8LxdZs91hgR+RqPFfgRt8urz
         zcIQ==
X-Gm-Message-State: AOAM533h4ckx2RlGFs94fSF3uxyYju06zef5AGfZI3g0gCVbAlpOZLZ8
        cWQPc8Db2t4dPLyBmFJwu2WiPZbsiN7pOXum2iBx2g==
X-Google-Smtp-Source: ABdhPJxoae//gYKTh/KK+nGIJmSuUkxCKkLOygUv6fN0WS/O+exw/sJdg+qry+20wk4f/UqGvyE5iGiVLDilp4dPrxE=
X-Received: by 2002:adf:fdce:: with SMTP id i14mr19963786wrs.273.1595947526232;
 Tue, 28 Jul 2020 07:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <98c93e0a594e42e39ba77946a0c8107996495eae.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <98c93e0a594e42e39ba77946a0c8107996495eae.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 15:45:09 +0100
Message-ID: <CAPY8ntBk03NO40LtZjqgWbaC0JnJm6S60mftaJskfCXQY9WJog@mail.gmail.com>
Subject: Re: [PATCH v4 61/78] drm/vc4: hdmi: Rename drm_encoder pointer in mode_valid
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The mode_valid hook on the encoder uses a pointer to a drm_encoder called
> crtc, which is pretty confusing. Let's rename it to encoder to make it
> clear what it is.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index a01562a49bf0..17797b14cde4 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -556,7 +556,7 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
>  }
>
>  static enum drm_mode_status
> -vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
> +vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
>                             const struct drm_display_mode *mode)
>  {
>         /*
> --
> git-series 0.9.1
