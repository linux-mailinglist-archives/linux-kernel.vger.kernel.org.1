Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043C22AC01C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgKIPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:42:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35770 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKIPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:42:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id c80so10649164oib.2;
        Mon, 09 Nov 2020 07:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qDCEpBkFLulC00NVUrlJOaEfoieaKfsOXl1ZnSUUlrc=;
        b=q2i18BmuH62GxVDtK/57VEvvhuqyhJCkBbqldpRkBdigBkgPkZ46quiLPmTIB1sAE5
         P6U+nd8DYx6T5DzygUpr3fioDkj8c0yTkGJSeUWackc53uU+qmVgmkUy6/YhAW0hYojy
         A5OY2vNreNZIbEj1VzE51/hEXUjPp8/Q/YJ8lVaCcRfm6Puj6E8jwEoxngMi4qknQ+HR
         W9yCjAlwM+c6V4lyB5v+Hp+nwtvQSG80beEZSCHezI2s3q0sF/giB86qRnVZc1vGLjH3
         0MDd1NjS8VwHmoSkemRLa3Ww6FdyY0WE844s1/d2DYZykC+bZGuWeA2t6uKuek/qj18a
         Kt3g==
X-Gm-Message-State: AOAM5302J+FPWQroTPmlebiH5WDP7vbIp4wJgMeIofZb0VNyyuSZl684
        MUF7rXzy1F2+ByL2bUnEcA==
X-Google-Smtp-Source: ABdhPJwljMkcqsk2ICLQs/kbA6TgKKVTl0MP55hDMb1X5tEip+2F+I7aH4IkZraz/rREs1cBsMTFaw==
X-Received: by 2002:a54:4614:: with SMTP id p20mr8997965oip.131.1604936535633;
        Mon, 09 Nov 2020 07:42:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5sm2581843otb.44.2020.11.09.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:42:14 -0800 (PST)
Received: (nullmailer pid 1341840 invoked by uid 1000);
        Mon, 09 Nov 2020 15:42:13 -0000
Date:   Mon, 9 Nov 2020 09:42:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     kishon@ti.com, vkoul@kernel.org, dongsheng.qiu@ingenic.com,
        linux-usb@vger.kernel.org, paul@crapouillou.net,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, rick.tyliu@ingenic.com, balbi@kernel.org,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        devicetree@vger.kernel.org, aric.pzqi@ingenic.com,
        yanfei.li@ingenic.com
Subject: Re: [PATCH v8 2/3] dt-bindings: USB: Add bindings for Ingenic JZ4775
 and X2000.
Message-ID: <20201109154213.GA1341312@bogus>
References: <20201107094758.83291-1-zhouyanjie@wanyeetech.com>
 <20201107094758.83291-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201107094758.83291-3-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020 17:47:57 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Move Ingenic USB PHY bindings from Documentation/devicetree/bindings/usb
> to Documentation/devicetree/bindings/phy, and add bindings for JZ4775 SoC
> and X2000 SoC.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v8:
>     New patch.
> 
>  .../{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml}         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/ingenic,jz4770-phy.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 124
make: *** [Makefile:1364: dt_binding_check] Error 2
./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/phy/ingenic,phy-usb.yaml#


See https://patchwork.ozlabs.org/patch/1396098

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

