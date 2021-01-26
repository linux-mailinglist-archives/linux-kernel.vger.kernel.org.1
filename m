Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF79303AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404695AbhAZLCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbhAZEZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:25:42 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A249C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:25:02 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q1so31214448ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OP+XA4IGRguJccVNM97sFAdH8FtpcW6xsyoNvGCEAl4=;
        b=b60kroY3RX6kWGQDbf1L/w5aPO/vmZmNzbEyczKcKf8IPFYXtFJb5M3LIugu+Cipo8
         xiLXt6EBywDfG8CLY/gkxcU5C5pEFLcJDlgvo57PXeUlq/kM2rBA3uoMCZWt3ww9F6Os
         WEoIj6ZiOPVC8nrrZgCqeLEeFolP/n3lIOWDgBlb0/wEn15c1+AwQ9N9bm2zKu8uQC6i
         LoI0xqQEK4i4X3W/HfgEWquSvR3jDaJ8w+7UPMTK5CoN8xPFt/9VD4gTsLf2r8SmVK+P
         b/Omxkk0JYBYkSba+TnCb9wCcPp15JrxCGzUye7PDaOG4Br9JmHdaVSV1V6KVE+NX+Ln
         EVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OP+XA4IGRguJccVNM97sFAdH8FtpcW6xsyoNvGCEAl4=;
        b=V5UBlQri2a66YcbFB+wSwqZujGBU1DUrhky20XnFdjgdtQYFp+7rqUUIIhTvhKqDX4
         /BPb7mG+967t/fogQ51WSFHQ5zmTUfrRQ2uZfirECqB1w+n1stn1/xuPcA+93xFDba+6
         rygvBVxoVuyh8W1ANHejxc31/M1hbgrs7h0isqb6MleiKm9FtZT62KU4GiZvk+wnGJmJ
         2x4rET6wwbFraLIIP0dC49EDyU97j1Ap6pBDq/dmWtgp6rNmSgInod28220T/EoDy/G3
         ipQ6sX0ARqjnmkUk5a6+1MkSjRw0U9e3eftgJBdL795Wj6uiz4Lj9KgWDoC5HP6bNn1M
         EyYw==
X-Gm-Message-State: AOAM530jerG3RUF+ewBD7+ibBBsmw+3v6tLpamlZIAhQoD8yPHWNoB4E
        nUMANdGgWyn9dMDiDgCcRifT+PkMGaqNMQ==
X-Google-Smtp-Source: ABdhPJxNF/o7uG6MPrcBdKTADO1oysoEHuEbDYED76DjHEc2VmcCdIIbeFqUJFBueVw8VgyaB1xrFA==
X-Received: by 2002:a05:6e02:12e2:: with SMTP id l2mr3139438iln.91.1611635101527;
        Mon, 25 Jan 2021 20:25:01 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r9sm12636138ill.72.2021.01.25.20.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 20:25:00 -0800 (PST)
Subject: Re: [PATCH net-next 3/6] net: ipa: drop packet if status has valid
 tag
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, elder@kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210125212947.17097-1-elder@linaro.org>
 <20210125212947.17097-4-elder@linaro.org>
 <20210125192733.38ff2ac5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <5a04e525-e5b9-773b-2e8b-27adb3a01d0b@linaro.org>
Date:   Mon, 25 Jan 2021 22:24:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125192733.38ff2ac5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:27 PM, Jakub Kicinski wrote:
> On Mon, 25 Jan 2021 15:29:44 -0600 Alex Elder wrote:
>> Introduce ipa_endpoint_status_tag(), which returns true if received
>> status indicates its tag field is valid.  The endpoint parameter is
>> not yet used.
>>
>> Call this from ipa_status_drop_packet(), and drop the packet if the
>> status indicates the tag was valid.  Pass the endpoint pointer to
>> ipa_status_drop_packet(), and rename it ipa_endpoint_status_drop().
>> The endpoint will be used in the next patch.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
>> @@ -1172,11 +1175,22 @@ static bool ipa_endpoint_status_skip(struct ipa_endpoint *endpoint,
>>   	return false;	/* Don't skip this packet, process it */
>>   }
>>   
>> +static bool ipa_endpoint_status_tag(struct ipa_endpoint *endpoint,
>> +				    const struct ipa_status *status)
>> +{
>> +	return !!(status->mask & IPA_STATUS_MASK_TAG_VALID_FMASK);
> 
> drivers/net/ipa/ipa_endpoint.c:1181:25: warning: restricted __le16 degrades to integer

Wow, that's an important one.

Sparse is spewing errors for me.  I guess I'm finally going to have
to figure out what's wrong.

I'll send an update tomorrow.  I know how to fix it but I want to
verify it works before I send it out.

Thank you.

					-Alex

>> +}
>> +

