Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADB29FA72
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgJ3BSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgJ3BSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:18:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:18:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so2162162plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=6/T1bgNMX0hc7obLwVMGSAc+uvcAnq6mB6Znj0RpZj4=;
        b=QamlEIUF04NHqrdOLu3HlEqGIxbCZMTeDWZLaOyYYaIwjgG8bPGY97mDz5SRffykgk
         2LM0B+k0EopunO8G3uCNnT2utfRb2DJLAu5QC2Rr5GXAS4KCAIj2l99cM+qo0uSjUUyW
         pSDHp/0eK9Ihzh/cFLxsrz3uNL+EFPjLYL9fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=6/T1bgNMX0hc7obLwVMGSAc+uvcAnq6mB6Znj0RpZj4=;
        b=mQB/UDOBUbaBxtqpXy9sBOKaDyLn2+3QhdWYXeis1KrHt6GqoqNu39eJriiwOoVb7S
         vXYR/DGHr+8dPVjr6ftfvX/YBOO0Q6kosNy4LWdF6Kloe40LtVknwgcF3rW8HYZp0fhp
         m6cKFcrfSXjV2qK6JpA6MsYNSECZbWV8/BJOzu7SMtUkD4rt5ucl/kR2kZQpP2MEf5FZ
         dkHEWzghtkfZItWhF2ONukaSfd/2bevgR1NAcAFQsPk4TqHYUKj9sbNjB4ym3tP2o0pR
         CIvwa0vrhbnOJi3EYnUfro8I/570akd+3v2JGHxe5PqBNI0GDwtdGKu1P/sNjYEGeyt3
         ctrw==
X-Gm-Message-State: AOAM532t8mhDrOFtL1WiID47M3N1njzoW0722/NEGAtsqdfoNYxw8v4G
        JzXBxZrTekGTvQhVUYVKQCEK+yftxt/ZYg==
X-Google-Smtp-Source: ABdhPJzZFC3ctMbDZuoSYzO/annVO2MRDdW3xmvpRDz3KMTE+zxuQLBGDVnn8zI8L/vzvVOAlnwIYg==
X-Received: by 2002:a17:902:780f:b029:d6:3413:9fe8 with SMTP id p15-20020a170902780fb02900d634139fe8mr6827287pll.46.1604020682572;
        Thu, 29 Oct 2020 18:18:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a10sm1061409pjq.17.2020.10.29.18.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 18:18:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201029011154.1515687-2-swboyd@chromium.org>
References: <20201029011154.1515687-1-swboyd@chromium.org> <20201029011154.1515687-2-swboyd@chromium.org>
Subject: Re: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Combine register accesses in ti_sn_aux_transfer()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Thu, 29 Oct 2020 18:18:00 -0700
Message-ID: <160402068056.884498.17274332256355831549@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-10-28 18:11:51)
> @@ -72,6 +74,7 @@
>  #define SN_AUX_ADDR_19_16_REG                  0x74
>  #define SN_AUX_ADDR_15_8_REG                   0x75
>  #define SN_AUX_ADDR_7_0_REG                    0x76
> +#define SN_AUX_ADDR_MASK                       GENMASK(19, 0)
>  #define SN_AUX_LENGTH_REG                      0x77
>  #define SN_AUX_CMD_REG                         0x78
>  #define  AUX_CMD_SEND                          BIT(0)
> @@ -841,11 +844,13 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux=
 *aux,
>         struct ti_sn_bridge *pdata =3D aux_to_ti_sn_bridge(aux);
>         u32 request =3D msg->request & ~DP_AUX_I2C_MOT;
>         u32 request_val =3D AUX_CMD_REQ(msg->request);
> -       u8 *buf =3D (u8 *)msg->buffer;
> +       u8 *buf =3D msg->buffer;
> +       unsigned int len =3D msg->size;
>         unsigned int val;
> -       int ret, i;
> +       int ret;
> +       u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];

I realize now that the SN_AUX_CMD_REG is also here and it has a "go bit"
in it. We can combine another register write here by writing out the
address, length, and request in one go. I rolled that into v2.
