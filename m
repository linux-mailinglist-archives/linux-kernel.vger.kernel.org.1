Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9742D1704
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgLGQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgLGQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607360246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLHZCbOYXPJ7MY6WjbMQpSbeaoaAjjItMHe+oZxxLHU=;
        b=iOHMw8p44w7eVx0dJocTBRVBokcaIfUwfYS7lrxGyZsRHRQWyVQ7zU3ZtsVasfmzIxLdnj
        SdmLgkvIIcT+/+0ZvH5EFOJlpmyURX53ENyCATQSgthmGf6tJEF82eUAKGJ9jkjafgn4WD
        0gWZDNLZ42R5cYwP5gEHGTfB/PCHle0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-KnDXMSWpMk2PIehTApeexg-1; Mon, 07 Dec 2020 11:57:24 -0500
X-MC-Unique: KnDXMSWpMk2PIehTApeexg-1
Received: by mail-ed1-f72.google.com with SMTP id bf13so6013438edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLHZCbOYXPJ7MY6WjbMQpSbeaoaAjjItMHe+oZxxLHU=;
        b=kdppAzYwPpKf6Zj2jEHPh9FnxG+nltMYET09Mvja8Yymk5o8K/haR6zZYxIs5g+dXN
         iH/uByCakqGoj/BQaf6rbFzM0FBBq1X8VnZmudZRsf7htTNbts3aDO0YWM2vfSLLplhB
         I4HaZwW/PN209PVBgiGPlIptAziNvychG6ORBnZXvR00+PDP5cTC73Shz8Jr0HFE0qX9
         Htvctx2UF/rj5XoC+foAWZ8Xq20PkYhCTCrjVG+dB4/zp89oOQGeMQRqrTDGD22he8Qh
         lBHySmHZ8KD2lektZ0V2nTc4GlMxGXNHYW64YpkRG9GogEaJOqKczCUU+Tr+dubfG0jh
         6GmA==
X-Gm-Message-State: AOAM530SVcoNS6jMLvUl9C849EuAB8RkCPSL0YhNllC8IoZQ7bH7ZoCf
        i2847721cDt3NkJ+8INwOYPTpRhpEcmzsXBDJ0iGWz+ePTazUug5yOgDIRt+VUt3lI8s765N5LB
        PEsY+0Ifa2XpItmy4F5h6PxGn
X-Received: by 2002:a50:d5c4:: with SMTP id g4mr20057020edj.334.1607360243312;
        Mon, 07 Dec 2020 08:57:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1N5nwphyKoCqsmZgEKXI9H+Mw91KH2+2fnvV7wGnIOijW0LZB0No74yHlMUXrBlP25aZaCQ==
X-Received: by 2002:a50:d5c4:: with SMTP id g4mr20057010edj.334.1607360243119;
        Mon, 07 Dec 2020 08:57:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 2sm12915706ejw.65.2020.12.07.08.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 08:57:22 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Drop INT3396 from acpi_ignore_dep_ids[]
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <12017158.VsPUki9SGr@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a78eed2a-4c33-7e1a-88df-d92e33c74e20@redhat.com>
Date:   Mon, 7 Dec 2020 17:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <12017158.VsPUki9SGr@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/20 5:55 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> According to Hans, all device objects where the _HID returns
> "INT3396" also have a _CID returning "PNP0D80", so the former
> need not be present in acpi_ignore_dep_ids[] any more.
> 
> Link: https://lore.kernel.org/linux-acpi/52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com/
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me. FWIW:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
> On top of https://patchwork.kernel.org/project/linux-acpi/patch/3849919.JfvvSOo2yN@kreacher/
> 
> ---
>  drivers/acpi/scan.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -751,7 +751,6 @@ static bool acpi_info_matches_ids(struct
>  
>  /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
>  static const char * const acpi_ignore_dep_ids[] = {
> -	"INT3396", /* Windows System Power Management Controller */
>  	"PNP0D80", /* Windows-compatible System Power Management Controller */
>  	NULL
>  };
> 
> 
> 

