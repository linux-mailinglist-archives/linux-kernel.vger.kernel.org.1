Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBC303BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbhAZLbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391564AbhAZJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611654705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1Drbrk3bg1upiMuuWq/VTSQhIu0Mj9h/2ZBicG/n7s=;
        b=SNDNqHjHrYr5ubUbuSMdCo8HUdJuwckk94dOl02qFAI+AQTV+kF6ZZ05fH6UIii1h7fIBx
        s1uPFXf1rs/7XZj0Un02XKh3Pta2xL2wTmUl4GWozZmCxq/IiTzkmGLyyswEvySSoyVErt
        1FXNfJ2HwGiaxWdJIDFYJKWR/HkqTws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-BHveo61dMXG__eiAbKd8sg-1; Tue, 26 Jan 2021 04:51:43 -0500
X-MC-Unique: BHveo61dMXG__eiAbKd8sg-1
Received: by mail-wr1-f70.google.com with SMTP id e15so10321940wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1Drbrk3bg1upiMuuWq/VTSQhIu0Mj9h/2ZBicG/n7s=;
        b=USWOR/F+ocGkQVKKuW9v7NLkyXB8V+fXwb8/0iSZNVwjzCvgZh63Docyb3dU8kFd8U
         LUCdROPf/EZ9W4/XdCQUJg8YkMzWHwRzrqExP1KMcVXXlYBo12OadcAxx0Oy3yXG/cmh
         P8WwSDEhH883swBwsvWMZEP4FO08mS1kus1TZwM0Woih1eludTxb31uQV31cuzA6RqfR
         KAoXyZ4TL38uuzzzFP9nEUCPCDPDOJ7cOkTn4llaRARBIEJ8SA1QS97KULxu4JSQf/DW
         Qi6mu6xOtJxeARGKpNgS2Grk3XD0k8ZKjgrnNRIFE+IdBt9k7YXYnF+6K2E2QlopL1YE
         RpRg==
X-Gm-Message-State: AOAM533UDPWuuASSUZOL4EHoOCdjqhxINpq+nKPT0JBU1lTHgwzPL3jI
        lm6HPKEsYLA397bejoGjk1WeHaMoRIKWTNsYZZFOdl5AYwFxXnytv5iX2t/eo1gTVpfH8h7Oj0s
        sQV7V6Z0cckskzwHpkriyKiMT2vd4Wl0or+UMKx6rVPf8FKpX7mwSp6ShxVC/9TUngCETZ74Lq5
        uj
X-Received: by 2002:adf:c18d:: with SMTP id x13mr5048836wre.128.1611654702368;
        Tue, 26 Jan 2021 01:51:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYA2pp7HnktKvkM3P0PAfaSuR/RpekdykcrCXhYcZDZZ6jilVLG0OHiChFK/gKv22kNx0EVA==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr5048804wre.128.1611654702129;
        Tue, 26 Jan 2021 01:51:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q7sm27784410wrx.18.2021.01.26.01.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:51:41 -0800 (PST)
Subject: Re: [PATCH] perf/intel: Remove Perfmon-v4 counter_freezing support
To:     "Xu, Like" <like.xu@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kan Liang <kan.liang@linux.intel.com>, luwei.kang@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20201109021254.79755-1-like.xu@linux.intel.com>
 <20201110151257.GP2611@hirez.programming.kicks-ass.net>
 <20201110153721.GQ2651@hirez.programming.kicks-ass.net>
 <CABPqkBS+-g0qbsruAMfOJf-Zfac8nz9v2LCWfrrvVd+ptoLxZg@mail.gmail.com>
 <2ce24056-0711-26b3-a62c-3bedc88d7aa7@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a85e154-d552-3478-6e99-3f693b3da7ed@redhat.com>
Date:   Tue, 26 Jan 2021 10:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2ce24056-0711-26b3-a62c-3bedc88d7aa7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 03:42, Xu, Like wrote:
> Hi Peter,
> 
> On 2020/11/11 4:52, Stephane Eranian wrote:
>> On Tue, Nov 10, 2020 at 7:37 AM Peter Zijlstra<peterz@infradead.org>  
>> wrote:
>>> On Tue, Nov 10, 2020 at 04:12:57PM +0100, Peter Zijlstra wrote:
>>>> On Mon, Nov 09, 2020 at 10:12:37AM +0800, Like Xu wrote:
>>>>> The Precise Event Based Sampling(PEBS) supported on Intel Ice Lake 
>>>>> server
>>>>> platforms can provide an architectural state of the instruction 
>>>>> executed
>>>>> after the instruction that caused the event. This patch set enables 
>>>>> the
>>>>> the PEBS via DS feature for KVM (also non) Linux guest on the Ice 
>>>>> Lake.
>>>>> The Linux guest can use PEBS feature like native:
>>>>>
>>>>>    # perf record -e instructions:ppp ./br_instr a
>>>>>    # perf record -c 100000 -e instructions:pp ./br_instr a
>>>>>
>>>>> If the counter_freezing is not enabled on the host, the guest PEBS 
>>>>> will
>>>>> be disabled on purpose when host is using PEBS facility. By default,
>>>>> KVM disables the co-existence of guest PEBS and host PEBS.
> Thanks Stephane for clarifying the use cases for Freeze-on-[PMI|Overflow].
> 
> Please let me express it more clearly.
> 
> The goal of the whole patch set is to enable guest PEBS, regardless of
> whether the counter_freezing is frozen or not. By default, it will not
> support both the guest and the host to use PEBS at the same time.
> 
> Please continue reviewing the patch set, especially for the slow path
> we proposed this time and related host perf changes:
> 
> - add intel_pmu_handle_guest_pebs() to __intel_pmu_pebs_event();
> - add switch MSRs (PEBS_ENABLE, DS_AREA, DATA_CFG) to 
> intel_guest_get_msrs();
> - the construction of incoming parameters for 
> perf_event_create_kernel_counter();
> 
> I believe if you understand the general idea, the comments will be very 
> valuable.

What is the state of this work?  I was expecting a new version that 
doesn't use counter_freezing.  However, I see that counter_freezing is 
still in there, so this patch from Peter has never been applied.

Paolo

