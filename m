Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059AB2D2230
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgLHEmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgLHEmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:42:06 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE910C061749;
        Mon,  7 Dec 2020 20:41:26 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 1so15027803qka.0;
        Mon, 07 Dec 2020 20:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xAIRxZDmd0XZZCAdm94Qdv5VUeF43D2RsyIh6eKGGf8=;
        b=aLVRcQaWSKpqoJIePAI/5QzPxQis2faRVW/VFZ5UJWPmGydXf4tn/RZpEMzb2WFAgA
         ecaOidkljzudozM+9Z4VuaDaSPcF7zyZOrf/21oPrNahZWyBwU20gtPfvo15L735ARN2
         5o9Df56HE0F2Hpu6st6+7pn77TpmF5xKV3xwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xAIRxZDmd0XZZCAdm94Qdv5VUeF43D2RsyIh6eKGGf8=;
        b=pjsl9Vi95PNp0GaTpRyo6kdib/gXxH5TjQUfRP+RWPWZigIDkRN8mv33whGWGSSsdH
         nyBC/SaBPhq2Gn5u5KR8uYE01lVOsMfQYpV8fDdvkIoAsVAUTjp+z5MOpj0EOoMdj39o
         YFzS4W2KOnfhzPo5Qi7Xkj+IDRJP1rdpjKsLV9ScWC8freJ/7bcVjoiSVLse3XDvANr/
         XvXl1IFaHfpV64A/5gWhiUJ3K4xIrMvVeXpS5+oc9DnEtm6oqttBGJlOWYPNbA2Xu7mR
         tjgZv9NUfqqGPdZtgistrbyvlBLxPnyAjiQwPvC3bho90hzocs+7LAt+9HRvDz+V/kH/
         WKbQ==
X-Gm-Message-State: AOAM533JqyGxHOZc88xNCMC1Ncoo8XyLuM6u+nfc6osEG6zxflcwlBTv
        gndSWwpXiKHlCAnYmgW6rZ/jSolNLXQyQ8AfkDo=
X-Google-Smtp-Source: ABdhPJxmdrw0TtSmL+AL8U2C/OLTmrt1tudiPGj4GJBtaDoK7gFoLVARHFL4NtJMz5F6gpjMaNv/0eKZoOfHassNv9c=
X-Received: by 2002:a05:620a:7e8:: with SMTP id k8mr27401044qkk.273.1607402485842;
 Mon, 07 Dec 2020 20:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20201208043700.23098-1-quan@os.amperecomputing.com> <20201208043700.23098-2-quan@os.amperecomputing.com>
In-Reply-To: <20201208043700.23098-2-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Dec 2020 04:41:11 +0000
Message-ID: <CACPK8Xcs6ED5C_2RHrG0Bipn8sjPK7yBjcYvJ=UT6w2SRm0swQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add an entry for AmpereComputing.com
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Tue, 8 Dec 2020 at 04:37, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> Add "ampere" entry for Ampere Computing LLC: amperecomputing.com
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Signed-off-by: Phong Vo <phong@os.amperecomputing.com>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>

Do you take this through your tree?

Cheers,

Joel

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 3a76c226771b..a83fa090f3d4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -85,6 +85,8 @@ patternProperties:
>      description: Shenzhen Amediatech Technology Co., Ltd
>    "^amlogic,.*":
>      description: Amlogic, Inc.
> +  "^ampere,.*":
> +    description: Ampere Computing LLC
>    "^ampire,.*":
>      description: Ampire Co., Ltd.
>    "^ams,.*":
> --
> 2.28.0
>
