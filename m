Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8762D52A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgLJEKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgLJEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:10:31 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6937C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 20:09:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o5so2968642pgm.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 20:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xcTIK9EuU/nUrywQ42KgiTpojaNUUcCg7lCxBZYe+ro=;
        b=fnU7LyieLQoXRkcIpEG2TC3KGf26P25XUm6Aa6vvnyslUXabLXMqgRcSSk0q+a2ihy
         +Pzl5zOd0BFQiyuVETdHmIMeGm/KkS1MnMfWFVtHcse2QmqwFWUzMWzTUKj5D5x7ENBo
         GrN1HC56GzpnHhGR/+rRgD2jz/0h+izZOjbrfUV87HG130n2pspoymgRfrvWTKjj7Hrx
         xzCZCMUGrCDnGGF/kVXtirv9w3I2QAHMZLTaOlVABbsMKRaj4wkgzhVQCvFoj76/1oN3
         uPnbvD2PN+w42/aVF2V1qL+kvSYOu3ullENf5LsTKM5WAKwKjF1Axdgd7iHzUaAU79m5
         Z9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xcTIK9EuU/nUrywQ42KgiTpojaNUUcCg7lCxBZYe+ro=;
        b=ivA7URfsNWhVYzIVkZN7Yyn5CxOjM5NetVnq2xr2idgT3RgP+u3aTeEGCuYGfDkmN5
         ziEKQR2JE0BFzkFcBcTd6jBRrxeVE6CgoM4y/FVsJpHqdhMQe/AqAjnQDZx5ljXlk4Lu
         G55H5uJpoqfk2R7DhoTXtEcETqUG+WGOFVLCNHLDMLgqhguBB5k75vco18w+0EiyECSB
         u5gYu/yyPUJl5xUDUezpvaO7cCUmSuH3+EG/YliT890IXAKCOpjYA5VVRc2ngRlXxHX9
         g1TcsqIoUQYf5B6qSYAm4HYM2krnsxvpVk3CJyvYKrO/YvJPb7xO13i2tF0aCyczZI0F
         TyZg==
X-Gm-Message-State: AOAM530y4yRfUVY6S8fRz7uo3rZe5Wm3My+GZ5VQB5leeNVYJgvnLfWu
        xrl0f7uz2tjwbDch4zRhi5ou
X-Google-Smtp-Source: ABdhPJx79zoeXoS4V9GMiwip0g7YFZBRf2fkNcpngbFSVvFH5NMQ3Dqxbn0fdY79tWGZS1R4YEeA9Q==
X-Received: by 2002:a17:90a:d790:: with SMTP id z16mr5493949pju.88.1607573391179;
        Wed, 09 Dec 2020 20:09:51 -0800 (PST)
Received: from thinkpad ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id f29sm4587205pfk.32.2020.12.09.20.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 20:09:50 -0800 (PST)
Date:   Thu, 10 Dec 2020 09:39:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add support for Qcom SMEM based NAND parser
Message-ID: <20201210040942.GD6466@thinkpad>
References: <20201119071308.9292-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119071308.9292-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 19, 2020 at 12:43:04PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds support for parsing the partitions defined in Shared
> Memory (SMEM) of the Qualcomm platforms supporting NAND interface.
> Current parser only supports V3 and V4 of the partition tables.
> 
> This series has been tested on SDX55 MTP board which has an onboard NAND
> device.
> 

Any update on this series?

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v3:
> 
> * Handled le32 parameters in parser, collected review from Linus W.
> 
> Changes in v2:
> 
> * Added additionalProperties: false and removed unit address in binding
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: mtd: partitions: Add binding for Qcom SMEM parser
>   mtd: parsers: Add Qcom SMEM parser
>   mtd: rawnand: qcom: Add support for Qcom SMEM parser
>   mtd: parsers: afs: Fix freeing the part name memory in failure
> 
>  .../mtd/partitions/qcom,smem-part.yaml        |  33 ++++
>  drivers/mtd/nand/raw/qcom_nandc.c             |   4 +-
>  drivers/mtd/parsers/Kconfig                   |   8 +
>  drivers/mtd/parsers/Makefile                  |   1 +
>  drivers/mtd/parsers/afs.c                     |   4 +-
>  drivers/mtd/parsers/qcomsmempart.c            | 170 ++++++++++++++++++
>  6 files changed, 216 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
>  create mode 100644 drivers/mtd/parsers/qcomsmempart.c
> 
> -- 
> 2.17.1
> 
