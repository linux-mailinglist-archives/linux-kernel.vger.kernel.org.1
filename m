Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2B2FF5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbhAUUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbhAUUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611260534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ovEdbJJtNMDz8ByLenzszBFqIe93cujvjHmoLWVzLg=;
        b=VyD4VguWlUUpYaJ8m4/K1YAug5/4O2R/TVtS7M2g5vATALQ5DjqHTuMQrSxqzr/IZfYzLY
        JWmTp4cLxLkB9IcLVQbOUc+7pzlZuGickWlxRi2JPDVukmB+4L4XoXO16s6kKdcEonbKdg
        nCgD/8QOcWIv4//VsgQ007r7q5HBL98=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-SduXfsD2OyuI_PtRmrmAeQ-1; Thu, 21 Jan 2021 15:22:13 -0500
X-MC-Unique: SduXfsD2OyuI_PtRmrmAeQ-1
Received: by mail-ej1-f72.google.com with SMTP id md20so1242779ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ovEdbJJtNMDz8ByLenzszBFqIe93cujvjHmoLWVzLg=;
        b=ZOj2dxcBUqObgS6Um6Wk5xbT6OtIbh1KGZtRsyN2X4E27koTcKJn1oqqsDvZcJJKZq
         u71TZu8TKDaCbcBw/y2q7i9pXZ0INFCBP8AbMobuFHwbvYL0mMsrYh3mVEK9AkYqhNnD
         Vjfr3/NUNPMXuDaTqhITzguhuwjNqrtu4LH6eFHc9Yj7XsaE+qehrHRinm/4+BgZIQ6t
         ZzGUcawij3JYZ/kPogn6qf/hUZSwqqdu1kwb4DTK7A0MnL9OeMsJZl9wKyjNrSIYokKb
         3Q5xjh8GVAoQeYZ24mXTjP7a54r4iUjhcPUrtWyz4wr1v4q+db9YgIB+SLjaRD57lTfz
         ryNA==
X-Gm-Message-State: AOAM531bPeaA2gUQBSyBgQag8/Dkw8rRKamEPW0sAtxUG+JCeqdcq6ih
        nfujsYsVLIGUT8BotYLZkTE8FvZYbbfzOdBl3V96pVLRBLMmAkenUNAmQFgD73jUwxM+NYnb0J5
        yyCrdY2PW63+9WFNPKx0lqDk5
X-Received: by 2002:a17:906:3ce:: with SMTP id c14mr793780eja.497.1611260531971;
        Thu, 21 Jan 2021 12:22:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxohfZqlf87vOYxknBsFBhbTukEHWWxs7vQ6a0oQLkzvkgLnE79GERCpSdg+mhmNHXL4S1gcw==
X-Received: by 2002:a17:906:3ce:: with SMTP id c14mr793764eja.497.1611260531839;
        Thu, 21 Jan 2021 12:22:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b26sm3282219edy.57.2021.01.21.12.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:22:10 -0800 (PST)
Subject: Re: [PATCH 04/24] kvm: x86/mmu: change TDP MMU yield function returns
 to match cond_resched
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-5-bgardon@google.com> <YAh4q6ZCOw3qDzHP@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <611654f0-5dcb-b6a2-1b1f-26d10f2b8f7f@redhat.com>
Date:   Thu, 21 Jan 2021 21:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAh4q6ZCOw3qDzHP@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/21 19:38, Sean Christopherson wrote:
> Currently the TDP MMU yield / cond_resched functions either return
> nothing or return true if the TLBs were not flushed. These are confusing
> semantics, especially when making control flow decisions in calling
> functions.
> 
> To clean things up, change both functions to have the same
> return value semantics as cond_resched: true if the thread yielded,
> false if it did not. If the function yielded in the_flush_  version,
> then the TLBs will have been flushed.

My fault here.  The return value was meant to simplify the assignments 
below.  But it's clearer to return true if the cond_resched happened, 
indeed.

>>
>>  
>>  		if (can_yield)
>> -			flush_needed = tdp_mmu_iter_flush_cond_resched(kvm, &iter);
>> +			flush_needed = !tdp_mmu_iter_flush_cond_resched(kvm,
>> +									&iter);
> 
> As with the existing code, I'd let this poke out.  Alternatively, this could be
> written as:
> 
> 		flush_needed = !can_yield ||
> 			       !tdp_mmu_iter_flush_cond_resched(kvm, &iter);
> 

Yeah, no new line here.

Paolo

