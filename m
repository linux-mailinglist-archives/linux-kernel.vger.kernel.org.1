Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0362B6D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgKQSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgKQSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:23:56 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98418C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:23:56 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id j12so22229334iow.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hStTG3+2TUli6PQOvC7dPwGocz2+5lnhRaphNDmsF7o=;
        b=dHFgcdxTqoVgltR0QV39GKAUWfKbMf5QfnMPG5p7waNUv+ZkA1/gneF1w6zkpH90MY
         EPdYSWFaQwMs45S/VeXDommwFjD02Nbk914rY/J4YuWDm9yOho2UJoB3kyXeiQ65+1T9
         ippsI9lSTpisSpV+93kQFB3qu0ulmT5nSov0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hStTG3+2TUli6PQOvC7dPwGocz2+5lnhRaphNDmsF7o=;
        b=PxN7OMgvS7pwCfpxRqsjnX1D6a55mgs64fAyrHHjI7/r8UcHkdkYqSin/CPTRTzF7o
         rtwAzoVhxKlMrK+DGKPKFO2BhiAjkrDpULAmv5Y0iQGxU92mbv1Y3ZexqrsIkCU8yDXs
         R7RYba9Cf+KDTNwvzmqP8GPS3D4Rf1cCXr/ae3qBb7ZKzm3iVXhjX5OsS5IDaI2U+fYD
         vEytM6tqstywS/1Zc4wKmDj+8HjjSLDAOJ8U8rYNqYPYhO9qcacykRr08QkEKdIkFlrm
         K00cZQCDyUxns6yD0mEWavwvdoR2oPiXSZUiWtyNJiR04NiWT2p5tIHoSEHC6McwaSQI
         QcZg==
X-Gm-Message-State: AOAM533V4U9vykYUuDlgVAKHmqNqTTSeqzaufHji8Klay7QuAm1xazGY
        rdeg0WkxCgnxtuJUnl5cOUk+Vg==
X-Google-Smtp-Source: ABdhPJwaX8OFMbS656oBoqafp2YHXNnFy4+skL3T48D9xTH0/h6YWfgkzADFw7Iuor466akBnnKSTQ==
X-Received: by 2002:a02:9f16:: with SMTP id z22mr4579615jal.123.1605637435780;
        Tue, 17 Nov 2020 10:23:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o3sm11660129ilk.27.2020.11.17.10.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 10:23:54 -0800 (PST)
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
Message-ID: <322a050e-82dd-7a1c-07c4-279fd59f32b9@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 11:23:53 -0700
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

