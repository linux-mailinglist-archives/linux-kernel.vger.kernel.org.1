Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792252F6EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbhANWyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:54:52 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46733 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbhANWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:54:52 -0500
Received: by mail-oi1-f169.google.com with SMTP id q205so7618856oig.13;
        Thu, 14 Jan 2021 14:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qWYHygthLZ8mTq8gd7jEV6pMc0SdpN8hLLa0SmpOOjo=;
        b=bf/QebiVqgzxZ9uSPgEpR80U4njopdBPvZwyAQkf8JQsND505/+ebjvHR2TD4nBSzk
         ss3EXJuAINnUsdmZ2CxuG2cTrBFJOJsGvaPfXGPj8DDpewSeRdB7kBj48+UYC+DYSAVC
         9XT/7fKO/lw5h69WNfwVH2qXH8c7AWEKCMv4xuyTucwEwgagQEGE/rV6kWS6a8HVf6V+
         hJ8UX+PSLFbHyIU9XV0GuHpYZ+UVxxNg2QqA68kWjjgru0+Q2LO/hPvKf6rtIZZmzeDA
         JM9FBdvwLiYmQmTJtGwRslZGqUTa3USWktdwjv5TGAM/dP4iHRu1gzkGB6SV+tQkORXW
         vZRw==
X-Gm-Message-State: AOAM530IGA3bmA6COd4Tdjna2gyWUy27Fufnl2ugsmGsF4+04BoedrZE
        ZzZ4iD9lrYTe/KwCqNbRsQ==
X-Google-Smtp-Source: ABdhPJzyV0763obF7cbS9CXWkgMfwQPg33Rx08ZaO2ZOKRwYv+4ZxDG0NYjU132wwc6AGyIgeSrnpg==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr3941097oic.47.1610664851178;
        Thu, 14 Jan 2021 14:54:11 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h11sm1403197ooj.36.2021.01.14.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 14:54:10 -0800 (PST)
Received: (nullmailer pid 3797266 invoked by uid 1000);
        Thu, 14 Jan 2021 22:54:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Alex Dewar <alex.dewar90@gmail.com>,
        devel@driverdev.osuosl.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org> <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 4/4] phy: phy-hi3670-usb3: move driver from staging into phy
Date:   Thu, 14 Jan 2021 16:54:06 -0600
Message-Id: <1610664846.682257.3797263.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 18:35:44 +0100, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
>  MAINTAINERS                                   |   9 +-
>  drivers/phy/hisilicon/Kconfig                 |  10 +
>  drivers/phy/hisilicon/Makefile                |   1 +
>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   2 -
>  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
>  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
>  9 files changed, 759 insertions(+), 754 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
>  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
>  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
>  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/phy/phy-hi3670-usb3.yaml#

See https://patchwork.ozlabs.org/patch/1426545

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

