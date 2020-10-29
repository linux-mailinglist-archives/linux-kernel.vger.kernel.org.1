Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD80329F77B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJ2WMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJ2WMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:12:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181E2C0613D2;
        Thu, 29 Oct 2020 15:12:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t25so5873823ejd.13;
        Thu, 29 Oct 2020 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kL0Yi6GqHZd0HFiCnH2b3WCCTf5AQEQ2NzzoThy/rtE=;
        b=fzOwRKHY/12iFmIoU80+6gMBemG8HPQ+jsLdIeT115e2c19w8gSdjfTT79hvaL+Iup
         YekYWWhuhjaa4RG3NzExAjNYT5xiAB6DqrE9nfcCDbRg/IR3+6L3TuRhMhiRrjiVCINF
         XaJIHxpVDC1xodQqJB6/4Hc+dsh95tPyQn0dWI7lBihg9B4F+YzoG2hTVXvcyubEkrfE
         VicbtpESfCHiJOKf+dnrvVILEJVabbbDLy6KPWUDuanEasNUfzqka0dc5Li3FGxzWJnb
         u7SnhCjYIp/OLFOtTxndNCVAGV0Te7z/KvzI7yeX58BIUhR74bQjek+MO30jH9CwR4Nk
         416Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kL0Yi6GqHZd0HFiCnH2b3WCCTf5AQEQ2NzzoThy/rtE=;
        b=SG3nWm7nyneqxOb5CJhmmzXvY7gyPiPLm4PD0qxW+A536e4a/cZ+/xlrJi2P07ys9m
         vTweXw3J0UmIQOJwVpOSOX2pcUzaCcUW4CJU9Rz+048L8RRaB5/ADNrml1sgQFl3FYhd
         xXFXl9rnW5FgJnXqLyS54ckLWY7S2LxNvfosH80D9RtS7lvbDwhkoMh4nAAAOIfx8Pfa
         h9hENobnTDYbm+N3JEpLfq7UPQznRYyFfPRKEJx5y5/VSZD7eoLaFUkQ/ZRw3PmKaz5M
         jEP3t9dYRzRY5P8MMNsiU/6qhdu/VlACxsXHV7uyryxixmkYibfaGRH566cEk9Rchy5k
         iybw==
X-Gm-Message-State: AOAM53378sMs3vpv1YFd8lFXtifmXvBtu2qXzhIownUqkbDEg+AHGq4Y
        7OX4WGPCAdJDviwBA4i70DPln+1i80o=
X-Google-Smtp-Source: ABdhPJxSiAqkMUh9hKBJQrc4HLomMJONGvB4r3lqUPx+fdOrNK5fZTFCsiQgF0vq9gQ5rYuLknFgGA==
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr6503286eju.44.1604009518582;
        Thu, 29 Oct 2020 15:11:58 -0700 (PDT)
Received: from ?IPv6:2a01:110f:b59:fd00:5806:1c4:f304:93f0? ([2a01:110f:b59:fd00:5806:1c4:f304:93f0])
        by smtp.gmail.com with ESMTPSA id o15sm2114369ejm.38.2020.10.29.15.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:11:57 -0700 (PDT)
Subject: Re: [PATCH 33/33] docs: ABI: unify
 /sys/class/leds/<led>/max_brightness documentation
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <2c95a4d8d1b4be2f839464ebc63bfcee6b70276a.1603893146.git.mchehab+huawei@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <514e13de-b6f6-1df1-ddfe-5a1a2ca8fb87@gmail.com>
Date:   Thu, 29 Oct 2020 23:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2c95a4d8d1b4be2f839464ebc63bfcee6b70276a.1603893146.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Patch title needs fixing:

s/max_brightness/brightness/

On 10/28/20 3:23 PM, Mauro Carvalho Chehab wrote:
> This ABI is defined twice, one for normal leds and another
> one for multicolor ones.
> 
> Ensure that just one definition is there at ABI.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-class-led     | 25 ++++++++++++++++---
>   .../ABI/testing/sysfs-class-led-multicolor    | 23 +++++------------
>   2 files changed, 28 insertions(+), 20 deletions(-)
> 
[...]
> +
>   What:		/sys/class/leds/<led>/max_brightness
>   Date:		March 2006
>   KernelVersion:	2.6.17
> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
> index eeeddcbdbbe3..16fc827b10cb 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-multicolor
> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
> @@ -1,20 +1,3 @@
> -What:		/sys/class/leds/<led>/brightness
> -Date:		March 2020
> -KernelVersion:	5.9
> -Contact:	Dan Murphy <dmurphy@ti.com>
> -Description:	read/write
> -		Writing to this file will update all LEDs within the group to a
> -		calculated percentage of what each color LED intensity is set
> -		to. The percentage is calculated for each grouped LED via the
> -		equation below:


-- 
Best regards,
Jacek Anaszewski
