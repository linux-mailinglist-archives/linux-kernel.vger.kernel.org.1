Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C12D1B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgLGVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgLGVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:07:09 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A71C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 13:06:29 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id q1so13555071ilt.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p9AfHP9RUgbPOiM4oNtMaqXuhiqhvukbABKjF1a0DOY=;
        b=R1pYaz95u9Ycvy7npq5FB3fegFBwtX0dGlIsfiplchVOGoGC7Yqe5GI3NAXXv9wKsk
         5dlmZFhXZ3qFDtXZ1hOBcG34wXJ2WgKDhQPj7SkmO1L9BZTTVVKdGo5Fr7rHeK0ulw+Q
         c/7BE/oTvJ5i4EPSLEkmH9+lm1WRRSBNUlbg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p9AfHP9RUgbPOiM4oNtMaqXuhiqhvukbABKjF1a0DOY=;
        b=fpJX/JzB79gyONgiZtQbbvL3NMpZbMEFmEWAkzx/RwwqIeuOWFzpEAN+ssQ/8tHvKM
         Z4tIjAHmSm8Zdkt30/mo3cxJ6sYI2OrU0KVsCAf/dj5T2Jpt64XHWy1R4g+vVV5xTLSY
         K+5dKJNY2z7vzv9zIqeHY2Em4YUPzu04gbJ47plNtd6KI8ydpWdkSLNdC2to95nOp+9P
         838iSexEhNktSPcId64wj5Nqd0BzTPRdv1Ns4P1hZdDOfKwVPqb/xQt/GYdy8eqSDHeF
         ELdO2TM84urK4ZgDS+rQIp1S0yWzoCw0n2VpUHRlW1LURHJDQA+o+JSX47emoj51PjRj
         F5vg==
X-Gm-Message-State: AOAM532kH9v5CmXkbjqVNnPMbcoiNP2Uwd6FXdWcOOHTtt/o5e/lKZNc
        QYkXLmdRbuPtCWd1Hg8PVee2Bg==
X-Google-Smtp-Source: ABdhPJydL3VULKgg9Z2FRVmDzjQU9ikvjmw3w4ALlIj62YReWcbFROnSQyeqcMdzwNXwlEWww6qHlA==
X-Received: by 2002:a92:cb52:: with SMTP id f18mr8267036ilq.41.1607375188531;
        Mon, 07 Dec 2020 13:06:28 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j12sm6694370ioq.24.2020.12.07.13.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 13:06:27 -0800 (PST)
Subject: Re: [PATCH] rseq/selftests: Fix MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
 build error under other arch.
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Xingxing Su <suxingxing@loongson.cn>, shuah <shuah@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1606277097-5853-1-git-send-email-suxingxing@loongson.cn>
 <1169128156.59953.1606320652393.JavaMail.zimbra@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <01ffd154-cb45-8538-dd27-8f2de87faee8@linuxfoundation.org>
Date:   Mon, 7 Dec 2020 14:06:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1169128156.59953.1606320652393.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 9:10 AM, Mathieu Desnoyers wrote:
> ----- On Nov 24, 2020, at 11:04 PM, Xingxing Su suxingxing@loongson.cn wrote:
> 
>> Except arch x86, the function rseq_offset_deref_addv is not defined.
>> The function test_membarrier_manager_thread call rseq_offset_deref_addv
>> produces a build error.
>>
>> The RSEQ_ARCH_HAS_OFFSET_DEREF_ADD should contain all the code
>> for the MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
>> If the other Arch implements this feature,
>> defined RSEQ_ARCH_HAS_OFFSET_DEREF_ADD in the header file
>> to ensure that this feature is available.
>>
>> Following build errors:
>>
>> param_test.c: In function ‘test_membarrier_worker_thread’:
>> param_test.c:1164:10: warning: implicit declaration of function
>> ‘rseq_offset_deref_addv’
>>     ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
>>           ^~~~~~~~~~~~~~~~~~~~~~
>> /tmp/ccMj9yHJ.o: In function `test_membarrier_worker_thread':
>> param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
>> param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
>> collect2: error: ld returned 1 exit status
>> make: *** [/selftests/rseq/param_test_benchmark] Error 1
>>
>> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Shuah, can you pick up this fix please ?
> 

Applying for 5.11-rc1.

thanks,
-- Shuah
