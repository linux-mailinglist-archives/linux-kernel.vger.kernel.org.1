Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01A2CBC90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgLBMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729417AbgLBMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606911101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zwNOAGvTPJjverHdLPXU9TMwyctlpykIZc8az2HxtA=;
        b=JorT8/Oh7KHVZtG8Ip/Zb0+/FvGLqa4EeDcuqmQdAgLu99LynIauxqud/ohrClPCOCW5BO
        BdDEbHVWCwPxxXy4FcU62f8vmnFlloBuGtz8z0r+Jl/hK5suXB10fif2Up/VcuibXpdRJO
        z7yax2QCgsRlJ3tIxDocUYpoXv3115A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-N2_clhnoPSeIToFG_jweTw-1; Wed, 02 Dec 2020 07:11:39 -0500
X-MC-Unique: N2_clhnoPSeIToFG_jweTw-1
Received: by mail-ed1-f69.google.com with SMTP id b13so2891988edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3zwNOAGvTPJjverHdLPXU9TMwyctlpykIZc8az2HxtA=;
        b=XZCE0i68OYADCkbz5IoLAPq1gk2JeeSjYxofh2jomkaHufoodt3Mmby6ZZnn/usgho
         BLqyXI93dREz/TJx6xwyczxbhBkD8SGak13d7ZGTU/ukMlmMvmWLFgrjPHGR3kRDl5fV
         TH0k9AFv6m7+kMYSJaehRC5qTrUr4Xpdbma3hgBe4wj/K3eiqSKRhthWMtHbW2Uavl7x
         EoPB/TKtdkSU4sEt/0IyE2CorH+/sstXf7MV9OQYpY3RTxlAN2EqpPYbILQHK1bYPxfQ
         8IDYw2UL3TiEUwIMuyyN+tV2A3lvJgWIcRyOR8rdu5Yl2+Bx+Aw3wUjjyLIwaSGpph49
         y8YA==
X-Gm-Message-State: AOAM5315Q+Ph+nsmw8mZyDIUGre5/yCQjEcV93gc8QjndowqNjxUXssQ
        hgxqhyyVvkPuuOrIuipH5kWJSNeg3bhJBprOVg5ekVs4DBUsqei3XG5vSAYmVgbpDlqYiOeQwIX
        29UkYC3xIQsMTKvJecTacWVzBIKwoZnQBwpzNLmzcGn9zacqFeOnY/XvQg/Lp611qFGp6LyBzjR
        J5
X-Received: by 2002:a50:b224:: with SMTP id o33mr2260938edd.21.1606911097939;
        Wed, 02 Dec 2020 04:11:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRgBpuu53UKBFmWvKzRR7IEGE+Oy8B9DOjQmiLMlya/tl6VYs5fNhTuy3mkmNXAtQGlAuGgw==
X-Received: by 2002:a50:b224:: with SMTP id o33mr2260917edd.21.1606911097661;
        Wed, 02 Dec 2020 04:11:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y15sm1057142eds.56.2020.12.02.04.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 04:11:36 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-smbios-base: Fix error return code in
 dell_smbios_init
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201125065032.154125-1-miaoqinglang@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <031db440-8af5-c517-08fe-bce627f28492@redhat.com>
Date:   Wed, 2 Dec 2020 13:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125065032.154125-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/20 7:50 AM, Qinglang Miao wrote:
> Fix to return the error code -ENODEV when fails to init wmi and
> smm.
> 
> Fixes: 41e36f2f85af ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

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
>  drivers/platform/x86/dell-smbios-base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
> index 2e2cd5659..3a1dbf199 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -594,6 +594,7 @@ static int __init dell_smbios_init(void)
>  	if (wmi && smm) {
>  		pr_err("No SMBIOS backends available (wmi: %d, smm: %d)\n",
>  			wmi, smm);
> +		ret = -ENODEV;
>  		goto fail_create_group;
>  	}
>  
> 

