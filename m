Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EA2D2E50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgLHPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730083AbgLHPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607441487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FMZUGLEZ8IR+pc7weB+jF6Ts3wWL1ODG+l+6NkEMl0=;
        b=YxlPQMfZFYrAepuQwlk9a/8p1Rukk6PIJmB5yseQGPLZWuzzvVHghWTVGCWDZ8DNVtM16A
        rIlMK8btKntwF8gaPa2cyFGtYoZqkv+RTybN9GS4HkNhgmxZJOKBuFY9Zavflxt8Ri+9ie
        smXW68o2BVnrgPtQ+NiBYyMiz7VCLD4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-5pPQGmZZNBy8cRqlCNj0rA-1; Tue, 08 Dec 2020 10:31:25 -0500
X-MC-Unique: 5pPQGmZZNBy8cRqlCNj0rA-1
Received: by mail-ed1-f70.google.com with SMTP id cq17so4127021edb.17
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 07:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FMZUGLEZ8IR+pc7weB+jF6Ts3wWL1ODG+l+6NkEMl0=;
        b=OEN8IeK4kLlbM0arDv24J0QBmqWVljx36/+ZE8AAmLoWwTsWXFW10PMoILqiK7h0Y4
         asG+iZJWRUtctIoL2mFqfDGIETDp+f2v5ipa1Rst9EXJXXtGAztlVagBFTN8bc3vH5H4
         0NyBTgiSxtm4SGQx+ZRlN14reQ5WMdfRTy0/ROnGD0X6jfwTdGYFj5FTjPxnu/8D5IIs
         hU8q5+p1D5L1Ny4KYpLxI/Sm06h0Bt0mGh2Fmlc/aY2VEg4O7yXOEV5gj0xVedNP8RSC
         HN687s0iUDQHsvHQQwwGEFhghGWzn3Brsonb0ZvWqSMGkqAe6SJa6vPpdjO16Jj4+bQs
         V4FQ==
X-Gm-Message-State: AOAM530sIxc9OKvufnH5czh3ZEpgO9cbixoKom1BZpmzq1b5bxEbb+Xe
        TY2bCl0et3kmlqJfFR2HOo7RyM1G4XEY/YSYGORWFHcFgjVHCbR31fKm30jfJeXN7Z8xq1qvl20
        q1abiMKl2IXLwnkPREvPqiU6MCSr7pYo4+I0PycSg19VTl0PJHe29SI57idZWhlz4LJyPhtvjfM
        Oc
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr25458365edm.291.1607441483449;
        Tue, 08 Dec 2020 07:31:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtQU0RezIwC9tzXq31kmgXqVciy5sBw5mSMcppCnQP7N2IaRcQFo26XwXC19JRgWUuXan+jw==
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr25458346edm.291.1607441483238;
        Tue, 08 Dec 2020 07:31:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id oq7sm6098333ejb.63.2020.12.08.07.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:31:22 -0800 (PST)
Subject: Re: [PATCH -next] platform/x86: ISST: Mark mmio_range_devid_0 and
 mmio_range_devid_1 with static keyword
To:     Zou Wei <zou_wei@huawei.com>, srinivas.pandruvada@linux.intel.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f9e29a7e-f5eb-afaf-1d29-4665be99046a@redhat.com>
Date:   Tue, 8 Dec 2020 16:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1607430489-116200-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/20 1:28 PM, Zou Wei wrote:
> Fix the following sparse warnings:
> 
> drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c:23:24: warning: symbol 'mmio_range_devid_0' was not declared. Should it be static?
> drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c:28:24: warning: symbol 'mmio_range_devid_1' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

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
>  drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> index 2906cfe..ff49025 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> @@ -20,12 +20,12 @@ struct isst_mmio_range {
>  	int end;
>  };
>  
> -struct isst_mmio_range mmio_range_devid_0[] = {
> +static struct isst_mmio_range mmio_range_devid_0[] = {
>  	{0x04, 0x14},
>  	{0x20, 0xD0},
>  };
>  
> -struct isst_mmio_range mmio_range_devid_1[] = {
> +static struct isst_mmio_range mmio_range_devid_1[] = {
>  	{0x04, 0x14},
>  	{0x20, 0x11C},
>  };
> 

