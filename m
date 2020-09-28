Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD727B42A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgI1SN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:13:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44231 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgI1SN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:13:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id 185so2341256oie.11;
        Mon, 28 Sep 2020 11:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+LFT48gOou1aJ5G0tYx1NAUVZxA2ojMKFiWctiBnaU=;
        b=WI3NwGK6YGuTLYAx3XpZKVoAr7halzeLx5zVHo0n/WsUVr+XIc5i0Mc2TOuNqq98Gt
         n6XXIJD+54xjo7eGnehf5RZom0cn1kczUOfogUQP3KYbuzheV6kTDOgu72Jd4hYflmdZ
         VsmsajmSiwqslD7WBwBUOBSmBTqwMIJw6HVLFsjg2vM7FOaZTaBzcr61r8mh4yWOnqUY
         xlLCtXk2OCeqdPRIrasg4DcySQg9jODYP8l5KaPq+5bkqJxvPcgJXc+4xOc6PhFbBmAt
         kg6JMiPQmNIlqf32iGcZUCCh9XvDXppzS3eKMpfJ6SYrFKMZe59V3wOYo7QHek8gFR33
         S8ZA==
X-Gm-Message-State: AOAM532s+NxOUdvyCcc7tbuakGSpduxk6Zx7WmJg3RNag/3f2vSnKOC7
        TJuHVMwwRhRuCVwpG86ODA==
X-Google-Smtp-Source: ABdhPJwmgv/JxdRzTCDQS3v+z01Q7Pike00GyRAyHYYYWnAo2d7N+bIui+ITe3SOcZhZeqE+D+tIEQ==
X-Received: by 2002:a05:6808:ab5:: with SMTP id r21mr86166oij.25.1601316804232;
        Mon, 28 Sep 2020 11:13:24 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm394881oto.62.2020.09.28.11.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:13:23 -0700 (PDT)
Received: (nullmailer pid 3012736 invoked by uid 1000);
        Mon, 28 Sep 2020 18:13:23 -0000
Date:   Mon, 28 Sep 2020 13:13:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: add properties for hard wired devices
Message-ID: <20200928181323.GA3012372@bogus>
References: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 14:39:50 +0800, Chunfeng Yun wrote:
> Add some optional properties which are needed for hard wired devices
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-hcd.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml: usb@a6f8800: #address-cells:0:0: 1 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/usb-hcd.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml: usb@a6f8800: #size-cells:0:0: 0 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/usb-hcd.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.example.dt.yaml: usb@ffe09000: #size-cells:0:0: 0 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/usb-hcd.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.example.dt.yaml: usb-glue@65b00000: #size-cells:0:0: 0 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/usb-hcd.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.example.dt.yaml: usb-glue@65b00000: #size-cells:0:0: 0 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/usb-hcd.yaml


See https://patchwork.ozlabs.org/patch/1372394

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

