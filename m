Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660762CBCB1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbgLBMOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729817AbgLBMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606911202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8wBO6q+/ydbMfM2l/hjFLTpTgfds0h6kmbDEEyONUA=;
        b=i4QGIi8Fpyn26hcGpzQzEqb41SlTV2i+kl3Xlrzsk8pQ3aLsKcvltKbOvmPThsWzK6Ubyh
        OleeQclqeemZy+erGy8bab/luxtyByT3vaQ6Rcvjx/SwZF9a+tlOkHeCzaSG8yjJ3AChcM
        axGtTW9GAG71fxnwL+yIgQ/3kBb9HBY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-nSDIcSL6NXKa3yJL-JiLyw-1; Wed, 02 Dec 2020 07:13:19 -0500
X-MC-Unique: nSDIcSL6NXKa3yJL-JiLyw-1
Received: by mail-ej1-f69.google.com with SMTP id u10so2866484ejy.18
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s8wBO6q+/ydbMfM2l/hjFLTpTgfds0h6kmbDEEyONUA=;
        b=KCD6NAC0Zr/rMxNeFISW/AMi0yDfYUAxa9JDnd3heozTxuruwJ3rjycidyuXH/hwdR
         p0jRsDzA5TYu/ohu3ri+BZ6P1WiDPZJOMXdn5qVxfuDS8DHmFo51awNI6JCwyt8w/Kcg
         bmKVL9xTCPcyUo1AEiNey4Yl3VClUu1bPIKmpxeyGBv/mpBg2KcMAR14xaIisP5KfDY7
         tH289vu1Sg7zZCxRyv1yhC+SWYIBDxT/79x8MW1KmKbcYTa3AqFi+vAtnw0jzNXFsTud
         PubDqbIu6ztftr080NDPuA4y9DEEM4Kpeb8UMRqWP4uBL0csfCnYwfkNtxrlxf4LX0KX
         pAjg==
X-Gm-Message-State: AOAM530upkcGOoYfpL1ZNBNtccfzm9g5HPEhaweeN2hcwmDoikoqWGNN
        1AanPdaQ0UlfZM2meD9Hx6w+JtjhPK+MzSoOvEPO1UCD+9wVPmDlqFdsPUqxG2NCR9bilE+1nm3
        /OIL4tz+QMUpzZfIwcETVJhdNN7M21mkcknldQMQLTNCwQON7h16AmBnJKGug8vVoBEW5WTvuIM
        7A
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr2015616ejc.13.1606911198419;
        Wed, 02 Dec 2020 04:13:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjcf2/jAVd/t5xTW/xEbxoPnYk9GfgCvwh3DT7GD0BwB22NZEO16T4jtdxLCGGhpZ9PtQtGQ==
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr2015594ejc.13.1606911198176;
        Wed, 02 Dec 2020 04:13:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u23sm1053845ejy.87.2020.12.02.04.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 04:13:17 -0800 (PST)
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: remove trailing semicolon in
 macro definition
To:     trix@redhat.com, ibm-acpi@hmh.eng.br, mgross@linux.intel.com
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201127181024.2771890-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d83d3fe4-5999-b8d4-2b52-961313662e46@redhat.com>
Date:   Wed, 2 Dec 2020 13:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201127181024.2771890-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/27/20 7:10 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The macro use will already have a semicolon.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

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
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 36d9594bca7f..5bbb378d1a37 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1025,7 +1025,7 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
>  }
>  
>  #define destroy_attr_set(_set) \
> -	kfree(_set);
> +	kfree(_set)
>  
>  /* not multi-threaded safe, use it in a single thread per set */
>  static int add_to_attr_set(struct attribute_set *s, struct attribute *attr)
> 

