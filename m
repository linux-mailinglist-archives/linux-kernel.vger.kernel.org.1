Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4381E3338
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbgEZWyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390643AbgEZWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:54:11 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:54:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o13so17751149otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEHNWK8k/WlKd/8yjTqdnOjSrmU4aZjgbRQ++Ul02Xg=;
        b=dCO1xrzi0FPAWYqrdZOyUT+c/dMweAuDyqZx6Dxc2vTZrbHGBztMxwokRhPX7h2kXe
         NY2znQa3Mv/CqlLeezbkglUAbqpY5EYMSKWfFwW4Ool0KK3p5iKDhOQedzv6RqzFQ1bj
         tzuIu4W8wXOunwyqWeXTh818xHVxA7NaTqZFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEHNWK8k/WlKd/8yjTqdnOjSrmU4aZjgbRQ++Ul02Xg=;
        b=e4y7HbOY8FGVCjEy4ETkzIHqpoVJ0Vn0h+VQW7GEcAnhJOWBg8wROorHzpMUVW2ORx
         9Hq43Mczrb/ffwWSFH16jCztte0L/sB+y9HDL8RIynvuX9KMAm60BZ7z+Fzb1K0hNvCn
         EuLXeYY8eL/TsXbd1w6FYLT0AalyNKaxS9YIvMnKOCxAu3MdQn+BJT5ICnD0mVoeKahn
         UPW24zXSVBkY+sgma/zkPOPHa4Bdqpgnf1fJOFUZw7JGHMBqMHdwCr/9MaxdAv5+mSe0
         lLhO8eytyDrwEUgg0z7+bd3hZdFKC6ob+/53/sNrow1d0riMk/KKN7rYa37P5aWtXcwc
         zllA==
X-Gm-Message-State: AOAM530idd7WFfEfUfjCtEkvnmLJj/1jCTqbCWV6C0PiT3AtGpGmSzSg
        lCXdy9uEt+rZB5fl1CFlBAsOEA==
X-Google-Smtp-Source: ABdhPJw1cJr5CHPF51MyYej6TFwjVU3SaGqzYM86Q204jUDeqG09h+cKjMQZSffPwfieLy7b6dDF2Q==
X-Received: by 2002:a9d:3b8b:: with SMTP id k11mr2542662otc.208.1590533650634;
        Tue, 26 May 2020 15:54:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i13sm396851ood.15.2020.05.26.15.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:54:09 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
To:     Joe Perches <joe@perches.com>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
 <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
 <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
 <b0854ec2906323d34514875a58a79d4cb74e44b0.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ea204501-84a3-badb-63f6-0a9d2fe12b19@linuxfoundation.org>
Date:   Tue, 26 May 2020 16:54:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b0854ec2906323d34514875a58a79d4cb74e44b0.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 4:27 PM, Joe Perches wrote:
> On Tue, 2020-05-26 at 11:04 -0600, Shuah Khan wrote:
>> On 5/22/20 8:26 PM, Joe Perches wrote:
>>> On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
>>>> get_maintainer.pl picks only the first email address found in the file.
>>>> Reorder my email addresses so it finds my linuxfoundation.org email.
>>>
>>> OK.
> []
>> Sadly, people that don't run get_maintainer.pl, leave alone running it
>> with --noremove-duplicates option. So your suggestion doesn't really
>> help me.
>>
>> My preference is to get patches to both Inboxes if possible which isn't
>> possible unless -noremove-duplicate is default. Having this option as
>> default probably will annoy lot of people . So I am not asking for
>> that.
>>
>> That being said, I don't understand your comment. Are you recommending
>> using just one email in these entries?
> 
> Yes.  And maybe set an autoforward rule in that email to
> forward the received email to your other address.
> 
> 
Sounds good.

thanks,
-- Shuah

