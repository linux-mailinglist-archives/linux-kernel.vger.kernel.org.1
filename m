Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED432B0F36
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgKLUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgKLUtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:49:18 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB12B22227;
        Thu, 12 Nov 2020 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605214158;
        bh=wrKaWD3LoEi3Ttr+MBj6uJxawKgQ0puebVWPB/EXaKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OAXMhXziASJ9REsiyRT2peJV1Eni+CQ+BxxB7kFyOWOmPL0t7MXJJHVZXZ8Vw9wYa
         k/tm6+ld1H/u1bxUqtTYnLLSfhxxnpPyrLSRB8mzNhOpIsX6bB96xdDpr4/puUVDa0
         RpPBwJYmQxFkGA4jWWgz8sxf5zuszFvylq35kQkw=
Received: by mail-oi1-f179.google.com with SMTP id w188so7950249oib.1;
        Thu, 12 Nov 2020 12:49:17 -0800 (PST)
X-Gm-Message-State: AOAM532WuUerCXQrBY4VzECSBUeXJ2kXfs/YcRv9sgYCow4GHfxcgsiW
        BaVJfqlo6q2S0fj8RMUzZ8XxLg3yO+6FNBRTTA==
X-Google-Smtp-Source: ABdhPJxcMk1WB5wVFqixYLOd/a/1Gfq63/2/MzkP3fgZwh7SStQ67/N9bG8B4VYXQBSpsfyYuH7oJ2H2gy6M000/fXU=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr1100963oib.106.1605214157168;
 Thu, 12 Nov 2020 12:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20201102203656.220187-1-robh@kernel.org> <20201102203656.220187-2-robh@kernel.org>
In-Reply-To: <20201102203656.220187-2-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Nov 2020 14:49:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKYA+8VgVNsoU4O1taYzJACntjm-i+Jm0GDS7KEf08F9A@mail.gmail.com>
Message-ID: <CAL_JsqKYA+8VgVNsoU4O1taYzJACntjm-i+Jm0GDS7KEf08F9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: Convert graph bindings to json-schema
To:     Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:36 PM Rob Herring <robh@kernel.org> wrote:
>
> From: Sameer Pujar <spujar@nvidia.com>
>
> Convert device tree bindings of graph to YAML format. Currently graph.txt
> doc is referenced in multiple files and all of these need to use schema
> references. For now graph.txt is updated to refer to graph.yaml.
>
> For users of the graph binding, they should reference to the graph
> schema from either 'ports' or 'port' property:
>
> properties:
>   ports:
>     type: object
>     $ref: graph.yaml#/properties/ports
>
>     properties:
>       port@0:
>         description: What data this port has
>
>       ...
>
> Or:
>
> properties:
>   port:
>     description: What data this port has
>     type: object
>     $ref: graph.yaml#/properties/port
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - Move port 'reg' to port@* and make required
>  - Make remote-endpoint required
>  - Add 'additionalProperties: true' now required
>  - Fix yamllint warnings
>
>  Documentation/devicetree/bindings/graph.txt  | 129 +-----------
>  Documentation/devicetree/bindings/graph.yaml | 199 +++++++++++++++++++
>  2 files changed, 200 insertions(+), 128 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/graph.yaml

I've decided to move this to the dt-schema repo instead[1]. I think
that will be easier to manage dependencies (audio-graph.yaml plus
anything else landing this cycle) than subsystems pulling a shared
branch. I haven't merged it yet, so let me know if any
comments/objections. Note that the meta-schema will have to come a bit
later once existing users are updated (which I have patches for).

Rob

[1] https://github.com/devicetree-org/dt-schema/tree/of-graph
