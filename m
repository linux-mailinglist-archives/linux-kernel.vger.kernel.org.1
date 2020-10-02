Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576E0281937
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbgJBR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:27:53 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2FBC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:27:53 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f15so1964187ilj.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhP79kZciUU4dVo6hvpfLle6d5MaeIfDR+3Npq0TkNo=;
        b=TAqoowxnvS/2fOkInBCExTNrhFd5nD+Liycnhwa/M3NNLKdcdHW/Qqqz2qXZr53ROR
         ttwqki4//wqATBVHRlsGOcur+nhBEyQEFxZdgOhA9NOChTsDORDQzR1Q40romHycStrN
         cSkig9d+6ySrm+ZKwU8/pg/6hlDE+2yVOgti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhP79kZciUU4dVo6hvpfLle6d5MaeIfDR+3Npq0TkNo=;
        b=PekmKBqYc/GEgzSNFlWf1YzXPvWyM5Nf9XWIQxnDcal+AkoE4LsfCQPu74auWIdo5n
         4KRPAV+uEZmzbt8gRdm95ZoC+e8hpKshmADz6wwSxKw4hRC3F5aZrqIwemnm6LdwN7+b
         82+IHDO7/WlT4L0T3uasj/PQR3BpYrtWDq3pSKQchqnGje3D8gE5KUYWVrBZ9LlXpT5P
         Cg67CEzh3RvZFEs8w5hrrMnrpj48e+ZGEVEIEbt8kF8eAspfAu+NVJJtLd88ZecB12G2
         9rmTMDFwyi7QweAW1K17e1hhouV3WZYjBmgx43MjnAx9V0dPDLo4japnT++g14/vlu5c
         cJDw==
X-Gm-Message-State: AOAM533u4UgAKKtoX6oXST5hUCExzdxePta7lDz4Gvxf+jloD4s9MTMH
        tpPOE5xykL88QmCBRXlzpSebNw==
X-Google-Smtp-Source: ABdhPJw5Rb/qdckezT85qY4GYNBl1+UP/H2HCCr1I0GbqpqMl2E6BQLz0xcxSpI3DzRKcNqGaPGr6w==
X-Received: by 2002:a92:950d:: with SMTP id y13mr2686126ilh.42.1601659672856;
        Fri, 02 Oct 2020 10:27:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h2sm982660ioj.5.2020.10.02.10.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:27:52 -0700 (PDT)
Subject: Re: [PATCH v2] cpupower: Provide online and offline CPU information
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     Janakarajan.Natarajan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Pavithra R . Prakash" <pavrampu@in.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200929131108.19435-1-latha@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6694193a-f44e-1239-26c2-7e01650964fc@linuxfoundation.org>
Date:   Fri, 2 Oct 2020 11:27:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929131108.19435-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 7:11 AM, Brahadambal Srinivasan wrote:
> When a user tries to modify cpuidle or cpufreq properties on offline
> CPUs, the tool returns success (exit status 0) but also does not provide
> any warning message regarding offline cpus that may have been specified
> but left unchanged. In case of all or a few CPUs being offline, it can be
> difficult to keep track of which CPUs didn't get the new frequency or idle
> state set. Silent failures are difficult to keep track of when there are a
> huge number of CPUs on which the action is performed.
> 
> This patch adds helper functions to find both online and offline CPUs and
> print them out accordingly.
> 
> We use these helper functions in cpuidle-set and cpufreq-set to print an
> additional message if the user attempts to modify offline cpus.
> 
> Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> ---
>   tools/power/cpupower/utils/cpufreq-set.c     |  3 +
>   tools/power/cpupower/utils/cpuidle-set.c     |  4 ++
>   tools/power/cpupower/utils/cpupower.c        |  8 +++
>   tools/power/cpupower/utils/helpers/helpers.h | 12 ++++
>   tools/power/cpupower/utils/helpers/misc.c    | 66 +++++++++++++++++++-
>   5 files changed, 92 insertions(+), 1 deletion(-)
> 

Please elaborate the changes made since v1.

I am seeing compile warnings. Please fix and send v3.

utils/cpufreq-set.c: In function ‘cmd_freq_set’:
utils/cpufreq-set.c:332:2: warning: implicit declaration of function 
‘print_offline_cpus’ [-Wimplicit-function-declaration]
   332 |  print_offline_cpus();
       |  ^~~~~~~~~~~~~~~~~~
   CC       utils/cpupower-set.o
   CC       utils/cpupower-info.o
   CC       utils/cpuidle-info.o
   CC       utils/cpuidle-set.o
utils/cpuidle-set.c: In function ‘cmd_idle_set’:
utils/cpuidle-set.c:187:2: warning: implicit declaration of function 
‘print_offline_cpus’ [-Wimplicit-function-declaration]
   187 |  print_offline_cpus();

thanks,
-- Shuah
