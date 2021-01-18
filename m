Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5016E2FA7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407259AbhARRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407213AbhARRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610991543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZseZIi8yX5S303NGIXXx/ulrgZxg6NH+kedVFwQTEs=;
        b=BCvol7gP2L6jyJfs1UYC1H16sYOZswcciyF34UobGd43rS5SGU7SvI8bpnufMdIr0u0knk
        HPL85pKnMFjoTc+YgPzhOiYkueQse1D+EIGYMk0s51jyG2fMrzz7hJxaXGBn0WlYA/9JZ3
        7OCOkEZy8fDlNxN0jKdT6KpXAOO8fdk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-KuPijVWWPmuZnP5bl4exNw-1; Mon, 18 Jan 2021 12:39:02 -0500
X-MC-Unique: KuPijVWWPmuZnP5bl4exNw-1
Received: by mail-wr1-f70.google.com with SMTP id l10so8268924wry.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZseZIi8yX5S303NGIXXx/ulrgZxg6NH+kedVFwQTEs=;
        b=ROd55b17vUplNv2Qo0jz7Eae9lmjGxP/sDo6ui2mgTxf5c1IBKiq7xUW6boOIi7VfE
         ez3ZgVwWiiSRiRsyBnqWcbVd2XmCAnnmzBxZwSWB5ZTdGTKa3Nyg+YY05iAVeoHwp2uP
         MMqrjj2sQliRVR18mQHrLs5sL3GqajRAjak8yGvkBfAwNAVeIvBHUomt8WWpEzoao3Ze
         yLLA6B0Fr6f2dPb1R4MIHc2jm185WI8HBUsJ/vfMqtDw7b4S2en+NUPUmf0CPNwfAUK3
         42aWWrMDMm6+1ImUFDvfXkTP26XSSXGoRyG/bmHdfJGZe7h0MaVDgCpUOe0yvQGz7dVe
         JXpA==
X-Gm-Message-State: AOAM531PP1kWPuFIZBhRPpBoyoH0P7rk78DCAd/AiQ6uLBHM9naBuJ5l
        X1xsEbyYMw6Czhj+xLsRm3g/HhBkLcoUc48feab8L0RPTBGoLijsPqQq7z8Bhf8rhAEx2tNgPLL
        k1vhbY6uGNSIC0vmc1H56Xl5S
X-Received: by 2002:a5d:51cc:: with SMTP id n12mr524716wrv.375.1610991540879;
        Mon, 18 Jan 2021 09:39:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzApCklNf3IsEiyOZJobGsxyao7L2kwG6STK5+IwNUs02K7KxFZ5oPtNL0EUhAYdjCSWDJH6A==
X-Received: by 2002:a5d:51cc:: with SMTP id n12mr524708wrv.375.1610991540752;
        Mon, 18 Jan 2021 09:39:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b132sm29295wmh.21.2021.01.18.09.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 09:39:00 -0800 (PST)
Subject: Re: [PATCH] KVM: Documentation: Fix spec for KVM_CAP_ENABLE_CAP_VM
To:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        android-kvm@google.com, kernel-team@android.com
References: <20210108165349.747359-1-qperret@google.com>
 <20210115165004.GA14556@willie-the-truck>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb2cc30f-5a9d-ce7c-61e9-ff62ad90e035@redhat.com>
Date:   Mon, 18 Jan 2021 18:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115165004.GA14556@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/21 17:50, Will Deacon wrote:
> On Fri, Jan 08, 2021 at 04:53:49PM +0000, Quentin Perret wrote:
>> The documentation classifies KVM_ENABLE_CAP with KVM_CAP_ENABLE_CAP_VM
>> as a vcpu ioctl, which is incorrect. Fix it by specifying it as a VM
>> ioctl.
>>
>> Fixes: e5d83c74a580 ("kvm: make KVM_CAP_ENABLE_CAP_VM architecture agnostic")
>> Signed-off-by: Quentin Perret <qperret@google.com>
>> ---
>>   Documentation/virt/kvm/api.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 70254eaa5229..68898b623d86 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -1328,7 +1328,7 @@ documentation when it pops into existence).
>>   
>>   :Capability: KVM_CAP_ENABLE_CAP_VM
>>   :Architectures: all
>> -:Type: vcpu ioctl
>> +:Type: vm ioctl
>>   :Parameters: struct kvm_enable_cap (in)
>>   :Returns: 0 on success; -1 on error
> 
> I tripped over this as well, so:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
> 

Queued, thanks.

Paolo

