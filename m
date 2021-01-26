Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3750C304EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391907AbhA0BYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391877AbhAZS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611685495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riHUl91cW/42T1v9JhfI+l/08ntS4eF8eLyqTUMJMu4=;
        b=JpHbu8bxE8sVp50Bpt7SqaycT4WT+JneUToGyd1CFqfzVMSGal8gf1iWoMIZBdifNpVb36
        IY4Lm5Vi4VnC7mwdn2jmpamnAUcQrB4KJUgZDrRM6esyRGXruQCn7bSy5/mnjwnMSXOxGW
        tm3P6ehJBwyssPBE91MjhUct7l+9ypk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-oV9hTBhIOXqtmAqIqUe76g-1; Tue, 26 Jan 2021 13:24:53 -0500
X-MC-Unique: oV9hTBhIOXqtmAqIqUe76g-1
Received: by mail-ed1-f71.google.com with SMTP id j11so9031558edy.20
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riHUl91cW/42T1v9JhfI+l/08ntS4eF8eLyqTUMJMu4=;
        b=n620lMa23IAOL4id8Qt+qceZjFr/2HulC3mIbEpArh072mFI/9X+cY7QxptFBSNgMI
         bfbUap2xksd0p5PWJSKVrmAyvgPLOAPGvpNa1Bz4MK8tesN3zYIFkEXECICPfMU4tEcX
         zoqN/e4LqSpi+7I6hYNsLRk/ZPKRYEmxg0CLVKtzFpRZFEe5PTjcrMaeB6r9ixA4fAAe
         OZhccqBAU7k31KXylhBCnccN8QC9CGr1+ngE2PIzg+BekpMRxkEqG/bGTYgSUpNEqmgW
         aWE7EXTW1lde3Kn8Yh9FR6tK1IsC8yApb3I1ST9ctKB+ZE+Fu0S3Wv1bTLMZfqpFiywN
         3BFw==
X-Gm-Message-State: AOAM530EKvgnaDyUroWegSsojRUhtjURCTxZIzkXOopF3M/KaBnVBvmg
        ZAOevakWc4FBx32jjHX1M6JrMyau/u87RX9XoC2sH3SkckkCP5AKeE8EqtJm1i6MzBGeSKGlAII
        bsmmYkWWuDN4LcDjMrTJ8BehyE9yD2zIUrnCtQ4MpQt+lzailZ9gpIQ/BqV7i39XnnoN2s3jOaY
        Nm
X-Received: by 2002:a17:906:3885:: with SMTP id q5mr4344922ejd.105.1611685492263;
        Tue, 26 Jan 2021 10:24:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzrSowQL+1Z10SlL4q0SQgPmEnQ/PkqXDrQg5FyswihXa/Niodq3FbdFKDjpHV3/ddu4Sc5Q==
X-Received: by 2002:a17:906:3885:: with SMTP id q5mr4344905ejd.105.1611685492040;
        Tue, 26 Jan 2021 10:24:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t19sm9966098ejc.62.2021.01.26.10.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:24:51 -0800 (PST)
Subject: Re: [RFC 6/7] KVM: X86: Expose PKS to guest and userspace
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-7-chenyi.qiang@intel.com>
 <CALMp9eQ=QUZ04_26eXBGHqvQYnsN6JEgiV=ZSSrE395KLX-atA@mail.gmail.com>
 <20200930043634.GA29319@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8f39e4e-75e1-8089-f8ef-9931ce14339f@redhat.com>
Date:   Tue, 26 Jan 2021 19:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20200930043634.GA29319@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 06:36, Sean Christopherson wrote:
>> CR4.PKS is not in the list of CR4 bits that result in a PDPTE load.
>> Since it has no effect on PAE paging, I would be surprised if it did
>> result in a PDPTE load.
> It does belong in the mmu_role_bits though;-)
> 

Does it?  We don't support PKU/PKS for shadow paging, and it's always 
zero for EPT.  We only support enough PKU/PKS for emulation.

Paolo

