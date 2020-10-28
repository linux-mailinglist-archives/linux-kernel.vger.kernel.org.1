Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE19529E0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732968AbgJ2BeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:34:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34772 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgJ2BdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:33:16 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kaichuan.hsieh@canonical.com>)
        id 1kXhXs-0007Qc-Bn
        for linux-kernel@vger.kernel.org; Wed, 28 Oct 2020 09:15:04 +0000
Received: by mail-pj1-f69.google.com with SMTP id m3so2294782pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 02:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVSsB/oA8Ef3ALyQyBnIakHAfprYqWGP5+wtO9BG0JI=;
        b=SDS32EuLkQc1O1AtuYqDVpLb6Xxxb9WGbat3gMlZTQR+NsKcFNl9bj/CZcU0zknbsv
         58ZMEZK1MMbFE89JF5EGEVlmw0WOvqspwlBN3jX7VXH+4lWeve/PlnTCLdMmsnlZNdpM
         2it+OoGjM8MSNxQL9k5Y5n63oJRxa6W2o3VC8AwkDBzTzJ22gL0GxRQZcYa3mHN25oqK
         IzpbHl+dQUo2fY8j6yggZLMuO3kJRvnaX/AOxZV2e6tQTmvVYDmaL2gu9q4RBCaa31f4
         GmtNHXApDYLoRs6H/n1mk/JDhl+uxyvsny7zkej/wscU+146hOPUiJ1vfsNxAxmCFkgd
         zRvA==
X-Gm-Message-State: AOAM531XvZrkQwMV9yDngN10NyDj6E9lNw6ODdsKkjqEL1Q529en1QkW
        XPB/lndg+PTiMs53S61sFteoZkvx6Ofx7/BoX3eLzGtVR6049V3CLRL8aQpxGgOvAvVM1lKrv9C
        k55NY2txiIfTr6vFBOvBlFobDST2xOqmmYY9igLaQxw==
X-Received: by 2002:a17:90b:3197:: with SMTP id hc23mr6079439pjb.78.1603876502870;
        Wed, 28 Oct 2020 02:15:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4HF7WK+iE7isUP7tynTkMoBWyCoLDYonVaPH3uU3YaduejKwA+LVvRnZn+uqpAA9TrmdvUQ==
X-Received: by 2002:a17:90b:3197:: with SMTP id hc23mr6079416pjb.78.1603876502457;
        Wed, 28 Oct 2020 02:15:02 -0700 (PDT)
Received: from [10.101.46.138] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id z27sm2009343pfr.206.2020.10.28.02.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 02:15:02 -0700 (PDT)
Subject: Re: [PATCH] firmware/dmi: Include product_sku info to modalias
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org
References: <20201028035015.8897-1-kaichuan.hsieh@canonical.com>
 <20201028100455.28cad0f5@endymion>
From:   Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Message-ID: <c165ab45-dbcc-8d7a-10ad-a66d6a157fbe@canonical.com>
Date:   Wed, 28 Oct 2020 17:15:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028100455.28cad0f5@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jean,

Thanks for your reminder, I'll read the document for future submission.
Sorry for not following the rule this time.

Thanks,
KaiChuan

On 10/28/20 5:04 PM, Jean Delvare wrote:
> Hi Kai-Chuan,
> 
> On Wed, 28 Oct 2020 11:50:15 +0800, Kai-Chuan Hsieh wrote:
>> Some Dell platforms rely on modalias to customize configuration,
>> the product sku can be more specific for the hardware.
>>
>> Add product_sku to modalias for better utilization.
>>
>> Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
>> ---
>>   drivers/firmware/dmi-id.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
>> index 86d71b0212b1..4d5421d14a41 100644
>> --- a/drivers/firmware/dmi-id.c
>> +++ b/drivers/firmware/dmi-id.c
>> @@ -85,6 +85,7 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
>>   		{ "svn", DMI_SYS_VENDOR },
>>   		{ "pn",  DMI_PRODUCT_NAME },
>>   		{ "pvr", DMI_PRODUCT_VERSION },
>> +		{ "sku", DMI_PRODUCT_SKU },
>>   		{ "rvn", DMI_BOARD_VENDOR },
>>   		{ "rn",  DMI_BOARD_NAME },
>>   		{ "rvr", DMI_BOARD_VERSION },
> 
> Applied, thanks.
> 
> For your future submissions, I invite you to read
> Documentation/process/submitting-patches.rst
> 
> Specifically, when submitting a new version of a patch, please:
> * Replace [PATCH] with [PATCH v2] in the subject.
> * Do not reply to the previous version of the patch, instead start a
>    new thread.
> * Ideally, include a list of changes from previous version, between the
>    "---" marker and the diffstat.
> 
> Thanks,
> 
