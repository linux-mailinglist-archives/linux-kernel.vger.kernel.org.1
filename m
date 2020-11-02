Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2092A34AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKBT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKBTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:54:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C71C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:54:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id f21so7361658plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4ZxLGbZAH9QpwNm6ZRnurDjpa1h//fgROghHVw24OQ=;
        b=yf0U0iun06zfbK7Cnuqcth6fCp7a8lCxpobpBe+kmTP4SyoXbbUO2K3TYCK6UyDLoj
         ooPYjS4cznerRqU0lXrjLZCVpGCpPjd6Sn+ZNDbEjsdUHgnUiuCOiXXXcxl25lstTQJG
         tmcUn2mbPmmgM9njQGrxNbnj4QroRySYb0+a1/882d/2pjRY/D8LnjJp6l6lMudGtW5l
         WQab6USbKTmTM9oIjp5ESaE+M0vuJq1eJDjJCPIIqKtYMZlvA+lpI665wyc4MzyKlu3s
         kTVXUcgePa/052LwP1SMAb2vgEgBZB0k8BfsD4mulTlNDODd+8fQGcPEGpsaAJAy6WPG
         y+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4ZxLGbZAH9QpwNm6ZRnurDjpa1h//fgROghHVw24OQ=;
        b=jxmfw5Kw+3IWmfzq51Y/ipNuSWw5DE3ah8JcBEhDerCK0YgecmUsl9bgVQPaVArod6
         hB5EP4OJ+fUqVcfAqfEdn6vaOzh/LM64NmFL4u8ByERhvoD9R3bpsM2cqM6NC8KQj3r8
         VlkHo+IPUSQhZgUrnbBfo8jCbfB64ZopCjZfm1FscdetjKbW/FtmS4JRr59SoYGDFhiJ
         Web1eHxPzN7oyRqKvu+4/ABS+oJxfJNFM6NxMmF3bh+QtTXSGrafeQIA5DPxrUr6ocVz
         G0U0rdrSfStOYL2S369YkYTTkVnpmUdJMzBKjsr1kB1tuCm+Cx2v+Ztgxbb4df1d9kQe
         7LcA==
X-Gm-Message-State: AOAM533PrHTVEgXAdRZXYcIKO6B3Vb1nVHTqPuTpEBTwq2+T/pkQfTCj
        LO2lRQnjTKzU/ITCUA4sehfbA/cEgnVL/Q==
X-Google-Smtp-Source: ABdhPJx4OQKRrGqzCD36YPhLdEtoW51FRwM41PHLjI8T2B1Z88FwOtyf99yHIQdpRZQFmBq9iDKmQg==
X-Received: by 2002:a17:902:fe0f:b029:d6:9fa1:eee0 with SMTP id g15-20020a170902fe0fb02900d69fa1eee0mr143358plj.24.1604346881997;
        Mon, 02 Nov 2020 11:54:41 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b6sm269265pjq.42.2020.11.02.11.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 11:54:41 -0800 (PST)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
 <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
 <20201030184918.GQ3576660@ZenIV.linux.org.uk>
 <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
 <20201030222213.GR3576660@ZenIV.linux.org.uk>
 <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk>
 <87eelba7ai.fsf@x220.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk>
Date:   Mon, 2 Nov 2020 12:54:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eelba7ai.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 12:27 PM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/30/20 4:22 PM, Al Viro wrote:
>>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>>
>>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>>> and it wasn't ready.
>>>>>>
>>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>>> instead. The intent is not to have any functional changes in that prep
>>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>>> usable from io_uring.
>>>>>
>>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>>> threads, I hope...
>>>>
>>>> How so? If we have all the necessary context assigned, what's preventing
>>>> it from working?
>>>
>>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>>> *do* pass through that, /dev/stdin included)
>>
>> Don't we just need ->thread_pid for that to work?
> 
> No.  You need ->signal.
> 
> You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
> that ->thread_pid is needed.
> 
> Even more so than ->thread_pid, it is a kernel invariant that ->signal
> does not change.

I don't care about the pid itself, my suggestion was to assign ->thread_pid
over the lookup operation to ensure that /proc/self/ worked the way that
you'd expect.

-- 
Jens Axboe

