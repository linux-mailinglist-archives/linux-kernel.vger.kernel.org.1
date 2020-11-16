Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3FD2B4966
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgKPPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:31:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbgKPPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:31:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id w188so19210093oib.1;
        Mon, 16 Nov 2020 07:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+pvHe9ONFH5RZzgJjd3ukZBPKpFFsELzKrcCdDKF3yE=;
        b=nJmYlzRbMJ9CP10fRMA0ngv9+kJQ4Uxov5rTHHjBSZoA2xG1BLsu+q+S/0FeyNsp/z
         sS/SiCoAOVkVfttH7J4G04QN7tBOYZhM8la/SyGL11JVD1ZWfq5Ox0PAHEnZ0Cby5pQN
         zLiULz3NMDUFJNokuRHwk1wKfEPR74SqVP8hMw2v77QN0pCqH8RikI93mAreIozZ+4mx
         scwnd42R6o5JY2LKsLSKqJsD4KzeSeb5Cz0i7J8ZiOOukUr+TtRVu6xTuBa3YozvuTXf
         H4HagctYnvcJPh95m9uxE2ZYATF9gwwE4XTRKP8gpUuPGc0U0RT3mG3PcMG9r0THV4N/
         BIEQ==
X-Gm-Message-State: AOAM531Or5p1/8VzcVgdxqdPVWqHaU+ETeS8C0HI8xW/Arw7SHe3FZ7g
        7HvlVDr+dqmIA/rnp2QNXA==
X-Google-Smtp-Source: ABdhPJyPe2ARluS/HNUswsiTPnD0gC1vQpqVcbcOVBBdRCpkEL/h65S6ZJYBWFI68ZqwSrRQMtRDsg==
X-Received: by 2002:aca:b588:: with SMTP id e130mr32960oif.56.1605540697955;
        Mon, 16 Nov 2020 07:31:37 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s28sm4746616otd.2.2020.11.16.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:31:37 -0800 (PST)
Received: (nullmailer pid 1684683 invoked by uid 1000);
        Mon, 16 Nov 2020 15:31:36 -0000
Date:   Mon, 16 Nov 2020 09:31:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        devel@driverdev.osuosl.org, Vinod Koul <vkoul@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>, linuxarm@huawei.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Yu Chen <chenyu56@huawei.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/8] phy: phy-hi3670-usb3: move driver from staging into
 phy
Message-ID: <20201116153136.GA1684546@bogus>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
 <420faf39bb03d07f8823b03bc55a429e975e23a0.1605530560.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420faf39bb03d07f8823b03bc55a429e975e23a0.1605530560.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 13:59:27 +0100, Mauro Carvalho Chehab wrote:
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
>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   2 -
>  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 671 ------------------
>  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
>  9 files changed, 762 insertions(+), 757 deletions(-)
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


See https://patchwork.ozlabs.org/patch/1400895

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

