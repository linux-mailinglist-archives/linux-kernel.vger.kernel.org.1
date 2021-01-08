Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C682EF524
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbhAHPu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbhAHPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:50:54 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3434BC0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 07:50:14 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id b9so6797487qtr.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jfyQVb5F4Fnofjwp4gp3HmfbIgP2C1LdLC9T1MaxhqE=;
        b=Fd/iGCYcmREuauhENVWhXDuS650ocy4lTiDWN3CcIkwQ0pdr9wK4Nkdzy7n/iedqZD
         lDRI7oO9bPLZBUSlBwBxZM6Ugs+c9VD8/sdlkYv2vP0T+Hc85ZKUr1OeQds9eU6lh3ev
         /ymA5b1dQ63StLRN19OMeoIQKjTQqm78f6MGkH7Fn6vSrw198bmGmbxZhrZ+a9EztdC5
         3J1yP+Byw3coh8YQv13vogIuH+zuKkVCCKA3rTfkRbtpDHqZW8lPWU/MwRAb5WcyXLrH
         N/puP93uGUv3TwdsGUNn329/7tuFFe1QxJB9z4gqwxYBUAzzxm9T3U7T0A1BGwmA3tJp
         x6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfyQVb5F4Fnofjwp4gp3HmfbIgP2C1LdLC9T1MaxhqE=;
        b=ZcJvvTeL5ox/0Uhfl0IoDkjLIeynbk82EDkC9q8SRzaaGIfj33E1JaCXR26rtxkbZu
         mOS2qIn6a3ofXNVarDA+uqAldCpLwJAiZnzWdGCJAsQTq2g1IBwcGBUPfZi1ubdxiJrh
         wQs2Rtq+NJh4eEuhXucFEx+dV/5ZTg+QZr8cU25JLoSqEpRM9M8AC6gGxw8SDNA8j+V9
         hB/bJBuc3FoqXYRtOQXXYOTG4aV4bm5xNZr1/yg5DwK+S0yvOWMPXZHBAyl4dciEXNlD
         GO5E6dDWcHiAgy78pSuciOtTBPFgrrY9tOkGZ5IgjOOgj/VU86tZTIjgEv9Uaxz08D/d
         wc4g==
X-Gm-Message-State: AOAM533xfihwoCpLc2plSKlnHoaAe6zxIWcF/EWmjYcdbTuPeYJPXdnr
        NfWDSu7a79ATlySPvyaVH+jAMX/w5d0X8Q==
X-Google-Smtp-Source: ABdhPJyVgCVxH6DPzttzqVseTpzz084eIMiRf60Z3+k3TBhHzynQ2X+U/znUzzT8fPdW/OVwHeS2nw==
X-Received: by 2002:ac8:5359:: with SMTP id d25mr4161265qto.132.1610121013125;
        Fri, 08 Jan 2021 07:50:13 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id d140sm5071811qkc.111.2021.01.08.07.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:50:12 -0800 (PST)
Subject: Re: [PATCH 1/6] drivers: crypto: qce: sha: Restore/save
 sha1_state/sha256_state with qce_sha_reqctx in export/import
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, bjorn.andersson@linaro.org,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201219033027.3066042-1-thara.gopinath@linaro.org>
 <20201219033027.3066042-2-thara.gopinath@linaro.org>
 <20210102212501.GA1931@gondor.apana.org.au>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <a72257ba-14c2-8e61-435c-4daa3a7d6b6e@linaro.org>
Date:   Fri, 8 Jan 2021 10:50:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210102212501.GA1931@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/21 4:25 PM, Herbert Xu wrote:
> On Fri, Dec 18, 2020 at 10:30:22PM -0500, Thara Gopinath wrote:
>> Export and import interfaces save and restore partial transformation
>> states. The partial states were being stored and restored in struct
>> sha1_state for sha1/hmac(sha1) transformations and sha256_state for
>> sha256/hmac(sha256) transformations.This led to a bunch of corner cases
>> where improper state was being stored and restored. A few of the corner
>> cases that turned up during testing are:
>>
>> - wrong byte_count restored if export/import is called twice without h/w
>> transaction in between
>> - wrong buflen restored back if the pending buffer
>> length is exactly the block size.
>> - wrong state restored if buffer length is 0.
>>
>> To fix these issues, save and restore the entire qce_sha_rctx structure
>> instead of parts of it in sha1_state and sha256_state structures.
>> This in turn simplifies the export and import apis.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>   drivers/crypto/qce/sha.c | 93 ++++------------------------------------
>>   1 file changed, 8 insertions(+), 85 deletions(-)
> 
> How is this safe when the reqctx structure contains pointers?

Hi Herbert,

You are right. Also more I think about this, it is better to have 
another struct to export and import the relevant pieces.
I will fix this and send across a v2.

> 
> Cheers,
> 

-- 
Warm Regards
Thara
