Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A442F7FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbhAOPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:39:48 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33152 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAOPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:39:48 -0500
Received: by mail-oi1-f171.google.com with SMTP id d203so9964291oia.0;
        Fri, 15 Jan 2021 07:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jHmZbmprcEbR1QsC3/QO5a2FmEK+SUt/uIaHwmVakGg=;
        b=AZEkTKTZ7QsuTEiT/IbgPiVPM8DNMfOCKIXi/fjWvYAthLqAeIDQ0cXgHIWQbK2rv9
         ZHHM2KRnVOqLJ2S57ZHzr6hbYm1j/8WxInk6MXRS7ja3kWUOgGISN1l7e401trB4lBXc
         /ziPSGnxwWecmvif1eOdiEgVSVk5+JQnXJE/iujvlR8tLudE7t+rwD+bVKRJoJ7JyZKG
         K15JmAJHfC3xSrn+CyI6uj73y/cQcXAp2G291HLWpskyieRtqu9qB8o0LMymSKOYvCRC
         +QEtbOqSCtgck6aeB+f8CVjbF/3BGD0w5xXvrZa0/C+DlzsY4/M4xqzGul+zMTPaPSr/
         yXUQ==
X-Gm-Message-State: AOAM533u3Epe1Q68gSAxId4dNhDYP6Pzf67lq5YhUWHPBh69avuCKPG9
        SPWb1PoJytV0LBAsi/IyDA==
X-Google-Smtp-Source: ABdhPJxBM/BxN2PpIZ3KNI3NmCSctqZbH8H5vmUrdoawmsnh7sU76/EwJpngkxbcpxMYf7Ize5gBoA==
X-Received: by 2002:a05:6808:3bc:: with SMTP id n28mr6179439oie.118.1610725146938;
        Fri, 15 Jan 2021 07:39:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j194sm1702875oih.56.2021.01.15.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:39:06 -0800 (PST)
Received: (nullmailer pid 1311454 invoked by uid 1000);
        Fri, 15 Jan 2021 15:39:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Alex Dewar <alex.dewar90@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devel@driverdev.osuosl.org
In-Reply-To: <78e54d594b9e31d603d913048a7bc89d3a089608.1610697726.git.mchehab+huawei@kernel.org>
References: <cover.1610697726.git.mchehab+huawei@kernel.org> <78e54d594b9e31d603d913048a7bc89d3a089608.1610697726.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v3 4/4] phy: phy-hi3670-usb3: move driver from staging into phy
Date:   Fri, 15 Jan 2021 09:39:04 -0600
Message-Id: <1610725144.873753.1311453.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 09:10:03 +0100, Mauro Carvalho Chehab wrote:
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

See https://patchwork.ozlabs.org/patch/1426831

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

