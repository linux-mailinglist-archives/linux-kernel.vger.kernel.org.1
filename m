Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037782C4664
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbgKYRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730293AbgKYRFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606323915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2YiWAjtkV6W/819w3VvfpBkbVrqf/nUdJ8hJ0IQwHg=;
        b=RpNoNYpDmgvCOj79s7VTLZbZky0rx6PvZddtx8NqPzg385n2V+hf5cGufGTpTFSHuInvS+
        4OkOvJKCMWwnxmONv3rv9AqTaHmRziczGzhvZIDr7Fpz9XMqfxaober/CeI8hmD/pIojzs
        dItabOqffuAV0cexqaGgMKGo/hQsmWM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-RR1mMt7qNX2Sg8fpj58L0g-1; Wed, 25 Nov 2020 12:05:11 -0500
X-MC-Unique: RR1mMt7qNX2Sg8fpj58L0g-1
Received: by mail-ej1-f70.google.com with SMTP id gr9so974187ejb.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 09:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S2YiWAjtkV6W/819w3VvfpBkbVrqf/nUdJ8hJ0IQwHg=;
        b=bOn62wowrk/ywbdn2fUSvIdRztfbAcbkDFv07feiayYhcOhLSYuCTGROGJk4hW7lvE
         nzeQdITQJ+cj5rCZDCU3c7CUc5RI7HNOl+A2j5kLvhAlwX9ImsflL6135LfvGkGEbydl
         /GjhIMEsC4V6TSvtwTRwREtbGtxA+eJT+6p6xDMUjL6zYB7jBd/84lZLFcsQkb2qIIPB
         XSTyWQJtFMHsowGD6cSD8m+WUS/IKuyeatpyiC/lQMSHE6anJ6RR89S78ngjsA9njLIs
         W6k05ieJMYB2XcNUSL4agMUG9Wyze1XsvJ3B/KXFLc7r/u+8JXGPaBt8BRGWsInVznCu
         IuUg==
X-Gm-Message-State: AOAM530zmMs7GgvMhJ5MbX+uTvSs979zHR6prN/7bm/OlMONEzP2UZyU
        FK4XJgG3m93b0Fp2frHg17XE93/cbrDT2BeGV+MDmyvpoW+lpX7UGftoW1SELM7ZiNe+2XtN+6v
        68vloRLhXi47x8eb1+QEQpZeu127SWqLdk8wqPyUbgiAXJGha4u559C5YWB8WkciYf5ubPE1Eu/
        N7
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr4424010edb.52.1606323910048;
        Wed, 25 Nov 2020 09:05:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/TsKMgYWbhR/wlSWjoHAwLH+WNXGsilWP/PO44bdE4caZvjScUkuVuIRvjD9nSFt32NBaYw==
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr4423974edb.52.1606323909766;
        Wed, 25 Nov 2020 09:05:09 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id gf6sm1602911ejb.80.2020.11.25.09.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 09:05:08 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-smbios-base: Fix error return code in
 dell_smbios_init
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201125065032.154125-1-miaoqinglang@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9f86ac03-1c90-e6b6-4f7d-e9584a19e46d@redhat.com>
Date:   Wed, 25 Nov 2020 18:05:07 +0100
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

+Cc Mario

On 11/25/20 7:50 AM, Qinglang Miao wrote:
> Fix to return the error code -ENODEV when fails to init wmi and
> smm.
> 
> Fixes: 41e36f2f85af ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Mario, this seems like a trivial fix to me, but I'm not 100% sure, any comments on this?

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

