Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E77301F49
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAXWfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 17:35:02 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43041 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbhAXWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:34:41 -0500
Received: by mail-ot1-f54.google.com with SMTP id v1so10992061ott.10;
        Sun, 24 Jan 2021 14:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sUxV2b7wGawYEC5FIv++pO5NHfyG0Mp9G5syyI9rZCg=;
        b=TKe74aFSYylTZ19okTaYPbklIHhx4T+RyTTUTev5Ro88qIqhEaWhGv3Jz2/lt9nWVp
         es1g+Ip5y6ArIv/hX9T83d00zE3rK8wduA8Ph5P3QbrX5sY79x4T5RnAfF8up8ve6g4O
         R9n/wOrmYnm1j4tCtBYmTKQYTgjQ2dyU1dPYkJDtY7i5WVPwe4cGbCrb5M7N26vQ+iPA
         SnjGPcP8pdDHvfTkXMSMSBzVKJ4IhfJ7Se8op7De7vzbbPVLGlZUn7lErrNPn+3k8H+b
         jcOuv8AyHY20vlg0st78Mgxq3N8wtasfqoeKBtFyzvs8YYqWZ8BHWERjDS+ybn4xj3II
         nrGw==
X-Gm-Message-State: AOAM532Io4DsAdYJX3Qrl2j/RPNhBCyZORsHJnRgCpEQOS5DzUP3g2aA
        T3GhcbwDDqywT0rLA+Fatg==
X-Google-Smtp-Source: ABdhPJxqG8WwSxKIMV6aju0QMF8agto2b2/nh8Cn7sFNdg46AD/44AxS+S0LjOBlip94axow/YXSqA==
X-Received: by 2002:a9d:6d91:: with SMTP id x17mr27596otp.16.1611527640710;
        Sun, 24 Jan 2021 14:34:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm3125666otk.8.2021.01.24.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 14:33:59 -0800 (PST)
Received: (nullmailer pid 2741591 invoked by uid 1000);
        Sun, 24 Jan 2021 22:33:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        =?utf-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
In-Reply-To: <20210123141825.15481-1-paul@crapouillou.net>
References: <20210123141825.15481-1-paul@crapouillou.net>
Subject: Re: [PATCH v2 1/2] dt-bindings/phy: ingenic: Add compatibles for JZ4760(B) SoCs
Date:   Sun, 24 Jan 2021 16:33:56 -0600
Message-Id: <1611527636.618832.2741590.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jan 2021 14:18:24 +0000, Paul Cercueil wrote:
> Add the ingenic,jz4760-phy and ingenic,jz4760b-phy compatible strings,
> and make the ingenic,jz4770-phy compatible string require
> ingenic,jz4760-phy as a fallback, since both work the same, and the
> JZ4760 SoC is older.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Fix indentation
> 
>  .../bindings/phy/ingenic,phy-usb.yaml         | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.example.dt.yaml: clock-controller@10000000: usb-phy@3c:compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4770-phy'] is too short
	'ingenic,jz4770-phy' is not one of ['ingenic,jz4760-phy', 'ingenic,jz4775-phy', 'ingenic,jz4780-phy', 'ingenic,x1000-phy', 'ingenic,x1830-phy', 'ingenic,x2000-phy']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.example.dt.yaml: usb-phy@3c: compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4770-phy'] is too short
	'ingenic,jz4770-phy' is not one of ['ingenic,jz4760-phy', 'ingenic,jz4775-phy', 'ingenic,jz4780-phy', 'ingenic,x1000-phy', 'ingenic,x1830-phy', 'ingenic,x2000-phy']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml

See https://patchwork.ozlabs.org/patch/1430732

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

