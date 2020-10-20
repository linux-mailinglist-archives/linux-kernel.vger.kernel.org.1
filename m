Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE5293A44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393823AbgJTLti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393559AbgJTLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603194575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJOHi7hCCCjte1IjtmuV53qRpJLxyma9mr6NzsxivYY=;
        b=eMHPZTj/n4WMwsw34ZRtF5Utufgj8RizcZcsW6dOIPVrH6KLtuixT1ZSo0Pqso4TZhI6si
        sqWGatzDcI6WbGZSwABQPSsSilDI5Q/LaagotpmBDz4M+ERLgvpPMVvitcl1bxtCf9dw1f
        KJIWEzztOsceYAyoehbCi5AXLajosEc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-kBYr357iP3uOsf9gEykUOQ-1; Tue, 20 Oct 2020 07:49:34 -0400
X-MC-Unique: kBYr357iP3uOsf9gEykUOQ-1
Received: by mail-wr1-f72.google.com with SMTP id i6so706689wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 04:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HJOHi7hCCCjte1IjtmuV53qRpJLxyma9mr6NzsxivYY=;
        b=IJ2dRmTH43nice27DkH05Q2UXiEqFVyWrqWnB1clPrxaPm2HypfbEaZS7hCDK/sTMs
         2NcLmUpZLrLJ5vHDWsg5EYebx/JnWhz5xb4Bcwy1/0X+H//uO5r3AOs0jpOuAPV1i5z6
         T5OQDAIKcrkfL8QIAPYEfAWxF+Yto2/zyf6BdGnQ6DMIaArKVtQCPEM4BXkdCwEAgUOO
         arn0itF+XwCfvxfv9qlWw7+8qtYSbRgF7C8OF4kNjaP3ItHKp4cWw4tZKKPJEFAQpvEp
         gShmRc7fyRoOIqqomlq0WQ/AEywpPFVEIw/NPwmtwnB7LU6j+37HaUSRmVewDKZtA4kt
         sk0Q==
X-Gm-Message-State: AOAM5308ZIwfT1EmxmKBmMmGw9cOV2t72RKktH6wnYmg0yMe8qlm+tBF
        3nBuX4Yp6UGTOsRmWjSIkOLkAi/ZZb2ah6SfQZIbxwzO6NH0LP/QaJsX2/oAfUinA9QAS6lRO1d
        siNOU6AiB/sn+fqprfro4mbx1
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr2644616wmy.51.1603194573145;
        Tue, 20 Oct 2020 04:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSAcDTZqsLEt3bb+95AsHI8IRoDgAog7DIIwwjTsqb14PwgPsSXiaZNkhonOMQ+nf1v3nhHQ==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr2644591wmy.51.1603194572890;
        Tue, 20 Oct 2020 04:49:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b15sm2631962wrm.65.2020.10.20.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 04:49:32 -0700 (PDT)
To:     Alexander Graf <graf@amazon.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20201019170519.1855564-1-pbonzini@redhat.com>
 <618E2129-7AB5-4F0D-A6C9-E782937FE935@amazon.de>
 <c9dd6726-2783-2dfd-14d1-5cec6f69f051@redhat.com>
 <bce2aee1-bfac-0640-066b-068fa5f12cf8@amazon.de>
 <6edd5e08-92c2-40ff-57be-37b92d1ca2bc@redhat.com>
 <47eb1a4a-d015-b573-d773-e34e578ad753@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: VMX: Forbid userspace MSR filters for x2APIC
Message-ID: <ac2be818-04c8-6027-870c-184148e511ef@redhat.com>
Date:   Tue, 20 Oct 2020 13:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <47eb1a4a-d015-b573-d773-e34e578ad753@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/20 12:52, Alexander Graf wrote:
>>
>> Yes, but the idea is that x2apic registers are always allowed, even
>> overriding default_allow, and therefore it makes no sense to have them
>> in a range.  The patch is only making things fail early for userspace,
>> the policy is defined by Sean's patch.
> 
> I don't think we should fail on the following:
> 
> {
>     default_allow: false,
>     ranges: [
>         {
>             flags: KVM_MSR_FILTER_READ,
>             nmsrs: 4096,
>             base: 0,
>             bitmap: { 1, 1, 1, 1, [...] },
>         },
>         {
>             flags: KVM_MSR_FILTER_READ,
>             nmsrs: 4096,
>             base: 0xc0000000,
>             bitmap: { 1, 1, 1, 1, [...] },
>         },
>     ],
> }
> 
> as a way to say "everything in normal ranges is allowed, the rest please
> deflect". Or even just to set default policies with less ranges.
> 
> Or to say it differently: Why can't we just check explicitly after
> setting up all filter lists whether x2apic MSRs are *denied*? If so,
> clear the filter and return -EINVAL.

Hmm, if you start looking at the bitmaps setting up default-deny
policies correctly is almost impossible :/ because you'd have to ensure
that you have at least one range covering the x2apic MSRs.  I'll just
document that x2APIC MSRs ignore the filter.

Paolo

