Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF1304FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhA0DUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394294AbhAZUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611694076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HCxN2RDFJhyhwGoOhLA9wekT4P5GPKPHVcg2cvskDY=;
        b=YLUoThmeXIKSpGsp/6xJtWJ/2zWZuNkdvRJ6D3pmYGTxHWDv+RWSPBFCsvwMfP8qCOdyS2
        ekquteeOADP/UzM4tnQTq0n8m4AJje4giYoB6U4y6aszuCkU5T/DSUQJm8ySNyvCaciR5a
        Tu1QfEzjFnZwqmhzqcpJW0ZQpgN5UVo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-bafGV_0COrKgI_eTkhlkJg-1; Tue, 26 Jan 2021 15:47:54 -0500
X-MC-Unique: bafGV_0COrKgI_eTkhlkJg-1
Received: by mail-ed1-f72.google.com with SMTP id q12so5143039edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HCxN2RDFJhyhwGoOhLA9wekT4P5GPKPHVcg2cvskDY=;
        b=VeMEQ5mn8YA+/i/BlkydcUv6JcDXzZr5KnXa31rPgVRS8J+CitNBjW0T4aEseEl4ea
         jc4TB4H0WX4fnjQqReKB/0WZ15Jqq0dtBXyX+oIhOhlwVeaRpsIzJCnMECzzEYlBNq6C
         E/ZE/GAvnAGBW5X7zWvOrcHnp7FO+VpDzs7nweUBv215Z13W3uUjx4PfoW19O4IJYqJh
         vvX6lU4BBH00tZCRy47hUbQF/MPyO/YB98Mpwsk05Xz9a4ClTV6OcVqFjqNCA3nexIio
         /ZMdWI3wKEYBOIJwwfIQrJ2IwOxidYrYJ84wcOvf917u/LOUQudrK+q4xhT1CzPsgNRl
         Ov4A==
X-Gm-Message-State: AOAM533i0JUfEj8PkcBF9hxPPlLknlloczKmRVVV69xMKK9FC1juyQtc
        LAjHXAe3/CQMg7y7aHMXFwvupvSFMBUCrmibhn1Z4j52IFLV3bVt1v6oSTsWX8PRrpiSKNrXzzi
        6raR/EsbfFy6v8+OMdjwl1xN2
X-Received: by 2002:a05:6402:b30:: with SMTP id bo16mr6189941edb.84.1611694073167;
        Tue, 26 Jan 2021 12:47:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmZ5HCWexDCC3GBD7cA6Oeb9RSprTKU/jHiBICZcXEbfaoLoWKIRxt5Atedh7pEV7ZLumFIQ==
X-Received: by 2002:a05:6402:b30:: with SMTP id bo16mr6189928edb.84.1611694073017;
        Tue, 26 Jan 2021 12:47:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x21sm1202290eje.118.2021.01.26.12.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:47:51 -0800 (PST)
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
To:     Ben Gardon <bgardon@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-16-bgardon@google.com> <YAjIddUuw/SZ+7ut@google.com>
 <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
 <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com>
 <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com>
 <CANgfPd_TOpc_cinPwAyH-0WajRM1nZvn9q6s70jno5LFf2vsdQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1ef3118-2a8e-4bf2-b3b0-60ac4947e106@redhat.com>
Date:   Tue, 26 Jan 2021 21:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd_TOpc_cinPwAyH-0WajRM1nZvn9q6s70jno5LFf2vsdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 19:11, Ben Gardon wrote:
> When I did a strict replacement I found ~10% worse memory population
> performance.
> Running dirty_log_perf_test -v 96 -b 3g -i 5 with the TDP MMU
> disabled, I got 119 sec to populate memory as the baseline and 134 sec
> with an earlier version of this series which just replaced the
> spinlock with an rwlock. I believe this difference is statistically
> significant, but didn't run multiple trials.
> I didn't take notes when profiling, but I'm pretty sure the rwlock
> slowpath showed up a lot. This was a very high contention scenario, so
> it's probably not indicative of real-world performance.
> In the slow path, the rwlock is certainly slower than a spin lock.
> 
> If the real impact doesn't seem too large, I'd be very happy to just
> replace the spinlock.

Ok, so let's use the union idea and add a "#define KVM_HAVE_MMU_RWLOCK" 
to x86.  The virt/kvm/kvm_main.c MMU notifiers functions can use the 
#define to pick between write_lock and spin_lock.

For x86 I want to switch to tdp_mmu=1 by default as soon as parallel 
page faults are in, so we can use the rwlock unconditionally and drop 
the wrappers, except possibly for some kind of kvm_mmu_lock/unlock_root 
that choose between read_lock for TDP MMU and write_lock for shadow MMU.

Thanks!

Paolo

