Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A882A340D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKBT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:29:30 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11CC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:29:30 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id g12so11647830pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=uoOxuimGqR/XZohg3kDNnqLGh44Gb3rHGmhcimxdOOY=;
        b=X/cJK6On7gCEku6gf7AommmoOsjU/a5tlIE4w3Lty5H00mkIV5rNXD2hV5drnpvER7
         RuQ18vm1/trkX2my4c491xbgR8ybadobgs5JQu9jdUO4SKrwVCrwCmQKiE9mgwhrJdMR
         byvh/r5+J24rf4ov9GZLSpFpLphkTvgaKkm0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=uoOxuimGqR/XZohg3kDNnqLGh44Gb3rHGmhcimxdOOY=;
        b=EDU1OUCTP2OunumHtuIVEtAEMvwCVDiqdu4dR6eQz9l+OdCX3e39szk+BW7/jYabys
         GAVGtDprWcgpJXKA4HSRzHK1eRkxIF/kk55v3B2LYB2Qbfo0esVzbgxa79EdS2zAbyaA
         cyVV9HEQmIlsF49jY7HM1SdHnmCCF1foSbY2Pg5/fE+VdWJt9NQseCTJEIEHhJVz51Tc
         nknfQbwvplfSnkeMpPgSlP0pSdEl4tbHIfD3Sa2MS8vsHIDiuMMRT9PlQ3bsEtxossbR
         LhgUWI2o5B13H+y3aJ6E/Liys85ZekeydNlaocyGksESiJjGRC2D/MqQRgaOrYmqtlLh
         TZBA==
X-Gm-Message-State: AOAM531wIXtZFZasAgLTy6ZMt++KgqIO0obOi/yN3ASGVqIl3CpSSBr+
        UJglzB1o3JCwYpDV8EzeES40GHlSjTA+/A==
X-Google-Smtp-Source: ABdhPJxVKt+kRsHzbnU0rETD6G/1efTmJN02g/NGxauAmXXTQrMIxC6/YcVUoL/EqVkPVsDTdrz6Ow==
X-Received: by 2002:aa7:8548:0:b029:164:769a:353 with SMTP id y8-20020aa785480000b0290164769a0353mr23105505pfn.45.1604345370040;
        Mon, 02 Nov 2020 11:29:30 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id j11sm14286248pfh.143.2020.11.02.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:29:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201030232324.11170-1-khsieh@codeaurora.org>
References: <20201030232324.11170-1-khsieh@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: promote irq_hpd handle to handle link trainign correctly
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        rnayak@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Mon, 02 Nov 2020 11:29:28 -0800
Message-ID: <160434536802.884498.16389146296525781476@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject has a typo in "training".

Quoting Kuogee Hsieh (2020-10-30 16:23:24)
> Some dongles, such as Apple, required link training done at irq_hpd

s/required/require/

> request instead of plugin request. This patch promote irq_hpd hanlder

s/hanlder/handler/

> to handle link training and setup hpd_state correctly.
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Any Fixes tag?

>  drivers/gpu/drm/msm/dp/dp_display.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 13b66266cd69..55627530957c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -483,10 +485,24 @@ static int dp_display_usbpd_attention_cb(struct dev=
ice *dev)
>                 return -ENODEV;
>         }
> =20
> +       hpd =3D dp->usbpd;
> +
>         /* check for any test request issued by sink */
>         rc =3D dp_link_process_request(dp->link);
> -       if (!rc)
> -               dp_display_handle_irq_hpd(dp);
> +       if (!rc) {
> +               sink_request =3D dp->link->sink_request;
> +               if (sink_request & DS_PORT_STATUS_CHANGED) {
> +                       dp->hpd_state =3D ST_CONNECT_PENDING;
> +                       hpd->hpd_high =3D 1;
> +               }
> +
> +               rc =3D dp_display_handle_irq_hpd(dp);
> +
> +               if (rc && sink_request & DS_PORT_STATUS_CHANGED) {

Can you add parenthesis around this?

		if (rc && (sink_request & DS_PORT_STATUS_CHANGED)) {


I honestly don't know what's going on in this patch. It talks about
making link training happen during irq hpd handler but this is the
attention handler and we're checking port status changed? This is
related? The code is really not clear.

> +                       hpd->hpd_high =3D 0;
> +                       dp->hpd_state =3D ST_DISCONNECTED;
> +               }
> +       }
> =20
>         return rc;
>  }
>=20
> base-commit: 0e162b10644605428cd2596c12f8ed410cf9d2d9

What commit is this?
