Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351B2D886C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394583AbgLLQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 11:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388775AbgLLQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:46:09 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CFFC0613CF;
        Sat, 12 Dec 2020 08:45:28 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id q25so13831009oij.10;
        Sat, 12 Dec 2020 08:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j1HIhXJASopSHIWczFMRIPyMr8ppd3okjfPEQWfKLB4=;
        b=TcbkQj+wK4bKdaHhkWCmcRkx0pWS+SG727YujBJzxVrMyxagG/wlbYafrkMBlvjYIC
         nzztS8YBXqEkIsO3sC/ir1WlKvSb2KVDM37JTK1GpRvRT94l3ri6VVYL4s3V667YtvH6
         p+tfFWrMoyeXP/FSw39FYzzl1J/v66xI6OnS8ovJSrdGxvMgwwgpdu30ieJcs1MeRQ5n
         VkLaXAmHgJtdb4iK21vmBnA/p4H8y4sqIXvRGhO71WKSlrR+MS6bwWFKbs8agdgdDjg1
         KHjtEcR8/dQuwY7ACeqt/68tQNjYhYiSBkz44mO9NcQ3SMgPtGpTwBVW9bDgugfzm5+8
         7RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1HIhXJASopSHIWczFMRIPyMr8ppd3okjfPEQWfKLB4=;
        b=ouRo2npvDZBeMFCp/60pngdkxb+uQxgTsKdLwyFSpEvKbzHeEZ+iOI6ztrnELxh4vw
         URCRxze4X8+K/w3ZR9JAXwSAnpfH39Kkb6Nfv3q1jxLntcpLdL56kSR5Ths1Q97am217
         P4blRgHaJuV4p/tph1nkMIMD7jxPjRlTxEO+MCA/R3qbs3BP/qxRggZIgs+1ehyXJRPw
         hcucdGQiOQl0OAgniBg/ma0x/U4gbLT126MaOGHv5ZVARoWHK4SBL959wkYwOUgzkQ32
         N8yZdQNKM0aJXlsnqoU8OJ+dLAt0DNydzXl+ajc0e6ZmKxRRxn4DCDEUJ/QgxEsVJPQ6
         Lutg==
X-Gm-Message-State: AOAM533yDSAdAtz2IT13zQJTaBhE4elP0qJvZNBqWR0nZi1F7KQDTEAe
        HnqEXdiAwS4htaBP3NuR4/8=
X-Google-Smtp-Source: ABdhPJx6KJadDbpC4GdotSZT7cSA+i+XmF0Gzw039M/eGwqvkL8UADqtEke531S6FlsY+z9HIXSHDA==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr13108658oic.47.1607791528318;
        Sat, 12 Dec 2020 08:45:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6sm2645573oon.7.2020.12.12.08.45.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Dec 2020 08:45:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 12 Dec 2020 08:45:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kun Yi <kunyi@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        supreeth.venkatesh@amd.com, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux hwmon-next v5 2/3] hwmon: (sbtsi) Add documentation
Message-ID: <20201212164526.GA29303@roeck-us.net>
References: <20201211215427.3281681-1-kunyi@google.com>
 <20201211215427.3281681-3-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211215427.3281681-3-kunyi@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 01:54:26PM -0800, Kun Yi wrote:
> Document the SB-TSI sensor interface driver.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>

Applied. Note that I added the SPDX identifier to match
the one used in the source file.

Guenter

> ---
>  Documentation/hwmon/index.rst      |  1 +
>  Documentation/hwmon/sbtsi_temp.rst | 40 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/hwmon/sbtsi_temp.rst
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index fd6fae46b99c..509fb3bcafb2 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -151,6 +151,7 @@ Hardware Monitoring Kernel Drivers
>     pxe1610
>     pwm-fan
>     raspberrypi-hwmon
> +   sbtsi_temp
>     sch5627
>     sch5636
>     scpi-hwmon
> diff --git a/Documentation/hwmon/sbtsi_temp.rst b/Documentation/hwmon/sbtsi_temp.rst
> new file mode 100644
> index 000000000000..9f0f197c8aa2
> --- /dev/null
> +++ b/Documentation/hwmon/sbtsi_temp.rst
> @@ -0,0 +1,40 @@
> +Kernel driver sbtsi_temp
> +==================
> +
> +Supported hardware:
> +
> +  * Sideband interface (SBI) Temperature Sensor Interface (SB-TSI)
> +    compliant AMD SoC temperature device.
> +
> +    Prefix: 'sbtsi_temp'
> +
> +    Addresses scanned: This driver doesn't support address scanning.
> +
> +    To instantiate this driver on an AMD CPU with SB-TSI
> +    support, the i2c bus number would be the bus connected from the board
> +    management controller (BMC) to the CPU. The i2c address is specified in
> +    Section 6.3.1 of the SoC register reference: The SB-TSI address is normally
> +    98h for socket 0 and 90h for socket 1, but it could vary based on hardware
> +    address select pins.
> +
> +    Datasheet: The SB-TSI interface and protocol is available as part of
> +               the open source SoC register reference at:
> +
> +	       https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf
> +
> +               The Advanced Platform Management Link (APML) Specification is
> +               available at:
> +
> +	       http://developer.amd.com/wordpress/media/2012/10/41918.pdf
> +
> +Author: Kun Yi <kunyi@google.com>
> +
> +Description
> +-----------
> +
> +The SBI temperature sensor interface (SB-TSI) is an emulation of the software
> +and physical interface of a typical 8-pin remote temperature sensor (RTS) on
> +AMD SoCs. It implements one temperature sensor with readings and limit
> +registers encode the temperature in increments of 0.125 from 0 to 255.875.
> +Limits can be set through the writable thresholds, and if reached will trigger
> +corresponding alert signals.
