Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF325FB87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgIGNjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgIGNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:25:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF8C061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:25:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 841552922B6
Subject: Re: [PATCH] platform/chrome: Kconfig: Remove the transitional
 MFD_CROS_EC config
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
References: <20200903141746.996974-1-enric.balletbo@collabora.com>
Message-ID: <5b2a2b4e-0b5e-7087-4e4d-d07058ee8d04@collabora.com>
Date:   Mon, 7 Sep 2020 15:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903141746.996974-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal and Guenter,

Thank you for the review and tested tags.

On 3/9/20 16:17, Enric Balletbo i Serra wrote:
> The MFD_CROS_EC config was a transitional Kconfig option to not break
> current defconfigs in the kernel. Now, this is not required anymore
> because all the defconfigs have been removed this option and migrated to
> enable the CrOS EC parts individually.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for 5.10

Thanks,
 Enric

> ---
> 
>  drivers/platform/chrome/Kconfig | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index a056031dee81..ccc23d8686e8 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -3,16 +3,6 @@
>  # Platform support for Chrome OS hardware (Chromebooks and Chromeboxes)
>  #
>  
> -config MFD_CROS_EC
> -	tristate "Platform support for Chrome hardware (transitional)"
> -	select CHROME_PLATFORMS
> -	select CROS_EC
> -	select MFD_CROS_EC_DEV
> -	depends on X86 || ARM || ARM64 || COMPILE_TEST
> -	help
> -	  This is a transitional Kconfig option and will be removed after
> -	  everyone enables the parts individually.
> -
>  menuconfig CHROME_PLATFORMS
>  	bool "Platform support for Chrome hardware"
>  	depends on X86 || ARM || ARM64 || COMPILE_TEST
> 
