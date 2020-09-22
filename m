Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086E22744E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600786971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXdt9fw/2TfAWO/mEExo03IIhZLgGrVm6hP0Uymy1YA=;
        b=R5izwXr2mjdaaBbIZUj/Rov9y8I/XyhzzENEX9ybpRBfI1MS2Plvwk4wwW++VsduB5eJEO
        4VA+ttTo/7NlLR0Miz1NDJMa+XeV5pIwtMD8s1xhmB4KbO1mk305G8Pwa50NISm3k0OL+P
        e6pbLP51MNngdpxNLH/u5eBvL+AB9DI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-Cr14ce2mNVqoHOyXj7PP_Q-1; Tue, 22 Sep 2020 11:02:50 -0400
X-MC-Unique: Cr14ce2mNVqoHOyXj7PP_Q-1
Received: by mail-wr1-f71.google.com with SMTP id v5so7463144wrs.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sXdt9fw/2TfAWO/mEExo03IIhZLgGrVm6hP0Uymy1YA=;
        b=Y9x/fGVsCYNikork7Xi6GRL0M24JF9W2IAm805Ewp648O6bzJI30e112EKen5lmGYK
         Bc/JtIy2C2C2M+szaykUwsEV0Taqzv2j67QIOYula3fisR6E+/LOmgPDmFlXtMCV1UfN
         MunaVTiKIZcDLbQUSV+MaMHayCj9tGNt76A4ffC4Sz+fzaxtmMWuksxH9qdW+b4I9Lk2
         9YokBaA6PEYk2Pa8u/qA7AFM0WADX/gneT98pfycPbp/y5w821yj/aJpOYbwRrnmsWWz
         lAGWDj9aIgg7UyxrR/6DNah/fJf5EZJML9Fci6nuK3/JQcb34ostm+OMhLBqtWAuenl9
         0EEQ==
X-Gm-Message-State: AOAM533jX7My2n+U+3dYhDON+xorXvvX5O4kT6cuaWY+gtIsqsJMW+fL
        BU/689lsVV6FBcotDPx+q0y04qL96cbQAGUILQOq3jwXmjmX2MKwRtFVOwukse8toWh6YHEC3DO
        TkiAI7nBgsK+kzaWKHvlfbSUR
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr5824705wrw.348.1600786968823;
        Tue, 22 Sep 2020 08:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRvyk0As47yCKQ4K4LA3bzVIXSVekCW8ltcHuOYNeRajNkns6Q/QHxseNRPJDB06L6FIsMAQ==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr5824677wrw.348.1600786968569;
        Tue, 22 Sep 2020 08:02:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id w21sm4965312wmk.34.2020.09.22.08.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 08:02:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Use a separate vmcb for the nested L2 guest
To:     Cathy Avery <cavery@redhat.com>, Wei Huang <wei.huang2@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
References: <20200917192306.2080-1-cavery@redhat.com>
 <20200918211109.GA803484@weilap>
 <7549df39-b00b-0b0e-9f25-f64cdf6db366@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3645ce6-5110-9bcc-450d-69e3f6aabc6a@redhat.com>
Date:   Tue, 22 Sep 2020 17:02:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7549df39-b00b-0b0e-9f25-f64cdf6db366@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/20 16:07, Cathy Avery wrote:
>>>   -    if (npt_enabled)
>>> -        svm->vmcb->save.cr3 = hsave->save.cr3;
>>> +    if (!npt_enabled)
>>> +        svm->vmcb01->save.cr3 = kvm_read_cr3(&svm->vcpu);
>> Does this mean the original code is missing the following?
>>
>>          else
>>         svm->vmcb01->save.cr3 = kvm_read_cr3(&svm->vcpu);
> No it means I made an assumption here. I'll look at this again.

This should not be needed, nested_svm_load_cr3's call to kvm_init_mmu
should write to svm->vmcb->save.cr3.

>>>
>>> +    unsigned long vmcb01_pa;
>> Any reason that vmcb01_pa can't be placed in "struct vcpu_svm" below, along
>> with vmcb01?
> I just grouped it with the other nesting components. I can move it.

Please do it, vmcb01 is not part of nesting.

>     static inline struct vmcb *get_host_vmcb(struct vcpu_svm *svm)
>   {
> -    if (is_guest_mode(&svm->vcpu))
> -        return svm->nested.hsave;
> -    else
> -        return svm->vmcb;
> +    return svm->vmcb01; 

You can remove the function altogether (in a second patch).

Paolo

