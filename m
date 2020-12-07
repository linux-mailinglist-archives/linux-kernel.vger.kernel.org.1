Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738582D1319
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLGOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:07:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgLGOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607349959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afa9i0Bef4Cb3mOnPuAfy6fMFqpa+/My9xmYdxXU/TQ=;
        b=hV+eGsY8HEFFKBFenKnfEvclGkhXX50yAe/OXV8QeEnJhTkZ7l8KT6cxHxapBzw8lghhZK
        UMzAxZIuWqzuAyucB7WiXkPJUXIkZCBsW1OdFpDBk6jWYlN/AKEVZSc3mICc2vsEL1yjNe
        GDmdiizdY7qxLKK09lGMXmsBIuRZCDo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-XEwLLZO5Pn6HyVMszyt2ug-1; Mon, 07 Dec 2020 09:05:55 -0500
X-MC-Unique: XEwLLZO5Pn6HyVMszyt2ug-1
Received: by mail-ej1-f70.google.com with SMTP id t17so3902002ejd.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afa9i0Bef4Cb3mOnPuAfy6fMFqpa+/My9xmYdxXU/TQ=;
        b=AddwK+Wv2z+CIoiSBO+8y5g0htmoj+sDnzh/OsIo6Dvj5HF32juhgUz1Ih5RsNB7VJ
         e8Z3uyECyI7/EfRYnrARaGzxPVTmv3VHcMrDeyfVY0EzXm9lqWk4KPUAjbMAzU6smh16
         lggXHDNxDXi/Lj1hfhix1Hh1OPtVwsTPy1ayBxQ+3QuhiiIlM8VsGvw9G1fr/kExplOH
         MjPLAPHXcwCts80i+xuBrHbb9L10bC1ftUR9Mfouk2NbcERlD1Vi/Knq6dURRYSkxoaM
         g70hmBZiIBbsOTF55LX4f2HbVmr1HmYH/gBvantxKqVbwwSmAlYs8LHINyr/YMc0wtlI
         raHQ==
X-Gm-Message-State: AOAM530tP2o8YZwZslXyXYcjTEsdXVDCHM5CkA3p0OdavUwzFS4RU/jT
        BT6nIa4mfNfb+8HjTFrE2pQKu+Y6StMlU8nTV91NXkvPb1zGWiGvg8hk6lqerFg8KS77g8LvtE/
        vKY+2dOsog0nzsq50S5LZII3l
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr18736566eja.293.1607349954409;
        Mon, 07 Dec 2020 06:05:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwraVwT1JcG9eO2qX/pyTXO58k7gNNbrJ+XGPs1jOdznikQXAjUUeHwWvUuK1v++EvFYzp4fg==
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr18736540eja.293.1607349954217;
        Mon, 07 Dec 2020 06:05:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id cb21sm13461039edb.57.2020.12.07.06.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 06:05:53 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: work around for BIOS bug
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20201202131935.307372-1-divya.bharathi@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <39f8a3a5-88ff-7e1d-8ce3-ebec8c01427e@redhat.com>
Date:   Mon, 7 Dec 2020 15:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202131935.307372-1-divya.bharathi@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/2/20 2:19 PM, Divya Bharathi wrote:
> BIOS sets incorrect value (zero) when SET value passed for integer attribute
> with + sign. Added workaround to remove + sign before passing input to BIOS
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Co-developed-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/dell-wmi-sysman/int-attributes.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> index ea773d8e8d3a..75aedbb733be 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/int-attributes.c
> @@ -39,7 +39,7 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>   * @instance_id: The instance on which input is validated
>   * @buf: Input value
>   */
> -static int validate_integer_input(int instance_id, const char *buf)
> +static int validate_integer_input(int instance_id, char *buf)
>  {
>  	int in_val;
>  	int ret;
> @@ -51,6 +51,12 @@ static int validate_integer_input(int instance_id, const char *buf)
>  			in_val > wmi_priv.integer_data[instance_id].max_value)
>  		return -EINVAL;
>  
> +	/* workaround for BIOS error.
> +	 * validate input to avoid setting 0 when integer input passed with + sign
> +	 */
> +	if (*buf == '+')
> +		memmove(buf, (buf + 1), strlen(buf + 1) + 1);
> +
>  	return ret;
>  }
>  
> 

