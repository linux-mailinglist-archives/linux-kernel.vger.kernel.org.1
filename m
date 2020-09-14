Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8716326926C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgINNF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:05:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726555AbgINNBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600088489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3K12X8HJ+ECYw5CnAH7ONBajCRX6qc8Qgfrbmuplgg=;
        b=auEb51/CUja886KJlTJANhxdzOHkj27YY2p4ZPwurM5au5tuswKJ1mRriPaMGcsqLIouTa
        B6wabaFtIpJnyRaAufZ/CnyXSfUHfO3NM0ddEcXXlsSfJQd4S4y2K26ifN7lSyX3c9+WhU
        HaRSdsTuzeOqkJEB0HTkcwhg9MPVK9w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-7Z64iZS0NZqp-6jXrfc2dQ-1; Mon, 14 Sep 2020 09:01:21 -0400
X-MC-Unique: 7Z64iZS0NZqp-6jXrfc2dQ-1
Received: by mail-ed1-f71.google.com with SMTP id c3so9254839eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3K12X8HJ+ECYw5CnAH7ONBajCRX6qc8Qgfrbmuplgg=;
        b=X7gGDbWXBTGMSF/6CVW5KW5NO8J/RuX5okIImkubpuO6D3CSJThtevCJZfU95g3dl/
         IW1fklgl/D9Y0OGS9i34mOc0LlmRTV0WynI6De1l9T1XBZMOTXXGK7QApNWLXrEJL3bm
         zqkYnYuyxyYzbRfomaJ0ag6QMeulu9KgaVTlr7cfyVIdqnUJ2pNlvupplGnagzb8naJH
         +5Ja4c+RJxlF4Nwp/dU7QBNp+4/wTePRUVa/maJyeB2mFH9sXpM1r9WONfuJW2ZouubI
         a+uPnRqievr7LLVlK6BiTb3CK2i/teXTHNG3zqbelBINRM74SDe2DkVyLr/vTVroejD5
         XdnQ==
X-Gm-Message-State: AOAM532XJaaWTWI31OY/BagCAlb/VjULAp2AXc5vkj3vf5H/HeMSgjs0
        fB+sfKkheImUVXe8RvQUSBAUAz3/HNXNjz4P+imkTlPQRwxsXXL9Yjc40JeJPYzba7OqeWi6DSm
        dpr9et02yv2R/AcczK8+yiR5B
X-Received: by 2002:a17:906:4b41:: with SMTP id j1mr14363831ejv.1.1600088480714;
        Mon, 14 Sep 2020 06:01:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV61kmAn2Fj03CIxOncqAlwBEjPLAmkENAOhI6NrFuoJOLuor8JVJCagDvxtA9dbBAB0Ko2Q==
X-Received: by 2002:a17:906:4b41:: with SMTP id j1mr14363810ejv.1.1600088480513;
        Mon, 14 Sep 2020 06:01:20 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id j5sm7728407ejt.52.2020.09.14.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:01:19 -0700 (PDT)
Subject: Re: [PATCH 2/3] mfd: intel_pmt: Add Alder Lake (ADL) support
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-3-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8b88768f-9ddd-0e14-b788-98eb791c6aa3@redhat.com>
Date:   Mon, 14 Sep 2020 15:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911194549.12780-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/11/20 9:45 PM, David E. Box wrote:
> Add PMT support for Alder Lake (ADL). Use same quirks as Tiger Lake since
> the design is the same, meaning no support for Watcher or Crashlog.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Lee, I expect you will pick this-one up (and the next also) ?

Regards,

Hans



> ---
>   drivers/mfd/intel_pmt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> index 8f9970ab3026..1b57a970a9d7 100644
> --- a/drivers/mfd/intel_pmt.c
> +++ b/drivers/mfd/intel_pmt.c
> @@ -202,9 +202,11 @@ static void pmt_pci_remove(struct pci_dev *pdev)
>   	pm_runtime_get_sync(&pdev->dev);
>   }
>   
> +#define PCI_DEVICE_ID_INTEL_PMT_ADL	0x467d
>   #define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
>   #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
>   static const struct pci_device_id pmt_pci_ids[] = {
> +	{ PCI_DEVICE_DATA(INTEL, PMT_ADL, &tgl_info) },
>   	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, &pmt_info) },
>   	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
>   	{ }
> 

