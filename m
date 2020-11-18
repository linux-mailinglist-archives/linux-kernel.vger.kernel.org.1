Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4112B79EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgKRJEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgKRJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:04:10 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA9C0613D4;
        Wed, 18 Nov 2020 01:04:08 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so1465967ljo.11;
        Wed, 18 Nov 2020 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nMFMeGrPp0gEdFJmEqAKOLPaaL/mwG19FQHI4ZyR9o=;
        b=XBJ8LP5DZ51aDEl1impo3SfeBfH9dkjj6Sb+ZUlQtyWKJWqS3A23FbJk3g6Mr4smQE
         l5HsDkGjmvDcgEq8kpko89gQCzX5Es7x306ipyl0iV7zagDnCIJlIz6WgdseaKe4pYF/
         IskXl6saWtncb28/h2eIsuAIZc9m/Yw4ZsWUEKzX2rSdUJSuEtyTgf9kH3e6AVbE275l
         DrdpHQ296QMAxeGnmixHa8TfVrxG+i7aDK++9LIekHibygP0t/HQE/HFswYj04y4rgXS
         yLkglzGIuAFGQPIulRRuKeUZUB7YDHkMeyeQ3cSjnjE4i1ETvFWQTMewpfEbm5PKZ60E
         6XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+nMFMeGrPp0gEdFJmEqAKOLPaaL/mwG19FQHI4ZyR9o=;
        b=h6tdXBfCsQNQw5t6a7f6bk8X7+8oV66sn3ZdILO8ARYBqsdggcB5Rt3d8YtW2xIQdm
         /IXPgTzWhUL8yIC0ChMj5jXnwBOqwsmzQMgTX068QdtUBqk1WOFEJdrdWwqc482g1i4w
         XOnGPNognLm9n0cjKwRRAvoywcWYgQIZV8Tk0CvoHg9LwUd08Z8BSgpZGoPkl7cPvtFz
         HF+ZtJeKKeRqJw/IPepiBHOkYXPjuCuUEbPxYSXLrlEe9RQpF05+NwMP+MYvzoTJq7Tp
         NVfGuKeSqJ2Flc1wZSMv1rHmj1gOdz6f3mORDU/88VteDiUVgUS71boNmkoLoJV4myO2
         BsBw==
X-Gm-Message-State: AOAM533JiPEDzaTLxh2XkHi52iv0oGcPhzyRRbMEu7+psQaTMZO5Zeh3
        0X7KJxDWro3dxggdnTMPST3uN50X4TNziA==
X-Google-Smtp-Source: ABdhPJwhzIt5gbR16NHDaRYF2dlPugAGyr7w649odDhgG3yoj6p2B7PwtD1ppn/aUu9C/7z/+HyA/A==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr3856877ljh.286.1605690247123;
        Wed, 18 Nov 2020 01:04:07 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:401:c2f8:8882:a0cb:e27c:5eb5? ([2a00:1fa0:401:c2f8:8882:a0cb:e27c:5eb5])
        by smtp.gmail.com with ESMTPSA id z7sm3505605lfg.137.2020.11.18.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 01:04:06 -0800 (PST)
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for
 Lenovo A630Z TIO built-in usb-audio card
To:     penghao <penghao@uniontech.com>, gregkh@linuxfoundation.org
Cc:     johan@kernel.org, jonathan@jdcox.net, tomasz@meresinski.eu,
        hdegoede@redhat.com, dlaz@chromium.org,
        kai.heng.feng@canonical.com, richard.o.dodd@gmail.com,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201118085623.31221-1-penghao@uniontech.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <268a9ff1-8142-556d-5c90-bb6badef0c84@gmail.com>
Date:   Wed, 18 Nov 2020 12:03:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201118085623.31221-1-penghao@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 18.11.2020 11:56, penghao wrote:

> Add a USB_QUIRK_DISCONNECT_SUSPEND quirk for the Lenovo TIO built-in
> usb-audio. when A630Z going into S3,the system immediately wakeup 7-8
> seconds later by usb-audio disconnect interrupt to avoids the issue.
> 
> Seeking a better fix, we've tried a lot of things, including:
>   - Check that the device's power/wakeup is disabled
>   - Check that remote wakeup is off at the USB level
>   - All the quirks in drivers/usb/core/quirks.c
>     e.g. USB_QUIRK_RESET_RESUME,
>          USB_QUIRK_RESET,
>          USB_QUIRK_IGNORE_REMOTE_WAKEUP,
>          USB_QUIRK_NO_LPM.
> 
> but none of that makes any difference.
> 
> There are no errors in the logs showing any suspend/resume-related issues.
> When the system wakes up due to the modem, log-wise it appears to be a
> normal resume.
> 
> Introduce a quirk to disable the port during suspend when the modem is
> detected.
> 
> Changes since v2
>   - Add Changes commit format
> 
> Changes since v1
>   - Change subject form "ALSA" to "USB:"
>   - Adjust to approoriate line

    Appropriate.

> 
> Signed-off-by: penghao <penghao@uniontech.com>
> ---
>   drivers/usb/core/quirks.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..25f655c2cd28 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
[...]
> @@ -430,6 +434,7 @@ static const struct usb_device_id usb_quirk_list[] = {
>   	  USB_QUIRK_DELAY_CTRL_MSG },
>   
>   	/* Corsair Strafe RGB */
> +

    Why? :-/

>   	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
>   	  USB_QUIRK_DELAY_CTRL_MSG },
>   

MBR, Sergei
