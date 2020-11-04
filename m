Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96C2A6D41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgKDS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:56:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39423 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgKDS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:56:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id u127so23244798oib.6;
        Wed, 04 Nov 2020 10:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0XEiHKaxPQoGBzkJTgPLIitnCQW5/vfKvy+CJgTVM8Q=;
        b=PTR0T1qBD6maq7s9B3uvihJHJ267UqQdcrd0PSyIqQLohguXAbUzQ2cMa2lYYwcbiW
         7RexbVjbxXiIw8grtJkajSaz8JVT5xNof8ufoRe+/2b4D9YrP8oU+PfNLXOMEAekUHx4
         MYYWYOBozvlOpg2f3JwIXmYKcMQ313sXcAxy/awZSK9vfdCG9pWXtsTtSKelyaWrDjux
         DS3Epsv6OAFBywKi6lGNRa31hzJd/lHTqwMrS0xafMgG3fAMT/yefW+RHL/FDT+7G2vl
         2cLfVKjqZqe7+IjPK5YmaSe8Xcf5+tGp3CBMAO9JouVscdlIDWmRj++2c2fQwFLtEAL4
         slkQ==
X-Gm-Message-State: AOAM5334xYS/OtyXc7fh0gsIE5cizpZ235jF1h9v4pkq9T9w//u0Vuy8
        30UPeD32NTlL5aYXJELxFQ==
X-Google-Smtp-Source: ABdhPJyaOibrhV7F8kOT261dvo4CbhNDDnJYzlIf57VZltVSNy8xE+XIZlEnlvTbKIfwioYeAT3SoA==
X-Received: by 2002:aca:d6d3:: with SMTP id n202mr3299298oig.74.1604516192680;
        Wed, 04 Nov 2020 10:56:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w79sm645606oia.28.2020.11.04.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:56:32 -0800 (PST)
Received: (nullmailer pid 3946584 invoked by uid 1000);
        Wed, 04 Nov 2020 18:56:31 -0000
Date:   Wed, 4 Nov 2020 12:56:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh+dt@kernel.org, cheol.yong.kim@intel.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        vigneshr@ti.com, devicetree@vger.kernel.org, dinguyen@kernel.org,
        qi-ming.wu@intel.com, linux-mtd@lists.infradead.org,
        richard@nod.at, simon.k.r.goldschmidt@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 1/2] dt-bindings: mtd: Add Nand Flash Controller
 support for Intel LGM SoC
Message-ID: <20201104185631.GA3946406@bogus>
References: <20201103075655.18699-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201103075655.18699-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103075655.18699-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 15:56:54 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add YAML file for dt-bindings to support NAND Flash Controller
> on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml:24:8: [warning] wrong indentation: expected 6 but found 7 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1392698

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

