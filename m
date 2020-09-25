Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087A8278FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgIYRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727751AbgIYRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:31:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601055077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgoDrp/Imua9rkBntWaYSIW0+QvG7ttl6BenhB/EUzM=;
        b=DllsNc6LB5mJF5GUh5DZwu8TVa4oVZg7QkgkKhHtEfj4BZHUurVgEKSs+oI8zEp1aLtdc3
        Ffy4ukbUNKgp9H0vdJSg4ZdJ/P5EoJih7RkoT4O6Y6VIrkX64jVOolXCjtgn7Wykelr3WL
        kpT4OLjyC8bE57Liogt+Hciy1pIHSpk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-DoNGsHt_NxyWwUb37TYi9A-1; Fri, 25 Sep 2020 13:31:15 -0400
X-MC-Unique: DoNGsHt_NxyWwUb37TYi9A-1
Received: by mail-wr1-f69.google.com with SMTP id d13so1318209wrr.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgoDrp/Imua9rkBntWaYSIW0+QvG7ttl6BenhB/EUzM=;
        b=BALe3Ob0f7ExkYWDSXbcCwxUlLhGqrEgVNMAe3CvWt9MuuvYhZ+DwxdFT2WeOSRjNY
         5WF5l0LCk/VFrbTi92s1z/yoBtlA3YPQNtoq+PtLwyyDl0/j3TIOMqCYGfh4cobBWcUU
         lqybHICDgTmfKwB8RkVAFAViYToBlIHKzHs7ze/ZMwsO6zvEuCWrN0wQ0FjNecnNMvzF
         zo3KKkso6m8ZKiiHbAc6liXRHakIkT2gLL/2oS994ZzP0lN6fe/ttCu91zKUMVUHSSil
         BJ5P64K7aSPWmVeaLu916nJCXSNvyrIWYty/LkVvqyq2tnpm9SvA0kq65PqGnDd/yLb1
         CbXQ==
X-Gm-Message-State: AOAM530l5etwvyX3U4sn6KURw6ZvIgMMSX3Q7OmZJexfTedaGKUdj66B
        wr4w4Fh1z6SaqARd8AVtUZiTyi+/FqslVXK+7B7b2mD1MK/ralXo4AdVLzUNjZrfwS8RARRFCGC
        xkn4+zYURBHRuzw4w0TnaYKyA
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr4020260wmf.113.1601055073294;
        Fri, 25 Sep 2020 10:31:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPTDkbJwYC2USu6HcpR/XlLvGZo9MtasrQB1dk8DmaTxAl37UdJ+X+8ppmKhjjYed/hBPwxQ==
X-Received: by 2002:a1c:4c0d:: with SMTP id z13mr4020240wmf.113.1601055073075;
        Fri, 25 Sep 2020 10:31:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id p11sm3389322wma.11.2020.09.25.10.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:31:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] INVD intercept change to skip instruction
To:     Jim Mattson <jmattson@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <cover.1600972918.git.thomas.lendacky@amd.com>
 <CALMp9eS2C398GUKm9FP6xdVLN=NYTO3y+EMKv0ptGJ_dzxkP+g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8aa489b-493c-87d2-3d26-a34d6eef810f@redhat.com>
Date:   Fri, 25 Sep 2020 19:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eS2C398GUKm9FP6xdVLN=NYTO3y+EMKv0ptGJ_dzxkP+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/20 23:20, Jim Mattson wrote:
> On Thu, Sep 24, 2020 at 11:42 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> This series updates the INVD intercept support for both SVM and VMX to
>> skip the instruction rather than emulating it, since emulation of this
>> instruction is just a NOP.
> 
> Isn't INVD a serializing instruction, whereas NOP isn't? IIRC, Intel
> doesn't architect VM-entry or VM-exit as serializing, though they
> probably are in practice. I'm not sure what AMD's stance on this is.

Of course that isn't changed by this patch, though.

Queuing both, but a clarification would be useful.  The same applies
even to CPUID.

Paolo

