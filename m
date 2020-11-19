Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACA2B8AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgKSFQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKSFQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:16:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D0C0613D4;
        Wed, 18 Nov 2020 21:16:53 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so3539996qtp.7;
        Wed, 18 Nov 2020 21:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3EsZPkEoXT4zxYNqPu9hgFRzc3MjaFuHgLigF/TdUA=;
        b=mB18Ck6Tz7z0cXqOihGrAMiJ/GnPs9KT900EfdjJLwpeP5GN4lwiXu3CAijjoyu7zs
         d1NJ0vPeWKwN3Zg1DbXu/cE7WCd1rfOSy5iV78pV2EGE1+PBA0KhLx8MTGTJjxEo37so
         K8s2xLtBBa4HkGUE8ZwHgSxApEXIWuNn2UyHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3EsZPkEoXT4zxYNqPu9hgFRzc3MjaFuHgLigF/TdUA=;
        b=XIjJO7wztMSuCP2qZw+DGDzV0tvHKCCMarBfTJXTW22lwt511Al6MgbnsHSJ0Y4tWa
         z/bLxz3BIp31lUVdQeIkk7x0btICms6GX7HTBFBtuT4oFR+FM6EZiTyDo+YU/xqCnqda
         NpR8XqjneSSRHN48BS6VUWLtMUQ/RfVpK3EfPOBq2EAep6HD5HkRL2KSE94pmsDDon2O
         5WQwlS+UdgZfy8f4GinrSuYydCCynG4Au4G0j7RHZBSA0W3NLlMK+f/kYflgfm51BGFQ
         OSlcQHU3mBd2hqgarhWCc+zQRW2FO1EIGytFI82jhioZrWop5hAB2GsVuHwZafnOXqY7
         S7iQ==
X-Gm-Message-State: AOAM532K5uvdZxtxaSWDUp9f4KDQn1Zx6EU7NWlXVz2t5JwipcNx+1Rw
        KOTqpK5pXT1t02ZbvOQM+Fn78YlLzfp7IAMwfXNOoGixUYtBZA==
X-Google-Smtp-Source: ABdhPJwaZ2P8OVw0eTYSMERex8ss/IbbVRE4igK+EhHFqzAxCx62g6h7rOfvyNtGh1y12f4jZ5BPpknmovuWitSNJOQ=
X-Received: by 2002:ac8:75c9:: with SMTP id z9mr9218129qtq.363.1605763012893;
 Wed, 18 Nov 2020 21:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20201022014731.2035438-1-andrew@aj.id.au> <20201022014731.2035438-2-andrew@aj.id.au>
In-Reply-To: <20201022014731.2035438-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Nov 2020 05:16:40 +0000
Message-ID: <CACPK8XeGoJWt_DW0q-mZf7LKTM_mFPWf8odL+BUjA7FDzL=y3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ARM: dts: tacoma: Fix node vs reg mismatch for
 flash memory
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 01:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The mismatch lead to a miscalculation of regions in another patch, and
> shouldn't be mismatched anyway, so make them consistent.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Fixes: 575640201e66 ("ARM: dts: aspeed: tacoma: Use 64MB for firmware memory")
Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index 4d070d6ba09f..e86c22ce6d12 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -26,7 +26,7 @@ reserved-memory {
>                 #size-cells = <1>;
>                 ranges;
>
> -               flash_memory: region@ba000000 {
> +               flash_memory: region@b8000000 {
>                         no-map;
>                         reg = <0xb8000000 0x4000000>; /* 64M */
>                 };
> --
> 2.25.1
>
