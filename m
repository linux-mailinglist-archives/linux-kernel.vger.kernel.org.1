Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CFE2FA57A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405949AbhARQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:01:38 -0500
Received: from mail-oo1-f50.google.com ([209.85.161.50]:46075 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405882AbhARPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:47:48 -0500
Received: by mail-oo1-f50.google.com with SMTP id o5so4187067oop.12;
        Mon, 18 Jan 2021 07:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=e7KTT/2rC1RRzc/Qgu5mx3fpnxvimSQ9OWkk2KcsVP4=;
        b=Ew2dzYZfbhbX6OGi0fkAkoDigOYK2+OmrUZp7eRfUSma6+s3IbnrbXhYkY4U6SI2bZ
         g+iE8y+N3Ck/1r0yKT2qpe/h98kk5k0hj2/ByavxCtwtfMgplxLT3pqz7+uuIHnS7oIR
         1CwzKWSoelt17nyANSIrrQ9VDncFAinesjsOz/qoKVfaWx97GjK0gNwETopFX5DiCR/A
         x/nSM1Ix/5LFpN3jVcIHVBFUH4DH8ScmoyX/8kIM4vCO4epoqarQJLD4nd2+C8B4zzMh
         uwRzwzvJedG/nLthxnRsM/BcMYsaNLpIX46yVCyAG4p37oXMledN+PD6oV78vPZaoctD
         Jr5A==
X-Gm-Message-State: AOAM533HFjilQQvWxq/lslySojlqcHGX37XDxT689RismuAiCqPS3oRu
        Sr+KGtH1CqKvHVE6zNN6mw==
X-Google-Smtp-Source: ABdhPJzba3cyPuKB+rvnb2yG/uBacWS+30Kp6qTcxg4uH2G1JxykCCxlP4qivbXk1evtMoME/i+SXw==
X-Received: by 2002:a4a:4ccb:: with SMTP id a194mr17530340oob.14.1610984827493;
        Mon, 18 Jan 2021 07:47:07 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f25sm3706325oou.39.2021.01.18.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:47:06 -0800 (PST)
Received: (nullmailer pid 3984437 invoked by uid 1000);
        Mon, 18 Jan 2021 15:47:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, linux-imx@nxp.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        devicetree@vger.kernel.org, broonie@kernel.org
In-Reply-To: <20210117042539.1609-3-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me> <20210117042539.1609-3-alistair@alistair23.me>
Subject: Re: [PATCH 3/6] devicetree/bindings: Initial commit of silergy,sy7636a-regulator.yaml
Date:   Mon, 18 Jan 2021 09:47:02 -0600
Message-Id: <1610984822.712980.3984436.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021 20:25:36 -0800, Alistair Francis wrote:
> Initial support for the Silergy SY7636A-regulator Power Management chip
> driver.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../bindings/regulator/silergy,sy7636a.yaml   | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy7636a.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/regulator/silergy,sy7636a.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/regulator/silergy,sy7636a.yaml#
Documentation/devicetree/bindings/regulator/silergy,sy7636a.example.dts:22.26-28.15: Warning (unit_address_vs_reg): /example-0/i2c/regulator@60: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/regulator/silergy,sy7636a.example.dts:22.26-28.15: Warning (i2c_bus_reg): /example-0/i2c/regulator@60: missing or empty reg property

See https://patchwork.ozlabs.org/patch/1427907

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

