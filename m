Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09F29412D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395296AbgJTRMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395281AbgJTRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:12:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2943C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:12:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z5so4664729iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uuwjwEOljJttC3noIZOCqqIYBreVk2fr4VN47y7vKW0=;
        b=nI7HbAUOrvYxqv+a3U5hwk/Kh9Q98OQfNbOJ73Yuw6hcN6zzn9knWePxv95cp+BG/M
         9tSTYZoDJM1icx9CZJGQC2PcPZauAUjgWnUdJ/jz0KQJbY/+CM54Bfg7tRBwX1QhNlO1
         eAMkFs3P/LvN4c9R67BK93XBVHZymqE0XvdHX3RNZ3yshuwYRfovQcWJ72eAsR6ypcZS
         6N0spBKVrFevrYAF+bqzo75Eaj5T+uji486M8zhDOc6Jq63UZ3hHrmat+So8h4mY3ydv
         wvHrF1lAAXhodxOavRAbkX1vIeSHW/NP2Q4EAxZom8qXRlvac3lRITw0LFEuOU/ZrhP+
         JoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uuwjwEOljJttC3noIZOCqqIYBreVk2fr4VN47y7vKW0=;
        b=OLVvstWTaDm6Ze64TCFiuUQFBXb7rVdtR7cHKHPA46XHdySXQi00vuEMtEJibcZ7cd
         caHSnGZkUTwEEwPG7aBifBJB0HDxljOQ781cOV2ZRe6eXmvWYx10buBrfqoqT2rDCOsS
         RIJ0wxF975ZHvjQ7E4v6EXM2GX6MsAZy/f+aYkuGo1JcwwSnW0blYFfivNSGkWnWZQtE
         5gP2MsGmKbsXRUyu9rBz+6wzYDLRfIkv9f7xjt1bjsGVdMANYsz61IQkUgr7xpchId3A
         2k4U1zEqDxHrZ4VJfuiyDwVhfJQJ7+TwX0dLxcpWJ0P/T+ksBPJCA4uqAbjC943s7KMa
         p71A==
X-Gm-Message-State: AOAM533/cARXwzkvjyLLpAIQHugfLmF9LTNowRDX3GOTyRQDQOt1TE7X
        Cpm1tscMkWsBrIa1aUKxlgxJRDtrKdtIEg==
X-Google-Smtp-Source: ABdhPJzLcAqWQAnL9JZbL136zAtVfHGD+BPO3V1uevd2c1UDhNfmSisEKSW1CvHYDCir0oF1WJtLCQ==
X-Received: by 2002:a6b:8e4b:: with SMTP id q72mr2895071iod.104.1603213963873;
        Tue, 20 Oct 2020 10:12:43 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e17sm2370658ile.60.2020.10.20.10.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 10:12:43 -0700 (PDT)
Subject: Re: dmar compile failure in -git
From:   Jens Axboe <axboe@kernel.dk>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     joro@8bytes.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d090c378-bfb4-34bc-7091-64e2b83925de@kernel.dk>
 <D8207C14-26C9-420D-9AA4-1E6D3F2F2191@infradead.org>
 <5646206e-ca52-4b1f-6182-4cb760ba712a@kernel.dk>
Message-ID: <90feb2ec-95c4-ddd6-4378-8ef56ddd2b5e@kernel.dk>
Date:   Tue, 20 Oct 2020 11:12:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5646206e-ca52-4b1f-6182-4cb760ba712a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 10:26 AM, Jens Axboe wrote:
> On Sat, Oct 17, 2020 at 1:03 AM David Woodhouse <dwmw2@infradead.org> wrote:
>> On 16 October 2020 22:23:46 BST, Jens Axboe <axboe@kernel.dk> wrote:
>>> Hi,
>>>
>>> Ran into this one yesterday:
>>>
>>> drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
>>> drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no
>>> member named ‘ops’
>>> 1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
>>>      |                                         ^
>>> make[3]: *** [scripts/Makefile.build:283: drivers/iommu/intel/dmar.o]
>>> Error 1
>>> make[3]: *** Waiting for unfinished jobs....
>>> make[2]: *** [scripts/Makefile.build:500: drivers/iommu/intel] Error 2
>>> make[1]: *** [scripts/Makefile.build:500: drivers/iommu] Error 2
>>> make: *** [Makefile:1777: drivers] Error 2
>>>
>>> which is due to the config I use:
>>
>> Thanks. Should be fixed by
>> https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg45697.html
> 
> Can we please get this known build breakage fix upstream? It keeps
> breaking my test box compiles, which is pretty annoying.

Nevermind, looks like it went upstream about the same time as I sent
this email. Thanks!

-- 
Jens Axboe

