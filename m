Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99F72FFDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAVIOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbhAVIO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:14:28 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB69C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:13:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o20so3235687pfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gC7rk0hC8Zt8EImbc+l8NzK6TAlu0aggpClSObCpidU=;
        b=P3JxhjaIvdObM6aJYWr90L23Dzb8CMOC0rk24BlBQjbWg/a16XWIpqlZWm2eUo8MLW
         hAs74iu2Wt4jV6QJsRLQAVEpMGT5NJZFEcij38O9sWPaYQK5UdpoJAXoPHotHG61HZZo
         1q26pUDgt46Qtt/6ZhJ9VvrCNSaGD2get1xX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gC7rk0hC8Zt8EImbc+l8NzK6TAlu0aggpClSObCpidU=;
        b=nlExkvn3MkN4gqhi4pASLJVlxmUbIS/On6jf6i/ANXcsAPuHq33vsM3zwDmpGZX2eE
         kbyDKPbHcQB/zZ4d8eABkl3UjaeW43W9CDa+JU4+0BffCtWAoyVnfRhWfIj4bgD+E3ne
         qXG2ofs9LWlBvQgtdxaSiiF8TyQzNxAvdq/bJP0EbWXLCMQh4Y43vKvO+Cw1JpI7X4t8
         45v5juHf9bpeEFk9I0W0OOEDIa3vJGpctpOXb0oqZdvsgPQOCzxxnjW/zMX7pEcwN8/A
         oeFUkZVuKG8YaKYgwp7o5LznLLoHZDSI3ImbQ8SZ0GXIv6sk0G3OxdFYee6Zr9M9dvpz
         9VeA==
X-Gm-Message-State: AOAM5311CAoiYAWq4Lp8LWBDsLMHsGMn4cjYrWcIK3TSMdv79mmbo1Vh
        Si6fIzR2lJjOC7vhpKEb6gr3qJ7rTAtnpJZkRlB75w==
X-Google-Smtp-Source: ABdhPJyM3pSZTW1WdYHk/1SR5PgWHt193cq01FIJIaGqXj4HpsTsYOx/wM/7f75n5uC4pyDdv/SsJX4z0m21si6nkEA=
X-Received: by 2002:a62:8895:0:b029:19e:92ec:6886 with SMTP id
 l143-20020a6288950000b029019e92ec6886mr3625801pfd.12.1611303223430; Fri, 22
 Jan 2021 00:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20210115112331.27434-1-crystal.guo@mediatek.com> <20210115112331.27434-2-crystal.guo@mediatek.com>
In-Reply-To: <20210115112331.27434-2-crystal.guo@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 22 Jan 2021 16:13:32 +0800
Message-ID: <CAATdQgA5pKhjOf5gxo+h7cs7kCts3DeKGU5axeX2t+OaJFHyBg@mail.gmail.com>
Subject: Re: [v7,1/2] dt-binding: reset-controller: mediatek: add YAML schemas
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     p.zabel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <Yingjoe.Chen@mediatek.com>, s-anna@ti.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>, Yidi.Lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 7:23 PM Crystal Guo <crystal.guo@mediatek.com> wrote:
>
> Add a YAML documentation for Mediatek, which uses ti reset-controller
> driver directly. The TI reset controller provides a common reset
> management, and is suitable for Mediatek SoCs.
>
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  .../bindings/reset/mediatek-syscon-reset.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
>
> diff --git a/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
> new file mode 100644
> index 000000000000..85d241cdb0ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/mediatek-syscon-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Reset Controller
> +
> +maintainers:
> +  - Crystal Guo <crystal.guo@mediatek.com>
> +
> +description:
> +  The bindings describe the reset-controller for Mediatek SoCs,
> +  which is based on TI reset controller. For more detail, please
> +  visit Documentation/devicetree/bindings/reset/ti-syscon-reset.txt.
> +
> +properties:
> +  compatible:
> +    const: mediatek,syscon-reset
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  ti,reset-bits:
> +    description: >
> +      Contains the reset control register information, please refer to
> +      Documentation/devicetree/bindings/reset/ti-syscon-reset.txt.
> +

I remember that Rob didn't like adding new users of this property,

How about removing this from here and using a hardcoded version of
register layouts into driver code (and match it with compatible) ?

e.g.
struct ti_syscon_reset_data mt8192_reset_data { ... }

> +required:
> +  - compatible
> +  - '#reset-cells'
> +  - ti,reset-bits
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/ti-syscon.h>
> +    infracfg: infracfg@10001000 {
> +        compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
> +        reg = <0 0x10001000>;
> +        #clock-cells = <1>;
> +
> +        infracfg_rst: reset-controller {
> +            compatible = "mediatek,syscon-reset";
> +            #reset-cells = <1>;
> +            ti,reset-bits = <
> +               0x140 15 0x144 15 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +            >;
> +        };
> +    };
> --
> 2.18.0
>
