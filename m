Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF22E8D6C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbhACRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 12:06:24 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:41919 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhACRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 12:06:24 -0500
Received: by mail-il1-f180.google.com with SMTP id w17so23172424ilj.8;
        Sun, 03 Jan 2021 09:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dbx7uvDjUYEbSF2o6RUpLKMOlSlVXzjNJHUrK9HnTc=;
        b=kVyU3SViE+yg4KG5uJNgp1u2Ooft/BcIIURYsDzU+yBFpCvmxiWE2lMCI6yzX1VjxD
         H3KeDt31x/m3iPLrLhDlt3yVBGlrogk7NsCIwO4WO0khbQurMa30B+ekHIwhgjINXWqq
         83fkt8arL3mz4M9i7vOJenCK4XE4lrYtp81meOVx8ICId5SR05+eqOgOMPsQ3BxhITNZ
         CZBva8bYD7X+QNROBxNAgsQP3mZvd4aX2204s24phMn12TECp/wJTj2UHcR0zSODFDJZ
         J3qlPWx/Hd+ZD6H4l6FCj658G2P3v9ZTD8PsVMC+oNAgCDnCb8Nvz5LclZ3IRk2vmsCp
         4hqA==
X-Gm-Message-State: AOAM5316ImJtWQ5iwGfnErX97pWZ0hUll2YKsWkDGl6j69zooHW/xvj/
        QY3vi9OXlA8wnkIJWnXIG47RmtL+sg==
X-Google-Smtp-Source: ABdhPJxie0sVU6tn06mMtSZxEWumvvVVD9jjOBHN9qyb0/wSW1VlfRNeUOP4TRHLIOtmVPTh3aebnw==
X-Received: by 2002:a92:8e46:: with SMTP id k6mr54636577ilh.235.1609693543193;
        Sun, 03 Jan 2021 09:05:43 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d5sm38720317ilf.33.2021.01.03.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:05:42 -0800 (PST)
Received: (nullmailer pid 4060134 invoked by uid 1000);
        Sun, 03 Jan 2021 17:05:40 -0000
Date:   Sun, 3 Jan 2021 10:05:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/11] dts: bindings: Document device tree binding for
 Arm TRBE
Message-ID: <20210103170540.GA4055084@robh.at.kernel.org>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
 <1608717823-18387-12-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608717823-18387-12-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 03:33:43PM +0530, Anshuman Khandual wrote:
> This patch documents the device tree binding in use for Arm TRBE.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V1:
> 
> - TRBE DT entry has been renamed as 'arm, trace-buffer-extension'
> 
>  Documentation/devicetree/bindings/arm/trbe.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/trbe.txt b/Documentation/devicetree/bindings/arm/trbe.txt
> new file mode 100644
> index 0000000..001945d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/trbe.txt
> @@ -0,0 +1,20 @@
> +* Trace Buffer Extension (TRBE)
> +
> +Trace Buffer Extension (TRBE) is used for collecting trace data generated
> +from a corresponding trace unit (ETE) using an in memory trace buffer.
> +
> +** TRBE Required properties:
> +
> +- compatible : should be one of:
> +	       "arm,trace-buffer-extension"
> +
> +- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
> +	       TRBE is only supported on a subset of the CPUs, please consult
> +	       the arm,gic-v3 binding for details on describing a PPI partition.
> +
> +** Example:
> +
> +trbe {
> +	compatible = "arm,trace-buffer-extension";
> +	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;

If only an interrupt, then could just be part of ETE? If not, how is 
this hardware block accessed? An interrupt alone is not enough unless 
there's some architected way to access.

Rob
