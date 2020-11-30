Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2292C8677
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgK3OQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727384AbgK3OQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606745719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy2WUd8qluzxUHyAVJZ0iTyH/i+egdeldCJel1aWn4Y=;
        b=XDnqifpWWWmEqPhPm1iVO60/JIDzX23/GFgzXvTaYNfxFZgYPSNC5sQAO5VBUijHNwsnic
        K2mqG1IwzrH+tQPdAwWpTuhZB5FMpgexKys2muyrOIuykIsqNRl6GrM9cAu+qNdsB0fOLJ
        jXj01XFz0XF1nOG2guGgEuXuUfmhhew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-CR_B_9FKOZmR61IWjvQYjQ-1; Mon, 30 Nov 2020 09:15:15 -0500
X-MC-Unique: CR_B_9FKOZmR61IWjvQYjQ-1
Received: by mail-wm1-f69.google.com with SMTP id b184so1120492wmh.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jy2WUd8qluzxUHyAVJZ0iTyH/i+egdeldCJel1aWn4Y=;
        b=R7/GFm4fU3KezCpZ473n36WE0ljSrILWE3rWL0sAGYDwpFsv2jRPynsJ3GrSqho7FV
         3/c5YXwDO7vc2CTAIGYPDZ2o923gFXW+hyGjmLrjCkhKu2lUDTdNJD59H8vR0o2/c/1G
         39CGTBjHORFojB6us/C7h4B9fN/nt/XKoF9TrC4Cvder4ohZXEHgzpybNre6pT6dwT1p
         d4orOtMEyqKxcQk8oiTBbryKpUnOKkTinax6Aml2ZWkZ2f+DmDfRyeq1UaT9ZCRZiP8V
         Wra7asxMtETkN/8zqZIeZkbA78t4kz1/3AHJV4lQoyXllwOv2jJ3uxtpQs1n0s+O1JjT
         +/Hw==
X-Gm-Message-State: AOAM532fASvkseE+yVWktydAH/+HoDidYRh+j0tQrVDLxNZjL5FdLOvs
        frzqjto0axlwSohCBo3G9rZT4s08cn8x01BV8M4YdWauT5SsmbA05hm3u94WMJpYSyNWoWx1zWA
        I72k34MZiWYJdvuLCOJZN0nu0
X-Received: by 2002:a1c:e142:: with SMTP id y63mr10768881wmg.28.1606745714374;
        Mon, 30 Nov 2020 06:15:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4NO6q15SbHWukyBJ8MRyRFWENoejaNPVjxMUi4v5OO3B+V6ojxrsSeiVtMWCnB1wM/pytUg==
X-Received: by 2002:a1c:e142:: with SMTP id y63mr10768795wmg.28.1606745713286;
        Mon, 30 Nov 2020 06:15:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s2sm24357624wmh.37.2020.11.30.06.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:15:12 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: x86: introduce KVM_X86_QUIRK_TSC_HOST_ACCESS
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20201130133559.233242-1-mlevitsk@redhat.com>
 <20201130133559.233242-3-mlevitsk@redhat.com>
 <c093973e-c8da-4d09-11f2-61cc0918f55f@redhat.com>
 <638a2919cf7c11c55108776beecafdd8e2da2995.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e77e912-893b-0c8f-a9a6-b43eaee24ed3@redhat.com>
Date:   Mon, 30 Nov 2020 15:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <638a2919cf7c11c55108776beecafdd8e2da2995.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 15:11, Maxim Levitsky wrote:
> On Mon, 2020-11-30 at 14:54 +0100, Paolo Bonzini wrote:
>> On 30/11/20 14:35, Maxim Levitsky wrote:
>>> This quirk reflects the fact that we currently treat MSR_IA32_TSC
>>> and MSR_TSC_ADJUST access by the host (e.g qemu) in a way that is different
>>> compared to an access from the guest.
>>>
>>> For host's MSR_IA32_TSC read we currently always return L1 TSC value, and for
>>> host's write we do the tsc synchronization.
>>>
>>> For host's MSR_TSC_ADJUST write, we don't make the tsc 'jump' as we should
>>> for this msr.
>>>
>>> When the hypervisor uses the new TSC GET/SET state ioctls, all of this is no
>>> longer needed, thus leave this enabled only with a quirk
>>> which the hypervisor can disable.
>>>
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>
>> This needs to be covered by a variant of the existing selftests testcase
>> (running the same guest code, but different host code of course).
> Do you think that the test should go to the kernel's kvm unit tests,
> or to kvm-unit-tests project?

The latter already has x86_64/tsc_msrs_test.c (which I created in 
preparation for this exact change :)).

Paolo

