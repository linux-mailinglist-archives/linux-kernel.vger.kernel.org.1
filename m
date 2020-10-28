Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A758129DB38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgJ1XpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgJ1XpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:45:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7303C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:45:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so773817pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvlKRy98/mKD4i++41TPaeWlyBu9sqx7wcGcKaY/TDM=;
        b=BQQnwtRrM3JUiw2DhRadtME6Z6sUkD5n6fu2E6LSdZUkBOKG9RJR/ssiGKxjEc3LIA
         5EAWt6/E70btoxpHHlHq36FBBEpQQ2REMnnTcibs8MvVVidJrQQmwbVHQNgPnAexTMfz
         Lk0Smru33FJ0nwUQ/NZPAhyuYvLY23MxF/0NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvlKRy98/mKD4i++41TPaeWlyBu9sqx7wcGcKaY/TDM=;
        b=L5mFdJLBfgJHXxIGTHydEGeMse5doGeA4wxfbfcgrECiWZxNjcVIbYg88pjdvxPZ73
         VIJIHDbu0unumwcXxD6qpLFwJbwdhisX0rvU5r0HUSfWxmxC7SmfoyZWzrsUkM4Ijdo5
         wPregX6rgpB1j0uXsJqtci1mX9yq2yajxZHNqxoGYK5pp3LoTn9suGdyptEUAZAac6Ax
         52d/l6XXdeAWtBS1B7DHz0G1KPj9QrhwHJ6yrpksU9+MwARVmLo5mrcSg8lFp1r6+u6J
         lADvll//xHL6XaAeJheQKAIv8yS07tb3j/wv0Qxj95T+DGSWrclBwFu/ymw2u5H6lC/b
         3qZA==
X-Gm-Message-State: AOAM532E8Jk7vF4H59H8usPLk6aaI5T34XmAqsp5yZfaP9CXXKNbgaZD
        lN5bL1Lw+lIJOzQiyRS5uiAWNtKADv9cvA==
X-Google-Smtp-Source: ABdhPJzitR2S3/iO7EJ4vic5n1z0znADrqVMesrvJJ9W1lAnekXb85rB1swPySolffPwtbqYkgGvVw==
X-Received: by 2002:a92:5eda:: with SMTP id f87mr6288369ilg.131.1603895499474;
        Wed, 28 Oct 2020 07:31:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z9sm2740868ilm.21.2020.10.28.07.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:31:38 -0700 (PDT)
Subject: Re: [PATCH 00/13] selftests fixes
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <87tuufw2on.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <18daa545-b1d6-1867-fadc-cada628e2406@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 08:31:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tuufw2on.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 7:37 PM, Michael Ellerman wrote:
> Tommi Rantala <tommi.t.rantala@nokia.com> writes:
>> Hi, small fixes to issues I hit with selftests.
>>
>> Tommi Rantala (13):
>>    selftests: filter kselftest headers from command in lib.mk
>>    selftests: pidfd: fix compilation errors due to wait.h
>>    selftests: add vmaccess to .gitignore
>>    selftests/harness: prettify SKIP message whitespace again
>>    selftests: pidfd: use ksft_test_result_skip() when skipping test
>>    selftests: pidfd: skip test on kcmp() ENOSYS
>>    selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
>>    selftests: pidfd: drop needless linux/kcmp.h inclusion in
>>      pidfd_setns_test.c
>>    selftests: android: fix multiple definition of sock_name
>>    selftests: proc: fix warning: _GNU_SOURCE redefined
>>    selftests: core: use SKIP instead of XFAIL in close_range_test.c
>>    selftests: clone3: use SKIP instead of XFAIL
>>    selftests: binderfs: use SKIP instead of XFAIL
> 
> This series doesn't seem to have been picked up?
> 
> cheers
> 

I applied them to linux-kselftest fixes yesterday.

thanks,
-- Shuah
