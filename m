Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14A728D292
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgJMQsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgJMQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:48:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48AC0613D0;
        Tue, 13 Oct 2020 09:48:45 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u17so88795oie.3;
        Tue, 13 Oct 2020 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mg/Vf27uQrH+QZr9MTsy0LWlJpcdeTpSu6ROq5/oqks=;
        b=rxf99be+1u3xmfnKzAazaXlLwug4y9Ha9N8tYMnfpBWnfcj5yq+HQhOW9KNu12vKGm
         DA7IosO129OvxWS+P06quSWzl5HRoDYyTJXN7FUk9yhZ+OFrzcN0px5klKPCtqhDQekp
         BvVsywWbs+f+9yMD/+87+Ar2Z/9uRchRTp2hSe3BtKqcMhOVGvsuHxZ+GuRiSEfaM0TY
         ixpyZ4E6//1XGP7NpJTYIqMxPce7LrK/ugnMht6VCoxGcZ3bsDrNAlCMNoRr4gyJuY9B
         pEqJm46gOncVtL5WwwAXLDxz9ObXyi+iAMcmYQZUE4zi+7hQvbbcm7cL/VtJc57RRnwc
         63Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mg/Vf27uQrH+QZr9MTsy0LWlJpcdeTpSu6ROq5/oqks=;
        b=PD87V6+6YVuKaNOf3OpxL4SBT0C8s3jW7tNUpuThyb7XL2fjlSYqz5EDHx//xq82iw
         B+DXYR40bWLCU2rOYWn+vtbgx69KyhnxbahBlLUof/yOr+7tO+9QiHuoQ0eFovgkH1lb
         1mw8yj1mKkdgmS7NvO8tC1e5YKvbQ0oTgKPtfb17oHaqZWy9gb4BBuSxGxBN3An8r2yf
         sw2fv7Aq2hpwARnvjY0N4e2uLVouQh+lpsp0G2fsAXL3niFpad5QjDNsRCBHUIW2xfx/
         +wB2V1htpfHAcdond+asFdiLfMhfdEn/L7oD9QhDjgaqzQJrCWU6t97DpPMoc/Xlard5
         AUwg==
X-Gm-Message-State: AOAM532pani3MOygTSeLIEulKBtIwxyxkld4KV4jkvuEh37ocuIKBVQ2
        1gGc5O29LIAYf4xeeVKAuyg=
X-Google-Smtp-Source: ABdhPJyj87YRbCDfhwXXsSdbQDCnKaVwQ5liQ6F5/fX7ATWBFiVMns7zYD4gSd77pL3mAI68iHvMHQ==
X-Received: by 2002:aca:3341:: with SMTP id z62mr340784oiz.169.1602607724538;
        Tue, 13 Oct 2020 09:48:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k128sm91571oib.52.2020.10.13.09.48.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Oct 2020 09:48:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Oct 2020 09:48:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/24] docs: hwmon: mp2975.rst: address some html
 build warnings
Message-ID: <20201013164842.GI251780@roeck-us.net>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <8418e2062b82314ceae5da7404fad7b2d3a3fa9a.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8418e2062b82314ceae5da7404fad7b2d3a3fa9a.1602590106.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:14:44PM +0200, Mauro Carvalho Chehab wrote:
>     .../Documentation/hwmon/mp2975.rst:25: WARNING: Unexpected indentation.
>     .../Documentation/hwmon/mp2975.rst:27: WARNING: Block quote ends without a blank line; unexpected unindent.
>     .../Documentation/hwmon/mp2975.rst:69: WARNING: Unexpected indentation.
>     .../Documentation/hwmon/mp2975.rst:70: WARNING: Block quote ends without a blank line; unexpected unindent.
>     .../Documentation/hwmon/mp2975.rst:72: WARNING: Bullet list ends without a blank line; unexpected unindent.
>     .../Documentation/hwmon/mp2975.rst: WARNING: document isn't included in any toctree
> 
> List blocks should have blank lines before and after them,
> in order to be properly parsed.
> 
> Fixes: 4beb7a028e9f ("hwmon: (pmbus) Add support for MPS Multi-phase mp2975 controller")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/hwmon/index.rst  |  1 +
>  Documentation/hwmon/mp2975.rst | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index e6b91ab12978..b797db738225 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -132,6 +132,7 @@ Hardware Monitoring Kernel Drivers
>     mcp3021
>     menf21bmc
>     mlxreg-fan
> +   mp2975
>     nct6683
>     nct6775
>     nct7802
> diff --git a/Documentation/hwmon/mp2975.rst b/Documentation/hwmon/mp2975.rst
> index 5b0609c62f48..81d816b71490 100644
> --- a/Documentation/hwmon/mp2975.rst
> +++ b/Documentation/hwmon/mp2975.rst
> @@ -20,6 +20,7 @@ This driver implements support for Monolithic Power Systems, Inc. (MPS)
>  vendor dual-loop, digital, multi-phase controller MP2975.
>  
>  This device:
> +
>  - Supports up to two power rail.
>  - Provides 8 pulse-width modulations (PWMs), and can be configured up
>    to 8-phase operation for rail 1 and up to 4-phase operation for rail
> @@ -32,10 +33,12 @@ This device:
>    10-mV DAC, IMVP9 mode with 5-mV DAC.
>  
>  Device supports:
> +
>  - SVID interface.
>  - AVSBus interface.
>  
>  Device complaint with:
> +
>  - PMBus rev 1.3 interface.
>  
>  Device supports direct format for reading output current, output voltage,
> @@ -45,11 +48,14 @@ Device supports VID and direct formats for reading output voltage.
>  The below VID modes are supported: VR12, VR13, IMVP9.
>  
>  The driver provides the next attributes for the current:
> +
>  - for current in: input, maximum alarm;
>  - for current out input, maximum alarm and highest values;
>  - for phase current: input and label.
> -attributes.
> +  attributes.
> +
>  The driver exports the following attributes via the 'sysfs' files, where
> +
>  - 'n' is number of telemetry pages (from 1 to 2);
>  - 'k' is number of configured phases (from 1 to 8);
>  - indexes 1, 1*n for "iin";
> @@ -65,11 +71,14 @@ The driver exports the following attributes via the 'sysfs' files, where
>  **curr[1-{2n+k}]_label**
>  
>  The driver provides the next attributes for the voltage:
> +
>  - for voltage in: input, high critical threshold, high critical alarm, all only
>    from page 0;
>  - for voltage out: input, low and high critical thresholds, low and high
>    critical alarms, from pages 0 and 1;
> +
>  The driver exports the following attributes via the 'sysfs' files, where
> +
>  - 'n' is number of telemetry pages (from 1 to 2);
>  - indexes 1 for "iin";
>  - indexes n+1, n+2 for "vout";
> @@ -87,9 +96,12 @@ The driver exports the following attributes via the 'sysfs' files, where
>  **in[2-{n+1}1_lcrit_alarm**
>  
>  The driver provides the next attributes for the power:
> +
>  - for power in alarm and input.
>  - for power out: highest and input.
> +
>  The driver exports the following attributes via the 'sysfs' files, where
> +
>  - 'n' is number of telemetry pages (from 1 to 2);
>  - indexes 1 for "pin";
>  - indexes n+1, n+2 for "pout";
> -- 
> 2.26.2
> 
