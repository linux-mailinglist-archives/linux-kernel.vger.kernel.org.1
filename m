Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E507A2B7C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKRLZW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Nov 2020 06:25:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54750 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgKRLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:25:20 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kfLaP-0000y9-Pv
        for linux-kernel@vger.kernel.org; Wed, 18 Nov 2020 11:25:17 +0000
Received: by mail-pg1-f199.google.com with SMTP id p21so1042722pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r7x4FLD1g1lFiB/rjBYtCrwkSnWVEPF+U90EeU7fGs4=;
        b=tZ1Q7PFY9OPp4IpCPIgkCT5Rt0wFA5PXPIluQl55BHG5eu7ggqwALGHhkNUAmpyWtf
         4CWPh68mVxCY8hF5DiQKMMxx3L+xN7CiLXPZx7Obmij7LgTj8B70ECBzFhaLG700x9U7
         Ek5fm+AZheV2B0kJ9QsurJXm2GR8DN8PvtlJ2+3po5HTObuu5DilYtOQcMve0M4UokXU
         FkRZBMviBmhGkjubFRPGAl7bDc1o6RVn3S7R3AlM05KSDR2zYga8pIXwT0rL87TcrU/A
         Vb1Kp3sKevZukGIG9YTPU3nTz9dlRlQmBTdgXChbo3fMFRAM8jJ9HNU0vgRTos/Ecdvr
         iQfQ==
X-Gm-Message-State: AOAM533jNbXy1vz6G0H6rjgU54bImkFTPzRZec9aVZPJr+YmwXZIy+w3
        o/2d+RwLPjdN5dsoeGzQHz6yMFLk+EfElvfWURmTnvENzGRRrE82YMFe7HvWhKW1slW/j7+OMev
        miTy9P+K5gScbp/LtF3idhYCHuaj9AhaZ7HY4Eogt8Q==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr3350479pju.99.1605698716357;
        Wed, 18 Nov 2020 03:25:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrZrei/lPBiaqSz316HZD8X9lUfdxdrVtEhbhkaaY76B2qM77fQz03JGOPMmHQuR6flNxK2A==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr3350463pju.99.1605698716006;
        Wed, 18 Nov 2020 03:25:16 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id m20sm23967992pfk.31.2020.11.18.03.25.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 03:25:15 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] USB: quirks: Add USB_QUIRK_DISCONNECT_SUSPEND quirk for
 Lenovo A630Z TIO built-in usb-audio card
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201118110639.7455-1-penghao@uniontech.com>
Date:   Wed, 18 Nov 2020 19:25:07 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, johan@kernel.org,
        jonathan@jdcox.net, tomasz@meresinski.eu, hdegoede@redhat.com,
        dlaz@chromium.org, richard.o.dodd@gmail.com,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <91C616BC-3B99-4BB5-AEBE-6975CBFB29BA@canonical.com>
References: <20201118110639.7455-1-penghao@uniontech.com>
To:     penghao <penghao@uniontech.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi penghao,

> On Nov 18, 2020, at 19:06, penghao <penghao@uniontech.com> wrote:
> 
> Add a USB_QUIRK_DISCONNECT_SUSPEND quirk for the Lenovo TIO built-in
> usb-audio. when A630Z going into S3,the system immediately wakeup 7-8
> seconds later by usb-audio disconnect interrupt to avoids the issue.
> 
> Seeking a better fix, we've tried a lot of things, including:
> - Check that the device's power/wakeup is disabled
> - Check that remote wakeup is off at the USB level
> - All the quirks in drivers/usb/core/quirks.c
>   e.g. USB_QUIRK_RESET_RESUME,
>        USB_QUIRK_RESET,
>        USB_QUIRK_IGNORE_REMOTE_WAKEUP,
>        USB_QUIRK_NO_LPM.
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
> Changes since v4
> - Fixed add a blank line
> 
> Changes since v3
> - Fixed spelling error on appropriate
> 
> Changes since v2
> - Add Changes commit format
> 
> Changes since v1
> - Change subject form "ALSA" to "USB:"
> - Adjust to appropriate line
> 
> Signed-off-by: penghao <penghao@uniontech.com>
> ---
> drivers/usb/core/quirks.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 7c1198f80c23..26b852ae0d85 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -410,6 +410,10 @@ static const struct usb_device_id usb_quirk_list[] = {
> 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
> 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> 
> +	/* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
> +	{ USB_DEVICE(0x17ef, 0xa012), .driver_info =
> +			USB_QUIRK_DISCONNECT_SUSPEND },
> +

Would it be possible to enable dynamic debug, reproduce the issue, and attach dmesg here? i.e.
# echo 'file drivers/usb/* +p; file drivers/usb/host/* +p' > /sys/kernel/debug/dynamic_debug/control
# echo mem > /sys/power/state
... and attach dmesg here.

Kai-Heng

> 	/* BUILDWIN Photo Frame */
> 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
> 			USB_QUIRK_HONOR_BNUMINTERFACES },
> -- 
> 2.11.0
> 
> 
> 

