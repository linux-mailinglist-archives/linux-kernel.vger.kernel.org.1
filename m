Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A044E295F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899209AbgJVNCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506747AbgJVNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603371744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Baoti0rGPc8rx4Gu7rHbcn1CKN3zPD/a9Reidmnsr8=;
        b=MY87XrPHJxAeYzIgxFLgpjBbpa88WUH2Vr9H9c0QZtcvnhHVT2lVR+3VU7PNwLWgelMZEy
        E0k9IhfUQcTAb1twYqrYRm8FSwXwSCukF3gMsD/n1uTZC8DoNE17+GZysM6uUUOQ3WjYdT
        b/8J2tVKYvE+q4IT6rBjzpfv4Ue1LFw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-Xjm4QLyAOUG7sYm-FLdnVQ-1; Thu, 22 Oct 2020 09:02:22 -0400
X-MC-Unique: Xjm4QLyAOUG7sYm-FLdnVQ-1
Received: by mail-wr1-f69.google.com with SMTP id n14so603919wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Baoti0rGPc8rx4Gu7rHbcn1CKN3zPD/a9Reidmnsr8=;
        b=FIC7oevZCtdLEuPRUUP/PAUsr50cyzQADiyIj1/MVlaKgh9R9jstGTAiGiwOynLajh
         GW9FQ+XZjHCI2u0GCe05p7tbqs8IjAMC41A0SMEkL5YPUKX4sL8jE9vNYNadGuorpLLj
         xxIYoZXgEp6rr+N7X+FFwvtgAAF50PX7UpMtrPSw+usyO8ks2wmI6cQ9tAWQuVpN0uGd
         2I7K8PVfTtw04/+77rrYDpd5dY7uh6WFdtslRlFr3vsWIOhi6XIiDsoj3KGlMlzZ1ZzM
         X8OONNTuJg3HqfvhnRZov+MqI1NhBMqQBnVVfLuIn4CRPifBsXnKYax5j6oO1BJQdgmT
         HNRg==
X-Gm-Message-State: AOAM531TpdXduZzqciASws2Hxk3W420s4j4VucwzZ8xOJpzx1bCspDam
        lTN2Fdr52CSIJ6nFTTUZuaz6VacQV44mNx00hhe4HiueBOxbX/AlTkWHAcGS/oXW3OrX+/38Fd7
        9qMs6P9++de4uZaLqlqNWnme4
X-Received: by 2002:adf:97cb:: with SMTP id t11mr2834620wrb.292.1603371741247;
        Thu, 22 Oct 2020 06:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdR80pHuceIpF8ybnwX11kJxDdRfn6kU7dlv3coiblTzqqD1XBYYiyCglWKy6psAXPxI56Vw==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr2834592wrb.292.1603371741051;
        Thu, 22 Oct 2020 06:02:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l1sm4022890wrb.1.2020.10.22.06.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 06:02:18 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Expose KVM_HINTS_REALTIME in
 KVM_GET_SUPPORTED_CPUID
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1603330475-7063-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
Date:   Thu, 22 Oct 2020 15:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603330475-7063-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 03:34, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Per KVM_GET_SUPPORTED_CPUID ioctl documentation:
> 
> This ioctl returns x86 cpuid features which are supported by both the 
> hardware and kvm in its default configuration.
> 
> A well-behaved userspace should not set the bit if it is not supported.
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

It's common for userspace to copy all supported CPUID bits to
KVM_SET_CPUID2, I don't think this is the right behavior for
KVM_HINTS_REALTIME.

(But maybe this was discussed already; if so, please point me to the
previous discussion).

Paolo

