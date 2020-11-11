Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA22AF487
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKKPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:14:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgKKPOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:14:07 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F717206A1;
        Wed, 11 Nov 2020 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605107646;
        bh=d0sY6zcF8k38P2t09esju++5JTYGiRwTGV3GDkSzykY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eAWlPlImegdvQTY3m8tm6JNO7LKooiC3iopOwPK9+Su1UcfGl0kRPEZMh880JY69D
         LqTSrOsPzDQMRVaGAbKahhd5agIlqtbGykcswKi0t6Jl015jqcrwRbosiQz8StmATV
         d87Um7BWjGzcAKvam0BhmbBoNQb4MoMbfflkQAwQ=
Received: by mail-ot1-f42.google.com with SMTP id g19so2396722otp.13;
        Wed, 11 Nov 2020 07:14:06 -0800 (PST)
X-Gm-Message-State: AOAM533gFQu4IvxOzSAKJwmygpHmo+zDdAAc+0kJmg1WQkFgd5TUFW11
        pqHKbT3GDajc1AoIlD6gd4YkchibA8MGdPc/tg==
X-Google-Smtp-Source: ABdhPJymqPf/e8ewrMpEYOfSRcOCehc460ABLXcC/qaRYD758j4cwr98EnsuW8kfp2TJFp88OcSVrA1y8Rsg+BnNdA8=
X-Received: by 2002:a05:6830:2f8:: with SMTP id r24mr17995064ote.129.1605107645484;
 Wed, 11 Nov 2020 07:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20201111145757.74974-1-aford173@gmail.com>
In-Reply-To: <20201111145757.74974-1-aford173@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Nov 2020 09:13:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfe=uMPS6CgSGh6OfUMMY8yuKsa-q=PsFN3=NhYVYdDw@mail.gmail.com>
Message-ID: <CAL_JsqKfe=uMPS6CgSGh6OfUMMY8yuKsa-q=PsFN3=NhYVYdDw@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Adam Ford <aford173@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Adam Ford-BE <aford@beaconembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 8:58 AM Adam Ford <aford173@gmail.com> wrote:
>
> Add binding doc for fsl,spba-bus.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> make dt_binding_check showed no errors if I did this right.
>
> V3:  Rebase sample from aips-bus example
>      Split off from series adding i.MX8M Nano functions to reduce noise
> V2:  Attempted to update yaml from feedback
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index f50420099a55..ec8073cb2e71 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -3,8 +3,6 @@ DT_DOC_CHECKER ?= dt-doc-validate
>  DT_EXTRACT_EX ?= dt-extract-example
>  DT_MK_SCHEMA ?= dt-mk-schema
>
> -DT_SCHEMA_LINT = $(shell which yamllint)
> -

???

>  DT_SCHEMA_MIN_VERSION = 2020.8.1
>
>  PHONY += check_dtschema_version
> @@ -26,10 +24,6 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
>                 -name 'processed-schema*' ! \
>                 -name '*.example.dt.yaml' \)
>
> -quiet_cmd_yamllint = LINT    $(src)
> -      cmd_yamllint = $(find_cmd) | \
> -                     xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint
> -
>  quiet_cmd_chk_bindings = CHKDT   $@
>        cmd_chk_bindings = $(find_cmd) | \
>                           xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(srctree)/$(src)
> @@ -43,7 +37,6 @@ quiet_cmd_mk_schema = SCHEMA  $@
>                       rm -f $$f
>
>  define rule_chkdt
> -       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
>         $(call cmd,chk_bindings)
>         $(call cmd,mk_schema)
>  endef
> @@ -55,7 +48,7 @@ override DTC_FLAGS := \
>         -Wno-graph_child_address \
>         -Wno-interrupt_provider
>
> -$(obj)/processed-schema-examples.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
> +$(obj)/processed-schema-examples.json: $(DT_DOCS) check_dtschema_version FORCE
>         $(call if_changed_rule,chkdt)
>
>  ifeq ($(DT_SCHEMA_FILES),)
> diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> new file mode 100644
> index 000000000000..91dae405ed39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Shared Peripherals Bus Interface
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: |
> +  A simple bus enabling access to shared peripherals.
> +
> +  The "spba-bus" follows the "simple-bus" set of properties, as
> +  specified in the Devicetree Specification.  It is an extension of
> +  "simple-bus" because the SDMA controller uses this compatible flag to
> +  determine which peripherals are available to it and the range over which
> +  the SDMA can access.  There are no special clocks for the bus, because
> +  the SDMA controller itself has its interrupt, and clock assignments.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,spba-bus
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^bus(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    items:
> +      - const: fsl,spba-bus
> +      - const: simple-bus
> +
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +

> +additionalProperties: true
> +
> +type: object

Should be:

additionalProperties:
  type: object

> +
> +examples:
> +  - |
> +    bus@30000000 {
> +        compatible = "fsl,spba-bus", "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x30000000 0x100000>;
> +        ranges;
> +    };
> --
> 2.25.1
>
