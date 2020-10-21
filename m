Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B83029460C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410965AbgJUAbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410955AbgJUAbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:31:00 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD4FC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:31:00 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j7so218171oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1EKIojvj5WfHRlPVYfUZgLO8UvuHDM907Gh4Q1FZ38=;
        b=MXjSs3lhS6z1iFAV6zWfAiL5uh9YnrlhA0aSjKjFXcCV/JfEUl4Y0vJHCM5dmCRiun
         qKvbGl/QruGROhwOT2l5s/6qWWtGPhXpT3prAHhcQP53xUQPazib9hlUid/yw9mnNvo9
         KUzLP1bBHNsDeVbU2B66KklGPV3uSWX7rzODw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1EKIojvj5WfHRlPVYfUZgLO8UvuHDM907Gh4Q1FZ38=;
        b=Iw8ofoLIKguw6CN9AQH9o5oSDlsMAONuFcYIEwYi4TrMEg8f6PrCoUp1J7sKMfP3Ls
         RL3jJxdsO0h67rzhkLJN6kc1dNRf4ZAsFtTUy5xT+7gFvla+TCT+9K78an4/LOTY8kux
         f4Gs+Ncnq3S8G8ebgESYJ8kNP2lJ0jV9KVz0Dw3i2DRuXcz5tqYCpF/aeU4y8S2suOHU
         Dao4q3kcFfgiHXRJry8zuToT/QC6RUwjtRvBIpc7oPm+kOrzbgafvlYtvdb965KlGKXS
         a8U4iNaFda/hmzoJ359EACTSV1dsGGTZBssYucGbf5NQe2ZJLUQTYefNFF2pgtrxrLyK
         RNNA==
X-Gm-Message-State: AOAM530v01EqvcT04YSwymcDIXfi4+ZE2gXKw+xAe5YdNvDhoUYwExST
        j+ATdhBlD5TDdeUDHZTHGGX7/A==
X-Google-Smtp-Source: ABdhPJyIJvwjXZjkrNv0BidQDrCrJF8J+lBsjxwT/69HByYcuwLyN5zZXFWPgdv9KvwniUUig7e7+w==
X-Received: by 2002:aca:5285:: with SMTP id g127mr413334oib.88.1603240259580;
        Tue, 20 Oct 2020 17:30:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h24sm122361oov.35.2020.10.20.17.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 17:30:58 -0700 (PDT)
Subject: Re: [PATCH v3] cpupower: Provide online and offline CPU information
To:     Brahadambal Srinivasan <latha@linux.vnet.ibm.com>,
        shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pavithra R . Prakash" <pavrampu@in.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201016085929.86252-1-latha@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6459dc7-1ee6-a5ef-bae1-c09afbecb0b9@linuxfoundation.org>
Date:   Tue, 20 Oct 2020 18:30:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016085929.86252-1-latha@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 2:59 AM, Brahadambal Srinivasan wrote:
> When a user tries to modify cpuidle or cpufreq properties on offline
> CPUs, the tool returns success (exit status 0) but also does not provide
> any warning message regarding offline cpus that may have been specified
> but left unchanged. In case of all or a few CPUs being offline, it can be
> difficult to keep track of which CPUs didn't get the new frequency or idle
> state set. Silent failures are difficult to keep track of when there are a
> huge number of CPUs on which the action is performed.
> 

This fllowing text shouldn't be part of the change log. This type of
version to version change text is added between the --- and start of
diff.

> In v1 of this patch, I had sent tried to address this with repetitive code
> in both cpufreq-set and cpuidle-set. V2 incorporated the review comments
> and added helper functions to find both online and offline CPUs and print
> them out accordingly. Correcting compile issues in v3.
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

Add revision changes here.

> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 6ed82fba5aaa..f25cdfa05c5f 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c

thanks,
-- Shuah

