Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EF22CD4D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbgLCLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729054AbgLCLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606995720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2/JUVMbgmiwF4hVlwNNOMPd3HZB9sBekSW1KAEyKUo=;
        b=eAAGNo9jJ238Io+nRPRPr61HV0KhM0SVlgw9GYABCjWwhgKGjAxn0msKRo+bTtb41mN1Vz
        AUYZwgUoyuLtQ67MsVP7zAK4VneqO6P8/dftmdbZ1Kg1eCmQj2faSgksNbf5MZ74eZlbHg
        lNNtcoH/KoMy8Sii3naNm+sW/snz604=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-ReZi_JZbPNewoeLWA89kdw-1; Thu, 03 Dec 2020 06:41:59 -0500
X-MC-Unique: ReZi_JZbPNewoeLWA89kdw-1
Received: by mail-ed1-f69.google.com with SMTP id z20so813980edl.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 03:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z2/JUVMbgmiwF4hVlwNNOMPd3HZB9sBekSW1KAEyKUo=;
        b=EDH21MkJJED5RhBYDYlNgCdnzKoZGhRZh05mxvgvVQXg1nz3i9cudzHw3HTalRrnNN
         VU3R7ybJfSgIglghwCT6/PLLu0t5LVnhii/1JaACrMugv3YCfgKgYQxrJ4Re+KAk/CtE
         bIkf34VIDqpY7OT9jJVD1mWczAFFRdfILPxuuGKVuR9eZWRCcar3OrQfTGtbCGTGFh1m
         wzW0t2m7/voJGagnOkmZ759d45yQ0vzzSJK0pYV3UiHDvG5aS5x5EmZOjNct9oqUfaLg
         7wOktjcIbPXSfVIFXa7HhwWB2OcGZ9G/m8FnpT5TRO9Jzn2qSzyF8AnzrV4QQGTdN1sq
         nNzg==
X-Gm-Message-State: AOAM531UmaA0ey/S74HgMqBEEu3gt/X/RQ2er9x1Smki3vtfToO2HFE7
        8F6yMVJpulDCB3p/CB4KyiilPmJjGiJcYfRchaK0u6C+0I9G5UJIYrHIIqmOYyiHJpgtDAEMqY0
        9nystnyw1dCSTtT/eyEm9p/E0
X-Received: by 2002:a17:906:2ec3:: with SMTP id s3mr2053811eji.133.1606995718240;
        Thu, 03 Dec 2020 03:41:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxW3JyLsSOLmxQokAFrQzTXTB6znHfAxgajBoxXmC9FZky84x7HveAqEGoG3zNV8WzQk1bLWw==
X-Received: by 2002:a17:906:2ec3:: with SMTP id s3mr2053804eji.133.1606995718043;
        Thu, 03 Dec 2020 03:41:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z12sm677926ejr.17.2020.12.03.03.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 03:41:57 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: Precise TSC migration
To:     Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
 <87lfehfhez.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c78ac6dc-8018-11c5-2b1e-c201448472fa@redhat.com>
Date:   Thu, 3 Dec 2020 12:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87lfehfhez.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/20 20:35, Thomas Gleixner wrote:
>> This makes the random error in calculation of this value invariant
>> across vCPUS, and allows the guest to do kvmclock calculation in userspace
>> (vDSO) since kvmclock parameters are vCPU invariant.
>
> That's not the case today? OMG!

It's optional. If the host tells the guest that the host TSC is messed 
up, kvmclock disables its vDSO implementation and falls back to the syscall.

Paolo

