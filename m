Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B94B2B6D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgKQSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgKQSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:24:07 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:24:06 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id l13so7207227ilg.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hStTG3+2TUli6PQOvC7dPwGocz2+5lnhRaphNDmsF7o=;
        b=MYQ8o2upiR4xRbHNFHnMM/5tlZ2i4zwJ6ippaQFSfmTVahH9uGSxyWJ5RMzkHQcdjC
         dsD+SgEIPreNPuZ1GgQUCsQF2eluVwLU/8ItuBxgd9W3mTjPvqpiJEPaO1/V4Txmejmz
         brLXTEgjcWwJDY27ZGFKF4osENdZL4BHfjj4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hStTG3+2TUli6PQOvC7dPwGocz2+5lnhRaphNDmsF7o=;
        b=jS90UE807sm8iuZRub1qbceVtP0JginB1Fq0Rg0UpZgJIeBiXXJF/26cLvbJmpCz9V
         +ovD9zkUGSXZdxZgDsZAgX6AaOZTF3Wshyb+SNSMMwKEibNC/ea63y0x3BA/dq517R+c
         9dFtfF22y2dG5g2gNBF9yjC9Qx3K8yyo1OAcmSDpNFfca1yzbTo47+SJ2ey8g9XQQABO
         +gIH/ZpJ+c7wg+P/weiSbS6FVkiESg01gm6+vpCk9ivFHx+3SenCjJ1v8/I4emi9sl2L
         dg0/42UudvDPYYpOv4NcOBaBSsUCF2VkGrYkkYiPYVRtBFJnjtLuMnYJB5eis0KECBJ7
         b5Dg==
X-Gm-Message-State: AOAM532c7FY/kYbJ+51bkgHwSwPh6TJZLMnsMkaR+CAMn/aYoUrzt9T1
        stPTKeXnrHJZYKv8lgQ8MfYFLQ==
X-Google-Smtp-Source: ABdhPJwx02xrIeI2eECsWwate6BBRxRuaxJV0280nEGDfsUQAnVJOBkwnqep1/S28GiJqt0mSRgT7g==
X-Received: by 2002:a92:c043:: with SMTP id o3mr12909972ilf.201.1605637445112;
        Tue, 17 Nov 2020 10:24:05 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e13sm14085604ili.67.2020.11.17.10.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 10:24:04 -0800 (PST)
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201113210327.GJ17076@casper.infradead.org>
 <13467f88-7e22-ce3e-60b6-44e7c3dfa7dc@linuxfoundation.org>
 <20201117173839.GO29991@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a256f95f-33aa-5f4b-6471-687514e7bc03@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 11:24:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201117173839.GO29991@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 10:38 AM, Matthew Wilcox wrote:
> On Tue, Nov 17, 2020 at 09:34:24AM -0700, Shuah Khan wrote:
>>> seqnum_inc() should just return the new value -- seqnum_inc_return is
>>> too verbose.  And do we not need a seqnum_add()?
>>
>> I had the patch series with seqnum_inc() all ready to go and then
>> revisited the choice. My thinking is that matching the current atomic
>> api that has _inc() and inc_return() might be less confusing. That
> 
> No, it's more confusing.  I know you're converting things from using
> atomic_t, but you really need to think about this in terms of "What
> makes sense for this API".  Unless you really want to have inc that
> returns void and inc_return that returns the new value, having only
> inc_return makes no sense.
> 

I am fine with that. As I said I have a patch series saved with just
seqnum_inc() that increments and returns. I anticipated people would
have problems with seqnum_inc() that returns. :)

>> being said, I have no problems with making just _inc(). The reason
>> for 32 and 64 appended is based on comments that it including size
>> in the api makes it very clear.
> 
> By putting 32 and 64 in the name of the API, I would contend you're making
> people think about something that they should not need to think about.
> 

Are you recommending seqnum32_*() for 32bit and seqnum_*() for 64bit
which would make 64bit as a default? We have to make a distinction
for 32bit vs. 64-bit api.

>> No need for atomic_add() - inc_return() is sufficient for this use-case.
> 
> I haven't looked at the various potential users of this API, but there
> are often cases where we account, eg, number of bytes transmitted.
> 
> There are also cases where read-and-zero would be a useful operation
> to have.  I'm thinking about sampling statistics.
> 

The idea is isolating sequence number use-case first and restrict this
api for that.

thanks,
-- Shuah

