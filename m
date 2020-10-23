Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF02975A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbgJWRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S465753AbgJWRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603473406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/cHvLWzMGMPGjQ5zpi3AHXgRU0M0geaUqAd4QVNRU0=;
        b=JU3EgxQ5LpKLoVb07KPLzQBtovkLn0HuTI/YqDwKTezb5KoPLclB9GwPJX36clyPtmHyy1
        RVMcbVTRhSlgXlkuNIoi7NPEscMKZwxMz5CQ6kRLZ2F5D7F53M78oZZUcvyV8gZX/LKZAa
        voXSdWxp0xS83Mk3Coge6LJ+DrE+DmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-6DAOuOudNgmuF_IO0FZV2A-1; Fri, 23 Oct 2020 13:16:44 -0400
X-MC-Unique: 6DAOuOudNgmuF_IO0FZV2A-1
Received: by mail-wm1-f69.google.com with SMTP id s12so717649wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/cHvLWzMGMPGjQ5zpi3AHXgRU0M0geaUqAd4QVNRU0=;
        b=ZPWAIgWPFASq6VwIsMJ2QhtKR5FH7zPhrfKCHo2AYP0CWKAowJC+E5BFaT1l4CuJPJ
         H0xxEkl6b69X4+ovJUYKhizTDG937bytQfWMGKbrgPzaFP+Cu+XMqyyeVo+6R2nrGK8y
         95dHdsAH4lVMGxQ2fhYbnE5sH2xF1DEr56Hf+zPHlc8LBiuMSVLzp5P3/wOSD6g+DI8v
         YyQdszyIEyvbFdaQ/Lwx3xbzwgP6+qWkX63HDMzAhOEqARl14Ltsm5X1UIDKAUomiHAA
         WhidglIcM9dDvH5mwCjrdN35NqsU7PGywfqm9BlRDo7EmBKu5H4bgoRgogEo1YqvqQPF
         xKpw==
X-Gm-Message-State: AOAM533+QBX0f6Sb7DIj0xJjLVoxXtGU8Wp2w1lzSlM0Yi3Q0pLflxjH
        3BjO01zxO8Mvq30V2m2f+QqsF20eP5TLhhXlaaEdgDQ411sHXmnoAeDDAUUCIQMYYTbFoKDgyC/
        QatnrHSa016I2CDByPaJBvEuY
X-Received: by 2002:adf:94e6:: with SMTP id 93mr3549301wrr.190.1603473403455;
        Fri, 23 Oct 2020 10:16:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweWKHpJ9UMric//7ibDgtHwen6W2t4r02W17Mt4X8j5J8RFELzbAIxL9XXMDAMSECFuTpHNg==
X-Received: by 2002:adf:94e6:: with SMTP id 93mr3549282wrr.190.1603473403249;
        Fri, 23 Oct 2020 10:16:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c130sm4318023wma.17.2020.10.23.10.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 10:16:42 -0700 (PDT)
To:     Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200710154811.418214-1-mgamal@redhat.com>
 <20200710154811.418214-8-mgamal@redhat.com>
 <CALMp9eSbY6FjZAXt7ojQrX_SC_Lyg24dTGFZdKZK7fARGA=3hg@mail.gmail.com>
 <CALMp9eTFzQMpsrGhN4uJxyUHMKd5=yFwxLoBy==2BTHwmv_UGQ@mail.gmail.com>
 <20201023031433.GF23681@linux.intel.com>
 <498cfe12-f3e4-c4a2-f36b-159ccc10cdc4@redhat.com>
 <CALMp9eQ8C0pp5yP4tLsckVWq=j3Xb=e4M7UVZz67+pngaXJJUw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 7/9] KVM: VMX: Add guest physical address check in EPT
 violation and misconfig
Message-ID: <f40e5d23-88b6-01c0-60f9-5419dac703a2@redhat.com>
Date:   Fri, 23 Oct 2020 19:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eQ8C0pp5yP4tLsckVWq=j3Xb=e4M7UVZz67+pngaXJJUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/20 18:59, Jim Mattson wrote:
>> The problem is that page fault error code bits cannot be reconstructed
>> from bits 0..2 of the EPT violation exit qualification, if bit 8 is
>> clear in the exit qualification (that is, if the access causing the EPT
>> violation is to a paging-structure entry).  In that case bits 0..2 refer
>> to the paging-structure access rather than to the final access.  In fact
>> advanced information is not available at all for paging-structure access
>> EPT violations.
>
> True, but the in-kernel emulator can only handle a very small subset
> of the available instructions.
> 
> If bit 8 is set in the exit qualification, we should use the advanced
> VM-exit information. If it's clear, we should just do a software page
> walk of the guest's x86 page tables.

The information that we need is _not_ that provided by the advanced
VM-exit information (or by a page walk).  If a page is neither writable
nor executable, the advanced information doesn't say if the injected #PF
should be a W=1 or a F=1 fault.  We need the information in bits 0..2 of
the exit qualification for the final access, which however is not
available for the paging-structure access.

If bit 8 is set, however, we need not use the emulator indeed, as the
W/F/U bits are all available from either the exit qualification or in
the SS access rights.  The access.flat test in kvm-unit-tests covers all
this, so it will be easy to check the theory.

Paolo

> The in-kernel emulator should
> only be used as a last resort on hardware that doesn't support the
> advanced VM-exit information for EPT violations.
> 

