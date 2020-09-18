Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83E26FFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIROcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgIROcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:32:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A04C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:32:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m12so5587512otr.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYJpr/JTfAc7wYRPBb4gv+TaUOt5dcnyH7jSr7tuCpM=;
        b=OizUltZ1LFId+L2XPadEiLoGsJia3Vb4yFpDK5KEcNWLrJW6Aem2AEybtF8cy3U+QY
         eoMGUf6mI0+wEijASIk6eboEjhmANetheAdBPBnm6rd+VaguUpkAbTzIdq2VelitR6BK
         syRnG+eDr/eNUK7FH0sWgDhnT/m+Rg3Nl1p4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYJpr/JTfAc7wYRPBb4gv+TaUOt5dcnyH7jSr7tuCpM=;
        b=XeyKv+U/1rFpeJUoSgmheLofwZFjeujLsTxpG6UGvzt+n18UiVLFeFRKUUemjIpGDo
         HXsuzfllKY2eK4yZkMxUJvCmwBrdDET8/H68hr7Ze8fNkF/6fP9gg31nuSFDG9fVxfoM
         WZd8sLBKY0RpR+NSwtZW8KFVe2VZVGRSD1HFyEqeLy6HbmWUlhqc5459epaIXHtATplf
         Y6Ew8dLyKBcTOQcpBaQxK+IvrnerFyhJcE9FtU4S/a6G3CTaC9k+gYTnFZIejaaJ/+5n
         jFnebA9/LKPOnmLGFY2PcN0vtOeywVgKI/+THJdTowR8nIxKmcM/uy3ZK+eyRK3VLjaL
         tFbQ==
X-Gm-Message-State: AOAM530dQXjWxmdfHOhAQ7QG4VptEvgMe2+HarEjfpD2ZOhC5yvM89tP
        LuE83x20ObExYWDPfiB/EbQ1dA==
X-Google-Smtp-Source: ABdhPJwswgZZxJoiRvH2rrmYQ1+FhmfcvUHyo8hVgSClH0jsk2AP5r/jo1ZLkWNCjw6q/XZ7vxlnEg==
X-Received: by 2002:a05:6830:118b:: with SMTP id u11mr23775978otq.261.1600439535424;
        Fri, 18 Sep 2020 07:32:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q14sm2347601ota.41.2020.09.18.07.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 07:32:14 -0700 (PDT)
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
 <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
 <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
 <87o8m3oiv6.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b610e625-159d-cdf8-373e-47f0b56412a3@linuxfoundation.org>
Date:   Fri, 18 Sep 2020 08:32:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8m3oiv6.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 9:37 PM, Michael Ellerman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
>> On 9/16/20 10:53 PM, Max Filippov wrote:
>>> On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>>
>>>> The test harness forks() a child to run each test. Both the parent and
>>>> the child print to stdout using libc functions. That can lead to
>>>> duplicated (or more) output if the libc buffers are not flushed before
>>>> forking.
>>>>
>>>> It's generally not seen when running programs directly, because stdout
>>>> will usually be line buffered when it's pointing to a terminal.
>>>>
>>>> This was noticed when running the seccomp_bpf test, eg:
>>>>
>>>>     $ ./seccomp_bpf | tee test.log
>>>>     $ grep -c "TAP version 13" test.log
>>>>     2
>>>>
>>>> But we only expect the TAP header to appear once.
>>>>
>>>> It can be exacerbated using stdbuf to increase the buffer size:
>>>>
>>>>     $ stdbuf -o 1MB ./seccomp_bpf > test.log
>>>>     $ grep -c "TAP version 13" test.log
>>>>     13
>>>>
>>>> The fix is simple, we just flush stdout & stderr before fork. Usually
>>>> stderr is unbuffered, but that can be changed, so flush it as well
>>>> just to be safe.
>>>>
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>>    tools/testing/selftests/kselftest_harness.h | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>
>>> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
>>
>> Thank you both. Applying to linux-kselftest fixes for 5.9-rc7
> 
> It can wait for v5.10 IMHO, but up to you.
> 

Good to know. I will send this for 5.10-rc1 then.

thanks,
-- Shuah

