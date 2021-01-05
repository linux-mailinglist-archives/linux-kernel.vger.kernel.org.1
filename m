Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F304C2EB0F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbhAERFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:05:32 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:41334 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbhAERFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:05:31 -0500
Received: by mail-il1-f178.google.com with SMTP id w17so315131ilj.8;
        Tue, 05 Jan 2021 09:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=szjyrLYwaZaHX4vAXZif2q9yEP3V/qNPGTizVqWHU30=;
        b=o7NQvheEo5/aLClIIY16Y0ORBZe+sf8ohLKJRvBT1RE0ZPQp0xKrMpbIPyPYPi1d1v
         X8BLw3YBANcU1oIBDWfXILJtxoFxTCwQafcVx2YjM0MMHAcJAComR2zHo3p300JMgLvu
         1jscqoFfEm6K97+XowLdXXq+bMnfPRrbo9+BaEDOxevlcpgVfwWR9Lvojk3JrpsRVdFn
         CrzEbd3QwCycJFioRGgxFrid3lDN7bI5APqGbbkveaq11AJ84yLQovR8T8x4xCKlQ8xr
         /Z4Bh0MVlIuVYCUanS8rkDgy3yWEtyrhyZ+ph6XoTLTv1YxEKUmuinMYcy85VEVv2Nmi
         fZUA==
X-Gm-Message-State: AOAM531pU9tvHowhhKe7mVZE4UzWFte+vUI87+uVk02f/rm/mZOoCf/8
        8qXxSQ6rgFq/B2AxRvsBWg==
X-Google-Smtp-Source: ABdhPJyOvIBC1VtDlm9f8CAH2CirusT8UNwTgPnnqrgUs2zeNid9UusFz2jWO51pCmduXoGkABoTGQ==
X-Received: by 2002:a92:7b07:: with SMTP id w7mr589022ilc.78.1609866290356;
        Tue, 05 Jan 2021 09:04:50 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k5sm64436ioa.27.2021.01.05.09.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:04:49 -0800 (PST)
Received: (nullmailer pid 372418 invoked by uid 1000);
        Tue, 05 Jan 2021 17:04:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Birger Koblitz <mail@birger-koblitz.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210104131755.2979203-2-bert@biot.com>
References: <20210104131755.2979203-1-bert@biot.com> <20210104131755.2979203-2-bert@biot.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support
Date:   Tue, 05 Jan 2021 10:04:48 -0700
Message-Id: <1609866288.019144.372417.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jan 2021 14:17:54 +0100, Bert Vermeulen wrote:
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  .../realtek,rtl-intc.yaml                     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml: properties: 'interrupt-map-mask' is a dependency of 'interrupt-map'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml: ignoring, error in schema: properties
warning: no schema found in file: ./Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
Error: Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.example.dts:30.5-6 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.example.dt.yaml] Error 1
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1422078

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

