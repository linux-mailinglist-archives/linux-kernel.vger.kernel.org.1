Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24C928D31A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgJMR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgJMR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:28:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C078C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:28:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l8so141372ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/AMQsx5esXhv7hCeHiqsScS6XgaG02ARXQXpgNkGiA=;
        b=b+l2lCOQXhSJNUVZjanJDDfs5sRSa4KyaE4FH6pYvEukVWR4yiiCwBmhRaydp/jOrT
         43sHtKek3HH0nTZNecXQYWj+S4GuNuJ8GnTA3IaeURFcpO3td+xMy1ueIU4/jO5FnE6I
         dEou+rouTK1mby3cy/9Iv60qWfg7xBLywvRhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/AMQsx5esXhv7hCeHiqsScS6XgaG02ARXQXpgNkGiA=;
        b=Kf/jLvVvSrAHdVDEw/KQQenyFCFQaCNTWG37dEyAHg1i69Jks2k2DTTeX93HGMhj6U
         OjyB5d/OrYHdpPe2bs/KNjIzNgqlpaqKO3OLSs2UBIVPj3IRIW7IJ3rEoskuFb0ySeck
         Fz3n1MiUk9x1zFre95/KbTIRuFSYSYP2CXaeKi9uZVTkygyJclvUeSbpWtf9IG5Fr1Qb
         M08rSq5SeftweqlA7XXC5VuVkhLPQxyFTlw+C0QXVGt5VBvvqgsa134Z4FREfHBYXrc8
         gNIELFIp+vo+/eF63iH/OuZAWmiv+S0GalcCOAOr00kF4dyVr68d3peGA73j2CbzBnDO
         5lBg==
X-Gm-Message-State: AOAM532+ekynTB0OBWpRK1G4UcQwzbSIf2uAekiPkCJwpeDaPbmLJPNq
        LK4ZokQlqDKCBZSfAzpDuocYRg==
X-Google-Smtp-Source: ABdhPJzM55OqjIgPRT84zPcP04/nSWHIJEFjqF3/7YdjUq6aAQkyNI/67/rpIEpNw6j4THgR+qMouA==
X-Received: by 2002:a02:a90c:: with SMTP id n12mr882247jam.102.1602610089502;
        Tue, 13 Oct 2020 10:28:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a86sm449535ill.11.2020.10.13.10.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 10:28:08 -0700 (PDT)
Subject: Re: [PATCH v2] kcov, usbip: collect coverage from vhci_rx_loop
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <c07a2deae7a75e394de272c1a33cfcc1f667af92.1602522185.git.andreyknvl@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dddca63c-088c-d87c-370f-e8f02d1b0d04@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 11:28:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c07a2deae7a75e394de272c1a33cfcc1f667af92.1602522185.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 11:10 AM, Andrey Konovalov wrote:
> From: Nazime Hande Harputluoglu <handeharputlu@google.com>
> 
> Add kcov_remote_start()/kcov_remote_stop() annotations to the
> vhci_rx_loop() function, which is responsible for parsing USB/IP packets
> coming into USB/IP client.
> 
> Since vhci_rx_loop() threads are spawned per vhci_hcd device instance, the
> common kcov handle is used for kcov_remote_start()/stop() annotations
> (see Documentation/dev-tools/kcov.rst for details). As the result kcov
> can now be used to collect coverage from vhci_rx_loop() threads.
> 
> Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
> ---
> 
> Changes v1->v2:
> - Fix spacing issues.
> - Add ifdef CONFIG_KCOV around kcov_handle in usbip_device struct.
> 

Does this compile without CONFIG_KCOV?

> ---
>   drivers/usb/usbip/usbip_common.h |  4 ++++
>   drivers/usb/usbip/vhci_rx.c      |  3 +++
>   drivers/usb/usbip/vhci_sysfs.c   | 12 +++++++-----
>   3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index 8be857a4fa13..0906182011d6 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -277,6 +277,10 @@ struct usbip_device {
>   		void (*reset)(struct usbip_device *);
>   		void (*unusable)(struct usbip_device *);
>   	} eh_ops;
> +
> +#ifdef CONFIG_KCOV
> +	u64 kcov_handle;
> +#endif
>   };
>   
>   #define kthread_get_run(threadfn, data, namefmt, ...)			   \
> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> index 266024cbb64f..473f14587bd5 100644
> --- a/drivers/usb/usbip/vhci_rx.c
> +++ b/drivers/usb/usbip/vhci_rx.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2003-2008 Takahiro Hirofuchi
>    */
>   
> +#include <linux/kcov.h>
>   #include <linux/kthread.h>
>   #include <linux/slab.h>
>   
> @@ -261,7 +262,9 @@ int vhci_rx_loop(void *data)
>   		if (usbip_event_happened(ud))
>   			break;
>   
> +		kcov_remote_start_common(ud->kcov_handle);

You are referencing kcov_handle defined in CONFIG_KCOV scope
here. Does this compile for you without CONFIG_KCOV?

>   		vhci_rx_pdu(ud);
> +		kcov_remote_stop();
>   	}
>   
>   	return 0;
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index be37aec250c2..966f1f5cafb1 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -4,6 +4,7 @@
>    * Copyright (C) 2015-2016 Nobuo Iwata
>    */
>   
> +#include <linux/kcov.h>
>   #include <linux/kthread.h>
>   #include <linux/file.h>
>   #include <linux/net.h>
> @@ -378,11 +379,12 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>   	dev_info(dev, "devid(%u) speed(%u) speed_str(%s)\n",
>   		 devid, speed, usb_speed_string(speed));
>   
> -	vdev->devid         = devid;
> -	vdev->speed         = speed;
> -	vdev->ud.sockfd     = sockfd;
> -	vdev->ud.tcp_socket = socket;
> -	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> +	vdev->devid          = devid;
> +	vdev->speed          = speed;
> +	vdev->ud.sockfd      = sockfd;
> +	vdev->ud.tcp_socket  = socket;
> +	vdev->ud.status      = VDEV_ST_NOTASSIGNED;
> +	vdev->ud.kcov_handle = kcov_common_handle();

Don't change spacing for other variables. Add just the new
code. Don't you need CONFIG_KCOV around this new code?
>   
>   	spin_unlock(&vdev->ud.lock);
>   	spin_unlock_irqrestore(&vhci->lock, flags);
> 

thanks,
-- Shuah
