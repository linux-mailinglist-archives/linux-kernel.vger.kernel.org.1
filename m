Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F932FA5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406229AbhARQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:01:05 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46556 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405900AbhARPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:47:55 -0500
Received: by mail-ot1-f49.google.com with SMTP id w3so16605111otp.13;
        Mon, 18 Jan 2021 07:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7fgTElUed+dLXiedRGXn6iUhg8ezF6u02H7vJDNFxaQ=;
        b=bDsxlyxWvPUwlOuMMJiswhqKQ1Yp91vlOpnGhrS9JTMu2STyr78BNhK9+Zq8ua8oD7
         7ZPhnoxFAWTrVWwjsA2zeONvJBUFzHebTwcfQJd38d4PjjqRpjWKbeKx3j/WsHcjwp/v
         vbZhtx9xZr+8T/WtEmPRzi0f2Qqt+tHBLMOUwehgqLOXZDnGjmkYctkNw5VfcQ39MeR/
         xM53VhX3X62Gh4da3hvGAsLBP8HdHfptCOIzodbsZmS4Dw1n2LY8AJbuekM19YbNcwv/
         Hy+aSaaDSjPsLiPuxECO+Mr/vRibQBRCrLESYsP9sRvv5rda9sInz9iqIXIN+ppuYVmT
         srDA==
X-Gm-Message-State: AOAM533HtOUdcmdJbZC3AvxRCHg6Edtwm25eiTh1zPWp3j0PDCOPKYHS
        7C9G7xODfpDAKzBeHlRyow==
X-Google-Smtp-Source: ABdhPJy5q/BWp4jbEhJl/2ExB4bau3UfQKeemepMe2Nty8rNip/vK0Lj+SkolcrUeG6oTBVPUFZLhw==
X-Received: by 2002:a05:6830:1e47:: with SMTP id e7mr73795otj.268.1610984829430;
        Mon, 18 Jan 2021 07:47:09 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s2sm732912otk.45.2021.01.18.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:47:08 -0800 (PST)
Received: (nullmailer pid 3984441 invoked by uid 1000);
        Mon, 18 Jan 2021 15:47:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mayulong <mayulong1@huawei.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
In-Reply-To: <8a152819ef89c73dd6afb5c2deb5441402fcd2fa.1610975633.git.mchehab+huawei@kernel.org>
References: <cover.1610975633.git.mchehab+huawei@kernel.org> <8a152819ef89c73dd6afb5c2deb5441402fcd2fa.1610975633.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 10/13] mfd: hi6421-spmi-pmic: move driver from staging
Date:   Mon, 18 Jan 2021 09:47:02 -0600
Message-Id: <1610984822.729521.3984440.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 14:28:11 +0100, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 133 +++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  15 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 342 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  16 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 342 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 133 -------
>  9 files changed, 498 insertions(+), 492 deletions(-)
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

See https://patchwork.ozlabs.org/patch/1428169

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

