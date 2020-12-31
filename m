Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D352E80F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgLaPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 10:35:40 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34803 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 10:35:39 -0500
Received: by mail-ot1-f52.google.com with SMTP id a109so18261406otc.1;
        Thu, 31 Dec 2020 07:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=asf+bZYpocXWSb5Yp/90UPFVGGy+/C09jxbdDcYDghc=;
        b=lBVjhAzezjjV9HQXMD579zegR4gehrzMy5rzonTlJj4lY7EWNENdwURq0tnOPraFks
         XYFhYjfblT+vQLOrIRTiSjJo20c8+YFZplW9uZ3LrAOg67aqozXjBVneoOp7rdwKcvHI
         fhhgLVmp4aO4BOHzuMVLapiLdM+PcjO+tyiTNFkv5eGQEXfduqU4Qd7fg721q2oMig3s
         Vh2ZQN6qGsPzly2kX1ljcc14nw/06COFPeJ1V+euKS9AtNM/r0mIhuK81qG0gNkKl10u
         Cnd8gs13V5v+7Z5KnZUY4cOgARtKw9uHsdDp0HpiXPSVGdS/k0BwyXgCjEb9R1u/n/KM
         znww==
X-Gm-Message-State: AOAM530U8oD7U08+QZrVMbtYZu3HVAwxfwjshHOIWcwDLwjmYKJP6Wg6
        Fr3dEfIvf5oAg0tjUQ9o8Q==
X-Google-Smtp-Source: ABdhPJxs0obeqzPePvk2gCrG8/Y993La1ReKpUv+82Gq3l9xBytrU/NOVYZ3zVR5OnBrYiR1+WWM2A==
X-Received: by 2002:a9d:730e:: with SMTP id e14mr42466087otk.74.1609428898888;
        Thu, 31 Dec 2020 07:34:58 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s24sm7939259oij.20.2020.12.31.07.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 07:34:58 -0800 (PST)
Received: (nullmailer pid 1828657 invoked by uid 1000);
        Thu, 31 Dec 2020 15:34:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     vijayakannan.ayyathurai@intel.com
Cc:     tglx@linutronix.de, daniel.lezcano@linaro.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, mgross@linux.intel.com,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        chen.yong.seow@intel.com, will@kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, robh+dt@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <907e6379ae5fc8f5decdb344485123425de7afc1.1609306622.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com> <907e6379ae5fc8f5decdb344485123425de7afc1.1609306622.git.vijayakannan.ayyathurai@intel.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC timer
Date:   Thu, 31 Dec 2020 08:34:48 -0700
Message-Id: <1609428888.834957.1828656.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 14:25:26 +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> Add Device Tree bindings for the Timer IP, which used as clocksource and
> clockevent device in the Intel Keem Bay SoC.
> 
> Acked-by: Mark Gross <mgross@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> ---
>  .../bindings/timer/intel,keembay-timer.yaml   | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/timer/intel,keembay-timer.example.dts:32.3-33.1 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/timer/intel,keembay-timer.example.dt.yaml] Error 1
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1421313

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

