Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896C32E977B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbhADOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbhADOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609771231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFfXv6TzDRE7F942fvHmw3WnMe4ntA68qR259LcqXAc=;
        b=GQiwixzYA24qid4TxZMxrM97FdV+/9xqjxm2dDR7N11e6zkbhqaTf2i1DrCcvvVan+WF1a
        z2y92gN+79LzRtM4HVdZHVX2AMsI8dy7iE18Olg80SV4ZWxVOBv4C4yPf7L0G37wdeIQZs
        w2+goRdsoOvVl3eJ/RQwaR3S7chWzgo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-lzHT1QM4PFSd4rWHjoFYSg-1; Mon, 04 Jan 2021 09:40:30 -0500
X-MC-Unique: lzHT1QM4PFSd4rWHjoFYSg-1
Received: by mail-ej1-f71.google.com with SMTP id dv25so7030874ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QFfXv6TzDRE7F942fvHmw3WnMe4ntA68qR259LcqXAc=;
        b=EJ03gsXgmc3x853d65U3PnP8I/RjZ4KEuWkB/o3GATt2Y+42C4/Zgdd2xI8bKvuWii
         9F1+PX5ibn4tumkj0SrGEQVXDgpugm7HDtKYBCAKRtJDQrFLXgDHUjWDPaA8nKmrog9P
         x92++lh8p8ZsxRlpFC+2ztPPyHIKzDgxURDdsnT3UI7W6PiDAAtC1ssY2GgJyv0dcb03
         Q4nun+oH3jZ7GToScJgblu5DCuc+nqC96xYxOYbvkTo1RdCNNSMTJ09AN+xC9F1E4ldE
         SZAm4eLaLdSLvsZnYdSUDmcjuB97JKwXgLN4Llt0gm/Obcq1gSzORKvs5fiVEczIL5d9
         Yeiw==
X-Gm-Message-State: AOAM532+NjGOWbg4oHWthi+4CoH2ScOtWgHBSfs6mqkTF1znisjv/x3a
        +zMkZ5wLBdxguobLNQkoAurpozZxtEyN3CFDjg8KliYfzM3v+7WkEvbT76KN90Xty7ZLSseY0jY
        pwjtLcYrV+Iyo+K5HlUv4LCNp2ffdZTV35x/FtSaSeJY4/HH7aBRkMIYFnZnZ2FIKYsI5zGYmAB
        ab
X-Received: by 2002:aa7:cd44:: with SMTP id v4mr71107008edw.156.1609771228683;
        Mon, 04 Jan 2021 06:40:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx6P6tR5UcsmUHVGbV86xokCSfjVoiuiRBDMj9z44PscTIMEbLncB4lg2h8VyJQ8X1aBPlOw==
X-Received: by 2002:aa7:cd44:: with SMTP id v4mr71106988edw.156.1609771228541;
        Mon, 04 Jan 2021 06:40:28 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id e19sm44477821edr.61.2021.01.04.06.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:40:28 -0800 (PST)
Subject: Re: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on Dell
 Inspiron 7352
To:     Arnold Gozum <arngozum@gmail.com>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201226205307.249659-1-arngozum@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <15c05099-6739-b71e-c39f-10c03cada588@redhat.com>
Date:   Mon, 4 Jan 2021 15:40:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201226205307.249659-1-arngozum@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/26/20 9:53 PM, Arnold Gozum wrote:
> The Dell Inspiron 7352 is a 2-in-1 model that has chassis-type "Notebook".
> Add this model to the dmi_switches_allow_list.
> 
> Signed-off-by: Arnold Gozum <arngozum@gmail.com>

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
>  drivers/platform/x86/intel-vbtn.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index 3b49a1f4061b..9bbdb26d4305 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -222,6 +222,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Switch SA5-271"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7352"),
> +		},
> +	},
>  	{} /* Array terminator */
>  };
>  
> 

