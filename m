Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADFD2DAEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgLOO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:27:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39648 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgLOO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:26:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id w124so20353831oia.6;
        Tue, 15 Dec 2020 06:26:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=KOd0FT3c5pAyEjns556YZCkxD79Rv8TreKmMgCerk2U=;
        b=eAAtnSfSbCVStJquyqbPqFmFkqpR0j8o5kjsGue5IC0pVVmukzlGqjyd7Wsb1DKkbh
         U888DOhTOAAm+HNFOoY1HhQmI2EaOR5psTABPuZF6dFeWL0ILsaNXfJLDaqiCB0vPmEr
         rXWVZA21qnfO+PWPxRoQM86Y6Xnvf2Fx92pPG7z7otVZbYlA88+1EWpnwxJ2Uk3k99gi
         M7Ylbt82YZ4Sf7sOGPRPo5pUJtG6WTUn5XNVmIPBbRHs9+1cz19s0/FkMyDB32LUlNbH
         UXEB9ybmWho4AvCMbxpCmgVZtDkRT5JfA8qNx40Jdpp+sZUgXxpKYYHesbyp3zG3Mk0T
         2SiA==
X-Gm-Message-State: AOAM531kv6qlwR/uJCwfL2vXV99630e+v/MfRx87nlclcQ6xRTNo4Bw6
        Xcf1k06J/U1N2cV1wRZdk/dW3J6rSQ==
X-Google-Smtp-Source: ABdhPJw9i2niJyZWzxHrqYXcWjo3A4BZeQCDVRsUt6BP4SnuhRxyk50Q69+RPK2/nECRCkTUPISfnw==
X-Received: by 2002:aca:2411:: with SMTP id n17mr21129298oic.43.1608042368968;
        Tue, 15 Dec 2020 06:26:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u141sm5030520oie.46.2020.12.15.06.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:26:08 -0800 (PST)
Received: (nullmailer pid 3775379 invoked by uid 1000);
        Tue, 15 Dec 2020 14:26:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, broonie@kernel.org,
        gary.bisson@boundarydevices.com
In-Reply-To: <20201214225851.23342-2-adrien.grassein@gmail.com>
References: <20201214225851.23342-1-adrien.grassein@gmail.com> <20201214225851.23342-2-adrien.grassein@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: add pf8x00 PMIC
Date:   Tue, 15 Dec 2020 08:26:07 -0600
Message-Id: <1608042367.294065.3775378.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 23:58:50 +0100, Adrien Grassein wrote:
> Add a devicetree binding documentation for the pf8x00 regulator driver.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../regulator/nxp,pf8x00-regulator.yaml       | 220 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml:71:16: [warning] wrong indentation: expected 14 but found 15 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1416222

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

