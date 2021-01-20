Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF162FCF92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbhATLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbhATKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:47:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5BC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:46:12 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d14so24802523qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IH+y5l7D9IXEiqreal2USqyW5KlCbCpfaX3aYI5hrxM=;
        b=hqvnX/GUC9ppLbTqTwHrv8Oaq9Gi5ilcaq0rvLQZKsCEO82tyevSV4jH6VZLDvi6gT
         eUngELb08kiQXKUeDZH/9WxR39+3VEyGLDV0AxF+R1cSif94bYhoxZlv4/rgKZOi/zsB
         J0TGViHqNY9WAhm98EJWjnrhTTDhVxGTSyiOmQRnQSroqvBo7lOBIKuLSoUsZrjZ1PNt
         BI9D6ebZ7PqSAW0DgHl1pVQHaXYsDVrT//nUzIImCxq7kUhXva1kINl6R+eJVYRVOOOR
         3+GHuq4EefbJcTvyZmZHE3sDGEEQ6DPJI49JON2tL8gFFjXsQBTTYEgUtELCi5DIwUsS
         Dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IH+y5l7D9IXEiqreal2USqyW5KlCbCpfaX3aYI5hrxM=;
        b=phH7QSm/JJCPLip1ucwZGDlkU32RIxRYT7REXfp9aeMLDGJnYFoYgk/X/4QeItJCzN
         a1NEcdnIBKJZCISZzq/MxLIj6aB8dirB/T9EOAWTW8yd2TTaYQ9HQeJ/wtw8qzyUiPMO
         OSh/fesn1oeWruBRHA7mQHavDYKLtbI4fZ2hKBFQU2XVuAxTJBr9g/yBMq58kQc+DCH6
         Hmth8wxX0svwQ6jhx0d2lkFsFNK4/h0bOwbdHmZn2BOTA8PSXyvRZNskboE9qZzOjOkM
         Qm+btAvF3vrGez1UdCT5f7rkT+xxQXGqm4CO/7WAIJjDc1206ZP5TyjJ5j2NS6BpGKSp
         HrEw==
X-Gm-Message-State: AOAM530KBoE/Qtus/MfwA/6aYWzQalBRIJ6Rh6oNKfmaO3OIURMkarBM
        f5bqNx29vipHeR/ItFGlBTmtng==
X-Google-Smtp-Source: ABdhPJznZ9/31lzAODteFFA8Su2/Qqb+HqHd69/SOir4QHFtIdzsP4arW1usNa6/7PVtnwItHzH0bw==
X-Received: by 2002:a05:620a:21cd:: with SMTP id h13mr3278885qka.204.1611139571749;
        Wed, 20 Jan 2021 02:46:11 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id v196sm1026251qkb.84.2021.01.20.02.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 02:46:10 -0800 (PST)
Subject: Re: [PATCH 1/2] net: wireless: intel: iwlwifi: mvm: tt: Replace
 thermal_notify_framework
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        davem@davemloft.net, kuba@kernel.org, luciano.coelho@intel.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
References: <20210119140541.2453490-1-thara.gopinath@linaro.org>
 <20210119140541.2453490-2-thara.gopinath@linaro.org>
 <87pn20garq.fsf@codeaurora.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <9452ceb2-3e3c-399b-4cfd-a31f71200fa3@linaro.org>
Date:   Wed, 20 Jan 2021 05:46:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn20garq.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 11:19 AM, Kalle Valo wrote:
> Thara Gopinath <thara.gopinath@linaro.org> writes:
> 
>> thermal_notify_framework just updates for a single trip point where as
>> thermal_zone_device_update does other bookkeeping like updating the
>> temperature of the thermal zone and setting the next trip point etc.
>> Replace thermal_notify_framework with thermal_zone_device_update as the
>> later is more thorough.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> The title could be just "iwlwifi: mvm: tt: Replace
> thermal_notify_framework".
> 
> But via which tree is this going? I assume it's not
> wireless-drivers-next so:

Thanks for the quick review. I would say thermal.
I will fix the subject and add your acked in the next version.

> 
> Acked-by: Kalle Valo <kvalo@codeaurora.org> >
> 

-- 
Warm Regards
Thara
