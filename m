Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B122B8D91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKSIfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKSIfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:35:31 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FEC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:35:30 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so5305736ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CUAPPILQ+HlU7cec+WyW0vmuUkycQGR+EKCfVOKR5DA=;
        b=xxlskXAtX870lOpywdkalnsMzFjOX7jemtarV+C0XroXPqfrChwDn/g05wGLVXiLwx
         DZv2npwrVk2RKdH45J7ZWqU2vAt1m10srMqDqYyRxB61d26qoaxXSMRTETG9DXJ2hAcJ
         N4kLWQX9cJNH3RH5lR3umlSF1OOyI0UJPv1RHKjx7zCyrRKjspUv/27o0lxRWuMcYYrI
         O+IiOqTP0Or30LBmpNOxt2QBo25FdQEYfEWRO4sFrMf/TPM8AMtiIRXUj9ZgCTQClZG6
         /2ulQQHD9n1kuB837CEi2PVIGJ89reg37c1AlK0zowtZLpiS7sfPwzHj9ot7ktmbWrJH
         bCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CUAPPILQ+HlU7cec+WyW0vmuUkycQGR+EKCfVOKR5DA=;
        b=LIM/MB95SuqnPxaabcGQm/vrGxcyn9/dKS1pGc3V6oDRk4BoFYvUuaDTqcu+7bUJ93
         IylokOoi0xf9jug6i3n3rquH4BtjmnI4PpXqLlSVD3R0h4OTYr980omZbc2cLg1qbok7
         A2Tzh7CjA/4zaJr3blifcB2sLlVLNi5HFhV1QF0XyrP7hy9THEWKd+Ab6HhRfsAw9MPG
         lfKLCnAyTiPIG+RHhistePTfODW1l6AHur2I4NYdfpENBPSPf58+aRpTb4ADhflcAGL4
         cqPONxCtvBrjH0h6n347/m1BfqG/iBYuxyQICK9d/UamvBoQJ4ACi6ng7hzmumH8c8or
         6yFQ==
X-Gm-Message-State: AOAM530Qgrog9bIY5odu5m0ltyQUA5VnCDbgZVtOh0QHvywkgFVng9D6
        GFRolg429tFbhAyRHgz92jcgmIgj8tzIIWieEchItaY2cUkyAhEN
X-Google-Smtp-Source: ABdhPJzb1eF+H7SQdr5ic1GZqIMIfLsKmdGEtadZ2F1hyOuZbWr/cgjdxlUVeSHl72yR9JRuHYa3dyZlsxsodk0gZic=
X-Received: by 2002:a2e:998e:: with SMTP id w14mr5942998lji.100.1605774929224;
 Thu, 19 Nov 2020 00:35:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605688147.git.agx@sigxcpu.org>
In-Reply-To: <cover.1605688147.git.agx@sigxcpu.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Nov 2020 09:35:17 +0100
Message-ID: <CACRpkda97nJ+nJX4CuZHQnDVh1mhykc_vb6xFh7BcAWQoNjz7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] drm/panel: mantix and st7703 fixes and additions
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 9:29 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> This adds new panel type to the mantix driver as found on the Librem 5 an=
d
> fixes a glitch in the init sequence (affecting both panels). The fix is a=
t the
> start of the series to make backporting simpler.
> It also adds a patch to make st7703 use dev_err_probe().
>
> changes from v1
> - as per review comments by Linus Walleij
>   - fix alphabetical ordering in Documentation/devicetree/bindings/vendor=
-prefixes.yaml
>     https://lore.kernel.org/dri-devel/CACRpkdao_TMcpRsdK=3D7K5fNKJse0Bqwk=
58iWu0xsXdDNdcffVA@mail.gmail.com/
>   - add reviewed by to all except 5/6, thanks

The whole v2 looks fine to me, I'd give the devicetree
maintainers some slack to review the DT patches then I can
apply the whole series unless you have commit access yourself,
just tell me.

For all v2 patches:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If you have time, please review my s6e63m0 series.
https://lore.kernel.org/dri-devel/20201117175621.870085-1-linus.walleij@lin=
aro.org/
https://lore.kernel.org/dri-devel/20201117175621.870085-2-linus.walleij@lin=
aro.org/
https://lore.kernel.org/dri-devel/20201117175621.870085-3-linus.walleij@lin=
aro.org/

Yours,
Linus Walleij
