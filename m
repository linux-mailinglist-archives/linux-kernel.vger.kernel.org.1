Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601B27B03D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1Or0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgI1OrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:47:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EDC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:47:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so1436512wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xJ4U0BbuFlGWqhEOm+RF0FFbm4ZGkoyzRGz2775YyGQ=;
        b=sTCiorToYJKw4mAAXzhlUoMb4vGZVXBvm6Q3BSk8TmyH6gJjSLZM03bkTG6M+9GPon
         +3Uz416FCho9PCqwYLZJSbv5cn4pVusPWae+D/nTnA4IAS0sgYXTRnKmrx6b3uiro79h
         N7wd5k8K6nnE0KEN3rjvgh8ecoIMsQiqTQ3aU2h4qUGhQaqwSEJgr4AEnZuLnsR+f+Wb
         E9lyZYGzSaeaSz6klXCsTkqvJz1+ro+kdfX70dlUi7fisXJbLtfj2R93tlpQlPcKCEWe
         st6EEVB3v9SeEXCZHSD8gDak3l6HzxDZVeYxVBpEYeM5/LBc+HBHFAo8u51PdvwZfz4B
         OlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xJ4U0BbuFlGWqhEOm+RF0FFbm4ZGkoyzRGz2775YyGQ=;
        b=C7CW+1ttAQhsa0FOeilJt5b9MKR1aXtKMJngTQwVRikywCLif1d+P/TAT0/x6qSF+b
         BAl3P4/ZG1pfWZCKa5M2SGi1lZpup9VPTgygE/hk+fFpMJSOqfH/p1EgOdI7q39nMjLM
         SPDuyQgAcn2RSuTrxcq0typ2eCZkREiNLTh6MU+0REbYT4v3+cNaVfVKUQrXgUWZlxvC
         EfH9SQxQcgbhWrwsazzgM4pfCZ65P+i8T1C82sxC4+oqlLyRITQrNrEcSJlLJ6qUgwU1
         hPZwWEhTMpumuqE0iCrw3r9wdNctKoy4aZqkKWlRTZzWlOrIxjvld9UdF/WNLW/tdoJ3
         aMUQ==
X-Gm-Message-State: AOAM533oBM/SJ57knCRojVQE5sNndOjLknmFUIDChEDX6hja1FZEFYQP
        vAQxuWmQKLrLxNQTZkTISgJfIA==
X-Google-Smtp-Source: ABdhPJyJIBcVexqza6vWUrGFwe49kEEK9PqekSDetTa2KPFYpZuePxBL1hL2vR3vAVY0fla/zGiVUg==
X-Received: by 2002:a1c:b388:: with SMTP id c130mr1981429wmf.175.1601304444020;
        Mon, 28 Sep 2020 07:47:24 -0700 (PDT)
Received: from dell ([91.110.221.154])
        by smtp.gmail.com with ESMTPSA id m12sm1429173wml.38.2020.09.28.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 07:47:23 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:47:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: Add ACPI support to Kontron PLD driver
Message-ID: <20200928144721.GB6148@dell>
References: <1e5ff295eacd5cb9eb2d888e1b0175fea62cf2ae.camel@kontron.com>
 <20200819101539.GE4354@dell>
 <07ef067e4cb39e50fa07da29e5729e3508e1671a.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ef067e4cb39e50fa07da29e5729e3508e1671a.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020, Michael Brunner wrote:

> Recent Kontron COMe modules identify the PLD device using the hardware
> id KEM0001 in the ACPI table.
> This patch adds support for probing the device using the HID and also
> retrieving the resources.
> 
> As this is not available for all products, the DMI based detection still
> needs to be around for older systems. It is executed if no matching ACPI
> HID is found during registering the platform driver or no specific
> device id is forced.
> If a device is detected using ACPI and no resource information is
> available, the default io resource is used.
> 
> Forcing a device id with the force_device_id parameter and therefore
> manually generating a platform device takes precedence over ACPI during
> probing.
> 
> v2: - Implemented code changes suggested by Lee Jones
>     - Added comments explaining some critical code
>     - Driver is no longer unregistered if probing is skipped during
>       platform_driver_register and device is not found in DMI table
>     - Set probe type to PROBE_FORCE_SYNCHRONOUS to make clear this is
>       the expected behaviour for this code to work as expected
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> ---
>  drivers/mfd/kempld-core.c | 115 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 109 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
