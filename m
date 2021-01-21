Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E222FEFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbhAUQDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:03:44 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44695 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbhAUQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:02:42 -0500
Received: by mail-ot1-f54.google.com with SMTP id e70so2033701ote.11;
        Thu, 21 Jan 2021 08:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2tzVo1gEasCl0YCZ92fiTthzPBICYQwlZE9cpKlcixo=;
        b=HPlQfhJ9QO7iL+4vOLTHCDBSNE2Kv6/axuX3tRqZxhFcG3KU2XmaXFoC7lcsuomgBO
         Wk9ZOE2B+SuxAAeWJxzddvvAqyqXhfq3nIEKLkRLuxMQJU5wNXE70I/tbjRz4d3COv64
         8+gVWlSCgsA+va5ZkELri3z6cAlNByGjciFIVXPpTC6fGAz1oD+SgZJy4qqMhl2zRAoy
         RHfFyKD9Q5SVtEHaZpjMWlvSNPEHPCVojtwJvIu7P28gHHeOOKcBIIqLrTczT2rMi1MK
         R8CN9vS8lvuTQdXYpAvbSlUGpnRWeocH3fCWawdR6IA4w2Sw/uFpng+njJ8RrkDJK8Yo
         lApg==
X-Gm-Message-State: AOAM532LzV1dNWcI1T/lmOY+wuKxJXyX+MqItPRZ8SVtEvBH3/VNtFmz
        8SyIyC2izjSMsei0kYOQSg==
X-Google-Smtp-Source: ABdhPJwtmCxz6lCSZqaCUVCGTBcWQXzHyS1G27t3YTHBnM9GbgZ8NU5PnYFEmS1HKWaxyaxLbez0pA==
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr1289938otq.41.1611244920486;
        Thu, 21 Jan 2021 08:02:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n1sm448635oog.31.2021.01.21.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 08:01:59 -0800 (PST)
Received: (nullmailer pid 2814839 invoked by uid 1000);
        Thu, 21 Jan 2021 16:01:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20210120115945.29046-1-paul@crapouillou.net>
References: <20210120115945.29046-1-paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings/phy: ingenic: Add compatibles for JZ4760(B) SoCs
Date:   Thu, 21 Jan 2021 10:01:58 -0600
Message-Id: <1611244918.513054.2814838.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 11:59:44 +0000, Paul Cercueil wrote:
> Add the ingenic,jz4760-phy and ingenic,jz4760b-phy compatible strings,
> and make the ingenic,jz4770-phy compatible string require
> ingenic,jz4760-phy as a fallback, since both work the same, and the
> JZ4760 SoC is older.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/phy/ingenic,phy-usb.yaml         | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml:28:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.example.dt.yaml: clock-controller@10000000: usb-phy@3c:compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4770-phy'] is too short
	'ingenic,jz4770-phy' is not one of ['ingenic,jz4760-phy', 'ingenic,jz4775-phy', 'ingenic,jz4780-phy', 'ingenic,x1000-phy', 'ingenic,x1830-phy', 'ingenic,x2000-phy']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.example.dt.yaml: usb-phy@3c: compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4770-phy'] is too short
	'ingenic,jz4770-phy' is not one of ['ingenic,jz4760-phy', 'ingenic,jz4775-phy', 'ingenic,jz4780-phy', 'ingenic,x1000-phy', 'ingenic,x1830-phy', 'ingenic,x2000-phy']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml

See https://patchwork.ozlabs.org/patch/1429154

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

