Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D632268BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgINNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:04:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59399 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726537AbgINNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600088469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/yLApSN3g3sKQ4UgKN8jqXaeihtb9JSJALhIWAXqjw=;
        b=XdINnFilYgscSSguX2CYXOqQYT+LE4luMxqGoXRO9sZd7KvsSwtbdAsu8gh1akfJfdBycB
        gjb8PsGkQhQ2FjTKQHFHHuT92Lms3xFJtaR+lv3xLdHdtXEnIL+wzZkhtsI+lOsoPN74GC
        TodB3KO4hJeFv3CWEBY4pAuoO3fneGo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-5GE9YCfQNR2QgcxVeVaLHw-1; Mon, 14 Sep 2020 09:01:07 -0400
X-MC-Unique: 5GE9YCfQNR2QgcxVeVaLHw-1
Received: by mail-ej1-f69.google.com with SMTP id i14so8048146ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y/yLApSN3g3sKQ4UgKN8jqXaeihtb9JSJALhIWAXqjw=;
        b=dKUbopdtgEJqrevjk7C0m5KMUkn9eg6ZlwPA+NomP4oD+ZAyExVtlwyK/B98vPnjMh
         XaFrwY3dO1rXi7xyqDoESOlOJrSqneKlvwpB8H0rDUL0pVt24lbzTCKOgrwEifbdtye1
         qH1kQg/JyeeDMsTgNSR33c83Opq03oir/OzdgbE8nSSs6Gn6vNb/TEsv2oQAeZszNCEN
         ue+Cze0ytuQNz+8nFuQ9I4GUuOJE0Gw7A0lX+7CbtHZyVHPPUSvEflI2KrtdBzljyLaO
         37bu0i/uBxK19kJVqeS82w7BYF2YYMHtBJaLDfhzCldPHnZ/INNMDF4Iqg+X3Up9eeKa
         vVcw==
X-Gm-Message-State: AOAM533O2HqweRzyd8KsPJlasXeAQSfHENTSQastGA7bQxBgUY6x8AMO
        WYEd8JdxB9hdre3e59QeWAvAFxstw+KyGPF9+/rlF8JbZBElVNV5lctKyrsHo7NI6zJJd/c8KqG
        6ndZ1bmh/RDEoxkH0uv0+i9qh
X-Received: by 2002:a17:906:829a:: with SMTP id h26mr15067356ejx.11.1600088466504;
        Mon, 14 Sep 2020 06:01:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoc1z1xu3emqSJUH95pycELTZjXR9eA1tG/OfChcpOWyQlmI2xnWy/Rq+d6slYeYnUSyHdpw==
X-Received: by 2002:a17:906:829a:: with SMTP id h26mr15067336ejx.11.1600088466300;
        Mon, 14 Sep 2020 06:01:06 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id j8sm9179832edp.58.2020.09.14.06.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:01:05 -0700 (PDT)
Subject: Re: [PATCH 1/3] mfd: intel_pmt: Add OOBMSM device ID
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-2-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e68c73f-4984-26d1-f15e-695c4c41dcf3@redhat.com>
Date:   Mon, 14 Sep 2020 15:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911194549.12780-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/11/20 9:45 PM, David E. Box wrote:
> Add Out of Band Management Services Module device ID to Intel PMT driver.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Lee, I expect you will pick this-one up (and the next also) ?

Regards,

Hans

> ---
>   drivers/mfd/intel_pmt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> index 0e572b105101..8f9970ab3026 100644
> --- a/drivers/mfd/intel_pmt.c
> +++ b/drivers/mfd/intel_pmt.c
> @@ -55,6 +55,8 @@ struct pmt_platform_info {
>   	unsigned long quirks;
>   };
>   
> +static const struct pmt_platform_info pmt_info;
> +
>   static const struct pmt_platform_info tgl_info = {
>   	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG |
>   		  PMT_QUIRK_TABLE_SHIFT,
> @@ -200,8 +202,10 @@ static void pmt_pci_remove(struct pci_dev *pdev)
>   	pm_runtime_get_sync(&pdev->dev);
>   }
>   
> +#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
>   #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
>   static const struct pci_device_id pmt_pci_ids[] = {
> +	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, &pmt_info) },
>   	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
>   	{ }
>   };
> 

