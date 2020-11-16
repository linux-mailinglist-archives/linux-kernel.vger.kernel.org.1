Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6112B4832
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgKPPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:02:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42040 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbgKPPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:02:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id w145so19085246oie.9;
        Mon, 16 Nov 2020 07:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5UEnDHX9Jbs+qN0J6DLL+cnyF7sD4QFf8RH39CNakCE=;
        b=DFi1m61j/fdJ83VM2adXSsyy8AxxcPL6iTC6dp7tuNPLvN2dyAKwYnzscN0e+XZ9Qs
         7LItrZgiLtiXU7NCRMBIPDX578i0xU/+/aSZmzec1VrcJeDGnJkc22De6OkWH1FDhvzq
         bb9VmHnKMW7L7RPxfxYVdAJ2j7vbcaHYGnIw/uS+7NYmzRda9QoeJ+RbwFk4/Z0iK+i/
         YS+Plk0xSFoWTnZHSSQSXurRTMbPd2kQ2dcz0EGXczVJePPf78QyYaSYn2p6KnkMuOqs
         ZXgspUJsZIf1AHLT1+AAQeVY7V/sbunGFMDk41NBzIR780k9cIb5OpfI7DPB8omWG495
         o+5g==
X-Gm-Message-State: AOAM530iW5bhsVjtFbLekhHtF2mQLGtzJI1Gca6/UVFnATcGmkFQMyM6
        Igtjw7R/Xyg7wzH2Q+vItA==
X-Google-Smtp-Source: ABdhPJxzto15rppWybSuDJqeDtl3VAtUal3PsHP9sZ2dQgdcjF+ayTUu/zIIZ40pbpCr9rhDQ0TAPA==
X-Received: by 2002:aca:4257:: with SMTP id p84mr10237364oia.176.1605538944696;
        Mon, 16 Nov 2020 07:02:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h3sm4847814oou.3.2020.11.16.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:02:24 -0800 (PST)
Received: (nullmailer pid 1646073 invoked by uid 1000);
        Mon, 16 Nov 2020 15:02:23 -0000
Date:   Mon, 16 Nov 2020 09:02:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: Document the hi3559a clock bindings
Message-ID: <20201116150223.GA1645329@bogus>
References: <20201114002237.35962-1-gengdongjiu@huawei.com>
 <20201114002237.35962-2-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114002237.35962-2-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Nov 2020 00:22:36 +0000, Dongjiu Geng wrote:
> Add DT bindings documentation for hi3559a SoC clock.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  .../clock/hisilicon,hi3559av100-clock.yaml    |  65 +++++++
>  include/dt-bindings/clock/hi3559av100-clock.h | 165 ++++++++++++++++++
>  2 files changed, 230 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dts:20.23-27.11: Warning (unit_address_vs_reg): /example-0/clock0: node has a reg or ranges property, but no unit name
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dt.yaml: clock0: compatible: ['hisilicon,hi3559av100-clock', 'syscon'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dt.yaml: clock0: compatible: Additional items are not allowed ('syscon' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.example.dt.yaml: clock0: #reset-cells:0:0: 1 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml


See https://patchwork.ozlabs.org/patch/1399891

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

