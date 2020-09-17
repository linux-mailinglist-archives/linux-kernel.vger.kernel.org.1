Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2980526D6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIQIcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:32:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8D2C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:32:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t138so1448989qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNBztFDezqekJtC49rUbCsf0Z74k1dMsAl9uwNJ4HMg=;
        b=NE//sKAF5oHMFSx8NdDh3n1kEVjrLoAWs6HDtTaDZXdWadnlTrFLMOYgnIkJOBBL1g
         yR9aokrbfw7dTG1MLqmfDoeJKko2QFrspR3PFqQV+i7kLZQr7eE//YmOU13D2u2ZfC+L
         qtU4uVjhHR4WvGNM37FfTPitwNAI4hlrqJSHbKWsyjcRCuq080Vhpj4G5S4uWWbzRbZo
         YQQ0JXT5naMVZBihDayUFCaJKEeSVECsp8UBDl1ReaBjmVXiBCZFGoKRtvUo5Z88qI0c
         IwD4p9thFBzagOXcFhqz94mpBfb5odzheYwYx7DtsUgF6xOJamO0p8t+L6uS2uDucZXK
         ZopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNBztFDezqekJtC49rUbCsf0Z74k1dMsAl9uwNJ4HMg=;
        b=hx+T7/4XjekL5zVmBuPpgVS50t4DUDUpdK1meOQTkV7RhXO0oW7PcAPE114NHC3yZ5
         7OSQ8YnO0qw/Xwlx6/FWa8e+6KMECUjfeDtkMAZAgI0Ww2wX1gmTtjd7eidkDMvoOe8/
         G6I7k2A4kfCVKy+7Pl3NChAl+G80TJUD9fV0XjNqNvn6ZXjRo4rcDhhzSF50k4f9H97Z
         QXYAJZF32Nwe7U6aAooisOJb+pEX6FBVH/gzVgK1TQbcOK6CypbYw2lwd6AP9lNL3BRS
         mpEIfCQ6zXSXRuRoTSyIXoC6HM2EwnN3QPPiSZvzSAJ897GiC7nDeVR+3StgLUPVtAIs
         nWPw==
X-Gm-Message-State: AOAM5302ZaJmCdvoqjWIpdhFBzLuyhN8RKbeSppzRfM8L2JHjykY3MUp
        pc8O7Dcg9YeHkMCDQJyjgsdFI62D61mYPEVC55uZeg==
X-Google-Smtp-Source: ABdhPJzSbJKQwJomn0u0cTWLeQAt36WLYkPlwqjqb02SBfTghwU+ZRWQqWxtF7a+fSZQitCz8PQXGt4x+08VM1Y3waw=
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr25860117qka.421.1600331566286;
 Thu, 17 Sep 2020 01:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200917070543.19064-1-krzk@kernel.org>
In-Reply-To: <20200917070543.19064-1-krzk@kernel.org>
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Date:   Thu, 17 Sep 2020 10:32:35 +0200
Message-ID: <CAMxfBF5WWQX3ZH0YcRZ_N8q4njTdG-RA4eM+zyQwmK7tYvw6DQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: ti: ti,pruss: fix schema ID
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 at 09:05, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Add missing '#' to fix schema errors:
>
>   $id: 'http://devicetree.org/schemas/soc/ti/ti,pruss.yaml' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
>   $schema: 'http://devicetree.org/meta-schemas/core.yaml' is not one of ['http://devicetree.org/meta-schemas/core.yaml#', 'http://devicetree.org/meta-schemas/base.yaml#']
>   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml: ignoring, error in schema: $id
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index cf7dc83f724f..037c51b2f972 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml
> -$schema: http://devicetree.org/meta-schemas/core.yaml
> +$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

I've double checked and "#" was present in the original patch sent and
ack for upstream: https://patchwork.kernel.org/patch/11729649/
It seems like something got wrong on linux-next but this is the only
diff between original patch and one found in linux-next. Thank you for
taking care of it.

Best regards,
Grzegorz
