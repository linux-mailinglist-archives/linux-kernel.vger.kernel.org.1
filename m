Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1E288150
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgJIE1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgJIE1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:27:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412EC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 21:27:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so11185277eja.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Wa83KDJqEIQFwYhYvTrdA/0P1iUPtwhqUCll5VkxxTM=;
        b=KpAyRVEAdAaCwD+Yx6pELyeWFCw6hmhbf/6XG6boCoLNgXhlVj/wMaRZggwh/DHdE4
         j3S4ZOtdhpy1LtL36FMR65fmpFwroVpgHhNx7uhiG83woYsoOClVEMA1HKjjoeeuccsU
         0/NvrvJ8ERX5pwDvVZRsKTiD0PkY58wvHun4QomLCeS8574cEHxSJBV1z6KvSIN1Y4rT
         QcmffTwQTIPkXR8zW+e/fdOlr/JPKxERpFbJkvavcQjboyo4h4iMASE9rPDtFKlZi+nv
         jn5k9XVt0Wxk6P+G7ofrS/ZTwz0g9MR2P2gtfbnrflKP6Nie/7/7kX/pK8+D5FuXsS7f
         i9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Wa83KDJqEIQFwYhYvTrdA/0P1iUPtwhqUCll5VkxxTM=;
        b=eNp+8Dcx1cjFS1/IMjP9/2B7wdP+0V3NiZ7qFqgjx/v77KD5RIIypEcOqDjCFbCGn3
         c3RdjcSJJQzwScoqT5xg6j/s0QhdrwLNBjawcpv4aHNbMu8WM0fY6+uNexBDsuqJwwgJ
         ZYKD1lmXW0+xD5mip22iUYvOfeW+jKdehIDWrwvB774HhhjRL0ryIouSnB7dNFQC/J71
         I3qi1IWSngLGt2bUPfrmFxIfyXSZ4IUJAyqq0xbl2Jshco2LVPqUCrjyB8qeBuVUkshk
         z5mH/oaCn1e0rIpll2kKi0nl58VQoiUiXyeYGqA990s2R5S9Lm1Q0h/qpo2P2pB4BpOB
         AEtQ==
X-Gm-Message-State: AOAM531BXD7zq6YlX38rrUmlOtLDGuc7DlozUirMTReD4XEnPqJCK5ZJ
        QfwgWqsGsUJHpWg3pg7x0kM=
X-Google-Smtp-Source: ABdhPJwRaS0SMAw1qCu/TiUfeuovMZop0hM7vP4uKj/gyv19otcl5FvQai3oT5+iz6yElSNHMR5snw==
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr12954650ejr.217.1602217668965;
        Thu, 08 Oct 2020 21:27:48 -0700 (PDT)
Received: from felia ([2001:16b8:2d6e:f600:80f1:4ea4:2130:b98])
        by smtp.gmail.com with ESMTPSA id t16sm5463935eje.39.2020.10.08.21.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 21:27:48 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 9 Oct 2020 06:27:46 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Ondrej Jirman <megous@megous.com>
cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?ISO-8859-15?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] MAINTAINERS: Update entry for st7703 driver after the
 rename
In-Reply-To: <20200701184640.1674969-1-megous@megous.com>
Message-ID: <alpine.DEB.2.21.2010090623060.15995@felia>
References: <20200701184640.1674969-1-megous@megous.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1811521063-1602217668=:15995"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1811521063-1602217668=:15995
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 1 Jul 2020, Ondrej Jirman wrote:

> The driver was renamed, change the path in the MAINTAINERS file.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

This minor non-urgent cleanup patch has not been picked up yet by anyone.

Hence, ./scripts/get_maintainers.pl --self-test=patterns continues to 
complain:

  warning: no file matches  F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
  warning: no file matches  F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

This patch cleanly applies on next-20201008 and resolves the issue above.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Lukas

> ---
>  MAINTAINERS | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f186a661a9b..f5183eae08df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5487,12 +5487,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
>  F:	drivers/gpu/drm/panel/panel-raydium-rm67191.c
>  
> -DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
> +DRM DRIVER FOR SITRONIX ST7703 PANELS
>  M:	Guido Günther <agx@sigxcpu.org>
>  R:	Purism Kernel Team <kernel@puri.sm>
> +R:	Ondrej Jirman <megous@megous.com>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> -F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
> +F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
>  
>  DRM DRIVER FOR SAVAGE VIDEO CARDS
>  S:	Orphan / Obsolete
> -- 
> 2.27.0
> 
> 
--8323329-1811521063-1602217668=:15995--
