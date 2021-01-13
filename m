Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8937D2F4F12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAMPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:45:51 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44418 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAMPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:45:49 -0500
Received: by mail-oi1-f173.google.com with SMTP id d189so2530502oig.11;
        Wed, 13 Jan 2021 07:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LAgxcxPKO6+K5xuiboQtVz90wgxmO5JxIxszpigQEaQ=;
        b=WJ61MeH+fouinhNNn9vZ/MqeX8SNGeUIXIFVEmtGIZfSKIz2R/fOQWRsITBWuTWhts
         N6FajhHqrH0WjwkqFtOtsbvxmdcbP8ljAb1Xh+m98a6DHT9WTwRqfIky4nD8Pni3TG3K
         O/lF+gJ7t2UB0JL6aR5iSMc0V19pD70SaXK1IR/wykNt+ls+B2vbBkDsfvePbTSaH7HS
         GjHV1MAC3IEDmVb4NyRB+F4mKbeYtJqWzKTqFWeoMGgrA91bZpHv06vn0x/Fv5IsgMB3
         cb710OXMjmJhC5MQO3sUAJ8fzfQo0yEq74cJFe2LDmuRRFz6/Ag/wpSpRGzkMba9X2zV
         zmNw==
X-Gm-Message-State: AOAM533qRccvanfm+fmDYJeFhBxP2FvoAtNPHdW99PL6cBMJPt13t58X
        A0EYfotwrhpOzMDC/VlFiQ==
X-Google-Smtp-Source: ABdhPJzWkNwzW1Bjr8if31U8RhxyGof9O2v0X5uf0vd7irD3YqPI/uyLJXyOXB15Nxy7F0dM1bPpow==
X-Received: by 2002:a05:6808:7da:: with SMTP id f26mr1520162oij.177.1610552708536;
        Wed, 13 Jan 2021 07:45:08 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o21sm455582otj.1.2021.01.13.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:45:07 -0800 (PST)
Received: (nullmailer pid 2506184 invoked by uid 1000);
        Wed, 13 Jan 2021 15:45:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        devicetree@vger.kernel.org
In-Reply-To: <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com> <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 11/11] dts: bindings: Document device tree bindings for Arm TRBE
Date:   Wed, 13 Jan 2021 09:45:04 -0600
Message-Id: <1610552704.268262.2506183.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 09:48:18 +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Document the device tree bindings for Trace Buffer Extension (TRBE).
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/trbe.yaml | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/trbe.yaml:39:2: [warning] wrong indentation: expected 2 but found 1 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1425605

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

