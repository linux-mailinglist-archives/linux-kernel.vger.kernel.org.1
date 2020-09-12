Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0BD267855
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgILGsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 02:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgILGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 02:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599893270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4tzdMPT4Ag7XjRut0d5gVcFKeBdX0XWZ6t+mUPAXZM=;
        b=bMg0zYaboiPfGwEkqqZnH2fY2xAk1HyRTPm5Rj4b1IrpcVvcfXFgQcyTknoP6vuISf+Qaq
        np/WkAPZJ0xZSaAorNANwT8JaUtu6B4Kb/iVMfpMPxigHHx8MkcdgBBNcmWpUCcqSOWqb3
        x0YRKmTA5bxbBnQ5z9xwYFo3F64zH68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-8UuqwGrNOySss9uHS7XQaQ-1; Sat, 12 Sep 2020 02:47:48 -0400
X-MC-Unique: 8UuqwGrNOySss9uHS7XQaQ-1
Received: by mail-wm1-f71.google.com with SMTP id c200so453436wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 23:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k4tzdMPT4Ag7XjRut0d5gVcFKeBdX0XWZ6t+mUPAXZM=;
        b=skEis+28E6cdd75YO2SpqGWrmQl5hOKd4UNH3a7NeT7yawE0uy7QGc6btxKNpISa8O
         tiaIcO4lC4GGhryeMgjjnJysO8p7r2WRtaPrB9D+dRcVkGeBJbtKG4HD6gp2Fs+OP/Ba
         jUUfw1ikiJDcdWc3K+/jsIeoTj/12WPcsKfJxLcdfPqPjMYSKyhcoi55oaASL/EpuDBR
         +3sM1IwfCTgP4L1I9jTTGtQRPkvTrquHXn+KeKRUcY0Bs05ztowoO6O9RJ6ahnWVuBcJ
         PKvO0bDeXg6cukt4A72zg1WluT1/EaeALBcU/dSmPODS14rqWEj1jsyYIq3G/MM97kFK
         X8ew==
X-Gm-Message-State: AOAM530dW7mEEZidIq+henWkO3sqTh14guHMKH67PQrpXgPJOXwhyKl0
        yY+rPybQ9PpXETi1hdtx/2CeR3xMJ/AIpuGVT/zchWiMTe0QcnZiLxTeHRKZIaHSs38SFSL32NY
        gWn78kzu911JGtz9pVX/weVMx
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr5733465wml.67.1599893267278;
        Fri, 11 Sep 2020 23:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxty33MEuHSQi4MTLGa4bmojFvAwBALUmBDJldvnQpqgiwbPgv10PDa1ok0MRL6H+D3faDPvA==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr5733447wml.67.1599893267106;
        Fri, 11 Sep 2020 23:47:47 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id h186sm8739380wmf.24.2020.09.11.23.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:47:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] KVM: collect sporadic patches
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1599731444-3525-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <019b3e94-b2b2-00a6-2904-a7c4a66b73e8@redhat.com>
Date:   Sat, 12 Sep 2020 08:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599731444-3525-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/20 11:50, Wanpeng Li wrote:
> Collect sporadic patches for easy apply.
> 
> Wanpeng Li (9):
>   KVM: LAPIC: Return 0 when getting the tscdeadline timer if the lapic
>     is hw disabled
>   KVM: LAPIC: Guarantee the timer is in tsc-deadline mode when setting
>   KVM: LAPIC: Fix updating DFR missing apic map recalculation
>   KVM: VMX: Don't freeze guest when event delivery causes an APIC-access
>     exit
>   KVM: LAPIC: Narrow down the kick target vCPU
>   KVM: LAPIC: Reduce world switch latency caused by timer_advance_ns
>   KVM: SVM: Get rid of handle_fastpath_set_msr_irqoff()
>   KVM: SVM: Move svm_complete_interrupts() into svm_vcpu_run()
>   KVM: SVM: Reenable handle_fastpath_set_msr_irqoff() after
>     complete_interrupts()
> 
>  arch/x86/kvm/lapic.c   | 36 ++++++++++++++++++++----------------
>  arch/x86/kvm/svm/svm.c | 17 +++++++++--------
>  arch/x86/kvm/vmx/vmx.c |  5 ++---
>  arch/x86/kvm/x86.c     |  6 ------
>  arch/x86/kvm/x86.h     |  1 -
>  5 files changed, 31 insertions(+), 34 deletions(-)
> 

Queued what was left, thanks.

Paolo

