Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8C21F8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgGNSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 14:01:55 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42858 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:01:55 -0400
Received: by mail-il1-f195.google.com with SMTP id t27so14949372ill.9;
        Tue, 14 Jul 2020 11:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSpgOvwlN47x6DPVrtxLSXxqcuUY+XXj9Joyu4Ctj7M=;
        b=fjkiMq/Z+V+Zh8RPQZYxB65WqYzxZPDlbimBXprvgzNUL9GL2K+KPhlbOekBIU5bBv
         ic8SfERzh6U4Bx7623+P4dH8tSTL6dPS6hC0dvYb4gsNs9vwpBjBSAuq1m1h0afrUhot
         IZtm+wHgYPICq22911gm5mwTEDIni2zOuagUPMAuFfnzN7gYuFMj5VW88cQ64BI6daRU
         gTjfnDiIzkP84qEgQSyblLvIUH1wwVKmh9t7k0EA+QmHzMVcuLbgxND62Dk0XTDgllzp
         Sob/slMGtC/FDEZOPfn34PF37U24hWh310zITPsrYwGNU6iO+zM1wUFS5wGPNGvRyBNk
         jV0A==
X-Gm-Message-State: AOAM530tfwvhdjDaiGJj1Pm171iR5fTrvwRK43dYXtKpl+eg7UAhos5q
        nSc7qVb+CxReAmkhcN6KPQ==
X-Google-Smtp-Source: ABdhPJxEgcafXXyb16LmwyglpFw9HdqPPxSf5Ulikof0SJ9B1PG6vWPgFvCZ9//LAhpato+pi7dB5Q==
X-Received: by 2002:a92:49c3:: with SMTP id k64mr5438219ilg.278.1594749713943;
        Tue, 14 Jul 2020 11:01:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q4sm10170382ils.11.2020.07.14.11.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:01:53 -0700 (PDT)
Received: (nullmailer pid 2634305 invoked by uid 1000);
        Tue, 14 Jul 2020 18:01:52 -0000
Date:   Tue, 14 Jul 2020 12:01:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kishon@ti.com,
        andriy.shevchenko@intel.com, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, balbi@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: Add USB PHY support for Intel
 LGM SoC
Message-ID: <20200714180152.GA2633416@bogus>
References: <20200714042621.25850-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200714042621.25850-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714042621.25850-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 12:26:20 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add the dt-schema to support USB PHY on Intel LGM SoC
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.example.dt.yaml: usb-phy@e7e00000: '#phy-cells' is a required property


See https://patchwork.ozlabs.org/patch/1328612

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

