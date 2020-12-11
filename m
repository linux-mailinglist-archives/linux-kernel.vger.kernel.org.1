Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3572D74DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 12:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395047AbgLKLoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 06:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391022AbgLKLnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 06:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607686928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ry4QLCFBuVcgRrGECJpsR3PjwcufaE79G5/vr18zuM0=;
        b=iXlSGoI5cJLyqwZbnsO1dlJqWi3vgdRGlVaq88LvU+NHZ65jXBA5PJB1HmTs1YNKR9ArcP
        /llOGy5sTtVX4mOCUq47cUHHzV5/dh/vVliha91f53fL72CiIWr6FPtfX+uivvH1cyGmRm
        4c8gmxVzqRjVHxokq93R3c4AM2QyXCo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-u6hswRUJPNKXmLy8j9TXpQ-1; Fri, 11 Dec 2020 06:42:06 -0500
X-MC-Unique: u6hswRUJPNKXmLy8j9TXpQ-1
Received: by mail-wm1-f72.google.com with SMTP id r1so3157322wmn.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 03:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ry4QLCFBuVcgRrGECJpsR3PjwcufaE79G5/vr18zuM0=;
        b=B7+EtqB8JClPSYpMa670zw9RiyDg4rA04ymmRKf69fzw+qYODQDi0yggFSLFnLbkxX
         lRHcYEh5fvVZXrG9yhUoV+sahzxaz5f2r4GqjIPJTGiDBXoK2deGg/DSLNtyZBlUaQbr
         vzFZ3+1FxVUG611ID78HD9M3O6Nb6WbKyNvui1l3CE2PgJBVKin/XG/WVII1UPd1pcP/
         0SWbHrbG/xuI7RNPiPqwLhd95u5DbAGXlVr9qNpeyBIMg5ihZ9sTaVtQf7BEJtWNzP22
         d1uftplXRRWmzeD4MR6MyvUr5Etnto5/NUhMIIKOm3u5jSoTFFBbOxFZj5g/s9/5ZnfO
         pk6Q==
X-Gm-Message-State: AOAM533/iLaSf9RrJ9RttwkRDrQXi9aVAV2abmZf9QJsbdspD7QY4GBa
        bYt3yjoG+1UmTGu4duc8pFhiNnBRrUSjAVTJ1RJ872AO674mgP9DLCc5PAOpZuQBXLrEWawUCce
        JrCWMYqwiZ+3WPrdWRhv/CXhV
X-Received: by 2002:adf:8185:: with SMTP id 5mr13009130wra.44.1607686925140;
        Fri, 11 Dec 2020 03:42:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXgc91RMaWJBoQmaitT2etxSTZvic/O2Map1BC8Kl98FhLjU4l6ovbObXtEGhr9cTTmfJCSA==
X-Received: by 2002:adf:8185:: with SMTP id 5mr13009097wra.44.1607686924922;
        Fri, 11 Dec 2020 03:42:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id c129sm14174329wma.31.2020.12.11.03.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 03:42:03 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
To:     Sean Christopherson <seanjc@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Michael Roth <michael.roth@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20201210174814.1122585-1-michael.roth@amd.com>
 <CALCETrXo+2LjUt_ObxV+6u6719gTVaMR4-KCrgsjQVRe=xPo+g@mail.gmail.com>
 <160763562772.1125101.13951354991725886671@vm0>
 <CALCETrV2-WwV+uz99r2RCJx6OADzwxaLxPUVW22wjHoAAN5cSQ@mail.gmail.com>
 <160764771044.1223913.9946447556531152629@vm0>
 <CALCETrVuCZ5itAN3Ns3D04qR1Z_eJiA9=UvyM95zLE076X=JEA@mail.gmail.com>
 <X9LLFMN5CNPIikSp@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5083c2dd-5aed-f7a9-4267-04cfca92032b@redhat.com>
Date:   Fri, 11 Dec 2020 12:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X9LLFMN5CNPIikSp@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 02:27, Sean Christopherson wrote:
> Michael, please reply to all so that everyone can read along and so that the
> conversation gets recorded in the various mailing list archives.
> 
> If you are replying all, then I think something funky is going on with AMD's
> mail servers, as I'm not getting your responses (I double checked SPAM), nor are
> they showing up on lore.

I think somebody else reported similar issues with AMD's mail servers.

Paolo

