Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2362B496C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgKPPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:32:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36589 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgKPPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:32:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id n89so16368842otn.3;
        Mon, 16 Nov 2020 07:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jms1tjLF1eND3pvYwF99TGV28gY+b78u9W1AZwIrB3M=;
        b=gRhWLvinMLYG8J36JobgVJ8PDD8FJR4m6aUkGpx9jUDvCcb2Hz/LQALJC+/aNkZIhi
         P92VsVFFQ9a+rapFCqnF51Y5VcwERl//EzyJwhojpNAfX8F7QMwZim7A1eoGzbjDW0S0
         2+8Fpzd67N+UF4/nWQ1fpG7RjxJHQr4tru6J0KLDAkjhhpnPJKELSThJ4lUPeZ1BVF0S
         yf/6clRsij9rLFXH+uy2K8SAmDejZrz22pLud+ugFvM0w66Qh4pJR79o1aDGwecYJp+1
         TSohOfZ4f7RfybpXkCWJ40d2+j3jPGfGihgoLZbMi+8+Mr8aLoK4Hc2/IId0gemjl8QG
         vXGw==
X-Gm-Message-State: AOAM533eKyjgSMTKCuYFUwZyWXNxjCdCcijP9GdmD18264lS8l7tYK4m
        xoR295afbAYDFjnBD4fNKA==
X-Google-Smtp-Source: ABdhPJyD00JXiViecz7jg35poN6Lre3W3a3UQ9S/5zoPMwy4+oplksUnWCkMC3no3KF6cZIwbWOETQ==
X-Received: by 2002:a05:6830:1af4:: with SMTP id c20mr11735398otd.198.1605540759297;
        Mon, 16 Nov 2020 07:32:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g22sm5097101oop.0.2020.11.16.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:32:38 -0800 (PST)
Received: (nullmailer pid 1686301 invoked by uid 1000);
        Mon, 16 Nov 2020 15:32:37 -0000
Date:   Mon, 16 Nov 2020 09:32:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mayulong <mayulong1@huawei.com>, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linuxarm@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20201116153237.GA1685828@bogus>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
 <504469db0d6659fdaed550a89822be6e7b8dc85e.1605530560.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504469db0d6659fdaed550a89822be6e7b8dc85e.1605530560.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 13:59:29 +0100, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 159 ++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  15 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 342 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  16 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 342 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 159 --------
>  9 files changed, 524 insertions(+), 518 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml


See https://patchwork.ozlabs.org/patch/1400898

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

