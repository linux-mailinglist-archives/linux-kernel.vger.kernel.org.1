Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82099304368
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392812AbhAZQIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405045AbhAZQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:06:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70967C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:05:52 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d13so4264473plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUGKf1rME507Ip/sgLYerQXLQBf8ZuaBGXgiassQ+UE=;
        b=2T8xfwp98OrVyuqKvYUSZXjezEL2e8WLqSu2M7yTsbLm6GaXEzJAjCncjifab6iVDe
         se+oGr1es8a+zFJsbDyt75qNhcJQ0toUrUZG14GHhH7YcN9BJCirnZPjgrdHUGr3rfWX
         tuPGOhXBwjXWBCd388F1Eh+P2eD7bV9J3lVAWUxXtGGYn0xDHLkew7LEYt/N4QlbgTuO
         oc0RUxG5WnEysRpg2ptUbkB3Tckuc+4FnA/KrqW+P71xJ5kFcsx8ZqlqwHIOHr39t8BP
         MhR11zhJTTXISs2IY+/q59r4fheGXNAj4AlbSPgIRixkUnDFblS94TGVJGvtt4320hKs
         DDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUGKf1rME507Ip/sgLYerQXLQBf8ZuaBGXgiassQ+UE=;
        b=DxM7W3ZAkcMYqx4T7epeVUapHY15h+LC6rwNeC1q7wSUvhWks3ebVMQRwFCQCoJcnQ
         s/dYt4A2S7QwYOPAbHWlut13NaAh4JGpTOjtqKmW3e5uB3NpYsOSt9MU+QMHAv03pb7/
         kSj0EbiH8LApuCj4GHfrxzJt6Pv9wJkpAlCjau53+pGDmz0+Hk5/aG0DEQYW72QDnz5P
         EROVLh4aPNyLaaheb7YEMM0TM86g5265cbG43UDaLzc5JHn39rRVSGiClaAJTauxvnBy
         TVegzAiQOaUSAZFezj2nHybgu8rL5myyXir1xvMHvTHnKxy3S/T/xpU0TixVgArasaBi
         FYUg==
X-Gm-Message-State: AOAM53239Fvtn7Zei8TRaQZMkNPM/Cq6s2Ci7vVIp5CcNaMyUSGsrCT3
        +rbFZDW4f74w8wCncC1C00GUcA==
X-Google-Smtp-Source: ABdhPJxtmLxNwcwY8eY1ahoibAF48xUWBK7ur8a596imFdgXmP3USbF9OhxMV2/en52qUYZeoBJnyQ==
X-Received: by 2002:a17:90a:6407:: with SMTP id g7mr529756pjj.56.1611677151908;
        Tue, 26 Jan 2021 08:05:51 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q2sm18015463pfj.32.2021.01.26.08.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:05:51 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jia Cheng Hu <jia.jiachenghu@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210125204032.6b6a604b@canb.auug.org.au>
 <3F91181A-EDF2-4F01-9839-17B40D6EA07F@linaro.org>
 <fb60bac7-f572-d131-d761-f6ce10a05f69@kernel.dk>
 <20210126132946.GC10966@quack2.suse.cz>
 <a2d6399c-ba61-472b-1bf2-aa261d7dbbbe@kernel.dk>
 <20210126160156.GF10966@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe6e9e4f-af91-725a-ba2d-a932591b1923@kernel.dk>
Date:   Tue, 26 Jan 2021 09:05:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126160156.GF10966@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 9:01 AM, Jan Kara wrote:
> On Tue 26-01-21 08:47:55, Jens Axboe wrote:
>> On 1/26/21 6:29 AM, Jan Kara wrote:
>>> On Mon 25-01-21 11:39:50, Jens Axboe wrote:
>>>> On 1/25/21 11:35 AM, Paolo Valente wrote:
>>>>>
>>>>>
>>>>>> Il giorno 25 gen 2021, alle ore 10:40, Stephen Rothwell <sfr@canb.auug.org.au> ha scritto:
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> In commit
>>>>>>
>>>>>>  d4fc3640ff36 ("block, bfq: set next_rq to waker_bfqq->next_rq in waker injection")
>>>>>>
>>>>>> Fixes tag
>>>>>>
>>>>>>  Fixes: c5089591c3ba ("block, bfq: detect wakers and unconditionally inject their I/O")
>>>>>>
>>>>>> has these problem(s):
>>>>>>
>>>>>>  - Target SHA1 does not exist
>>>>>>
>>>>>> Maybe you meant
>>>>>>
>>>>>> Fixes: 13a857a4c4e8 ("block, bfq: detect wakers and unconditionally inject their I/O")
>>>>>>
>>>>>
>>>>> Hi Jens,
>>>>> how to proceed in such a case (with patches already applied by you)?
>>>>> Shall I send you a v2 with only this change?
>>>>
>>>> We just have to ignore it... But in the future, always double check that
>>>> you are using the right shas, not some sha from an internal tree.
>>>
>>> FWIW I have a commit hook in my git tree that just refuses a commit with
>>> unknown Fixes tag SHA. Exactly to catch such mishaps in the patches I
>>> merge...
>>
>> That's not a bad idea, would help catch it upfront. Can you share the
>> hook?
> 
> Sure, attached. Note that the hook just gets commit ID from the Fixes tag
> and formats it with 12 commit ID digits and appropriate commit subject.

Thanks, that looks great, and also fixes up short shas.


-- 
Jens Axboe

