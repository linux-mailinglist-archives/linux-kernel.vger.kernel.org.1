Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE92DD28E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgLQOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:01:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E3BC061794;
        Thu, 17 Dec 2020 06:00:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h205so14054892lfd.5;
        Thu, 17 Dec 2020 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FO58AhMktkhPBtclgNdElstsCIkGCfLNl7Tiw7pUkU8=;
        b=YCKGnPy7Dz/iyIGeAwtc970yNHXxvVMyVQpsEQWECHNFv4kHndRLDOFJ9MHd7uve0X
         Sej3iSjY7XQCTEE27/dj1pU0DOT+lSx8C+cguOwQStrw8QNQc0efdxA5oa8o3xd9ngxy
         +LWrvOE/D5cHUSAffYAi9NxqDFXlnSyBjtd/kdZ/r4Ts+XWGtmgUAJAD4MQvjlAaN+xx
         sJ8QZa6dGCjLC3765QaScKFwBjcyqZtXYuNXpTJ99HHgy9kfOW/jx0AvLWR+lrWWEBZh
         E1A1hWd0H2I8etTj3L/z7BxrmoB3TWSbP9A1EUoas3UJ8+Y3HTx6Rzd768E5ytZaVrp5
         Xq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FO58AhMktkhPBtclgNdElstsCIkGCfLNl7Tiw7pUkU8=;
        b=s8MnlIU/KbEfvt2T+fHlA4HwHbFGVRzwgceC7elIwz2W6QyMlsd4rwFHYQZuQCLWEH
         QppWBXpjvpnNYZIR4RCirtodRpHKIFK6qIlqlsubPtMrzxD8uH76/FOwuUXl5dLkB0IV
         M/DvRIO1gi4Ft5PkfjtFy0dgKs+HyuSCkX0xfcpxTLNIFVUZephdoKmzDbqtb8duGRB2
         ahzRusOGdiSIfiOqRyAMp1eUABpUcm+G6oOuFiWjDcFAMqLwxXbOteLuhNBMuc+vgc8X
         hwsoBIwk5owBYl1O1D/Bhh8efhCFh1ZJB7q2cMKZ+UgFq0ukTcyJ1xO+s6SJPVtRlC5W
         h3kA==
X-Gm-Message-State: AOAM532DjNIYaUd8gYjb7UUBpJtx8iDF+L5jb9fTX/XrQZ2/GJo9PT5o
        I80QQjB0EVZlkcykv2t7SHnelrDyWBk=
X-Google-Smtp-Source: ABdhPJwzDXetikcENbkU5gsHDdt5Sa7Ta4XJZ0UGNgnUEb+iRSfyHHTJqKRC2gjSg1/DjNi4jNw4Fg==
X-Received: by 2002:a2e:86d4:: with SMTP id n20mr11783541ljj.486.1608213635125;
        Thu, 17 Dec 2020 06:00:35 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id v4sm595125lfa.55.2020.12.17.06.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:00:34 -0800 (PST)
Subject: Re: [PATCH v2 4/8] usb: chipidea: tegra: Rename UDC to USB
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ion Agorria <ion@agorria.com>, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201217094007.19336-1-digetx@gmail.com>
 <20201217094007.19336-5-digetx@gmail.com> <X9te7ObUU1Fcy2ut@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67e8fb54-a6b3-f9fe-bbee-7def1a81e191@gmail.com>
Date:   Thu, 17 Dec 2020 17:00:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <X9te7ObUU1Fcy2ut@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2020 16:36, Thierry Reding пишет:
> On Thu, Dec 17, 2020 at 12:40:03PM +0300, Dmitry Osipenko wrote:
>> Rename all occurrences in the code from "udc" to "usb" and change the
>> Kconfig entry in order to show that this driver supports USB modes other
>> than device-only mode. The follow up patch will add host-mode support and
>> it will be cleaner to perform the renaming separately, i.e. in this patch.
>>
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Ion Agorria <ion@agorria.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/usb/chipidea/Kconfig         |  2 +-
>>  drivers/usb/chipidea/ci_hdrc_tegra.c | 78 ++++++++++++++--------------
>>  2 files changed, 40 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
>> index 8bafcfc6080d..8685ead6ccc7 100644
>> --- a/drivers/usb/chipidea/Kconfig
>> +++ b/drivers/usb/chipidea/Kconfig
>> @@ -53,7 +53,7 @@ config USB_CHIPIDEA_GENERIC
>>  	default USB_CHIPIDEA
>>  
>>  config USB_CHIPIDEA_TEGRA
>> -	tristate "Enable Tegra UDC glue driver" if EMBEDDED
>> +	tristate "Enable Tegra USB glue driver" if EMBEDDED
>>  	depends on OF
>>  	depends on USB_CHIPIDEA_UDC
>>  	default USB_CHIPIDEA
>> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> index 10eaaba2a3f0..d8efa80aa1c2 100644
>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
>> @@ -12,7 +12,7 @@
>>  
>>  #include "ci.h"
>>  
>> -struct tegra_udc {
>> +struct tegra_usb {
>>  	struct ci_hdrc_platform_data data;
>>  	struct platform_device *dev;
>>  
>> @@ -20,15 +20,15 @@ struct tegra_udc {
>>  	struct clk *clk;
>>  };
>>  
>> -struct tegra_udc_soc_info {
>> +struct tegra_usb_soc_info {
>>  	unsigned long flags;
>>  };
>>  
>> -static const struct tegra_udc_soc_info tegra_udc_soc_info = {
>> +static const struct tegra_usb_soc_info tegra_udc_soc_info = {
>>  	.flags = CI_HDRC_REQUIRES_ALIGNED_DMA,
>>  };
>>  
>> -static const struct of_device_id tegra_udc_of_match[] = {
>> +static const struct of_device_id tegra_usb_of_match[] = {
>>  	{
>>  		.compatible = "nvidia,tegra20-udc",
> 
> Do we perhaps also want to add a new tegra20-usb compatible string here
> and deprecate the old one since this now no longer properly describes
> the device.

Ideally it should have been "tegra20-otg" to match TRM, but UDC is also
okay since it's a part of OTG and kinda presumes the OTG support of USB1
controller for anyone who read the TRM. Hence there is no need to change
the compatible, IMO.

> In either case, this looks fine:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

thanks
