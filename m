Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB632D76CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393115AbgLKNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:41:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731837AbgLKNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607693960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbYS50aLgaeYn8FPpMDIw3UPfwJ6Umvgz/HtFuKmk7s=;
        b=CtHC0VVh8MxSpHEP65DpW7paymgUi03T6xk8mKgZ0UONLeF7a2En5+s7VKFYfShBS4pY87
        /17vAJnM4gDczZWWd9uPcuBWCJmdY12AROdpnm+8JtUYWo5kZw+2buwdSLU19lpl/yOduI
        Tcu8X3QZ4cok1WiMBVUZS7FDZ+PC+8s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-gKj42FtqOuKZOjBcHpT8xQ-1; Fri, 11 Dec 2020 08:39:16 -0500
X-MC-Unique: gKj42FtqOuKZOjBcHpT8xQ-1
Received: by mail-wr1-f69.google.com with SMTP id o12so3298849wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MbYS50aLgaeYn8FPpMDIw3UPfwJ6Umvgz/HtFuKmk7s=;
        b=Owx7acUFJfFzy9b7Ux5c5d8tsgcvGr3gi2ZryFQ4UOCEqgRVSXar3lUCj3f4enSVde
         cWhEEEU4S7oH8JdaLPrY1W35uFd1+oX1lsZy401MjcgfzJctICbd2oNxhvI4gdt9d0Uh
         GKzeYrLBpUWzcXlVABU+X/FzqwCixxvQatQJRjLlPUJN+X8FWnWE6CUmC95Njbfm38sX
         ZAvDA0v3uJB7NznLCMPGkAk3L8F94w8BwYTeYllpYJC8qwRPrX8Eh6IlcrpK2VHnvvPN
         P4G51PRgLesgQOuIJp2yYzHDbiWK2Aqs6nyndF0R3/Frp79YSrskzg9ZmyQzz0q+4NMh
         Iu7g==
X-Gm-Message-State: AOAM5334qYDTno7QklAq8G2rrHdUn4YEly1JzrcPg5QViAkP32UPUIVV
        kNXR/ooxrJKs471paQ+bpIEgnyjLrh9q1O18O8qmPLWfoLmGO5/NW4jvkAEL/Qw0g3r81KtE3LS
        Xehdr1aIyCJttQrnEnzzE9as7
X-Received: by 2002:a1c:220b:: with SMTP id i11mr13842433wmi.8.1607693955307;
        Fri, 11 Dec 2020 05:39:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI2Sm8O13+RtyhcFkjm1JSpJmZY6RWQyd+X32UvA79o8vY1b2Js12gOWiXyJUU7zuv6xuLIQ==
X-Received: by 2002:a1c:220b:: with SMTP id i11mr13842421wmi.8.1607693955133;
        Fri, 11 Dec 2020 05:39:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q25sm16582950wmq.37.2020.12.11.05.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 05:39:14 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
To:     Michael Roth <michael.roth@amd.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H.Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20201210174814.1122585-1-michael.roth@amd.com>
 <CALCETrXo+2LjUt_ObxV+6u6719gTVaMR4-KCrgsjQVRe=xPo+g@mail.gmail.com>
 <160763562772.1125101.13951354991725886671@vm0>
 <CALCETrV2-WwV+uz99r2RCJx6OADzwxaLxPUVW22wjHoAAN5cSQ@mail.gmail.com>
 <160764771044.1223913.9946447556531152629@vm0>
 <CALCETrVuCZ5itAN3Ns3D04qR1Z_eJiA9=UvyM95zLE076X=JEA@mail.gmail.com>
 <X9LLFMN5CNPIikSp@google.com>
 <5083c2dd-5aed-f7a9-4267-04cfca92032b@redhat.com>
 <160769329840.1247637.5575272518529940842@vm0>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd8305fa-22f4-bd05-a318-ebc6c3a8ec72@redhat.com>
Date:   Fri, 11 Dec 2020 14:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <160769329840.1247637.5575272518529940842@vm0>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 14:28, Michael Roth wrote:
> Quoting Paolo Bonzini (2020-12-11 05:42:02)
>> On 11/12/20 02:27, Sean Christopherson wrote:
>>> Michael, please reply to all so that everyone can read along and so that the
>>> conversation gets recorded in the various mailing list archives.
>>>
>>> If you are replying all, then I think something funky is going on with AMD's
>>> mail servers, as I'm not getting your responses (I double checked SPAM), nor are
>>> they showing up on lore.
>> I think somebody else reported similar issues with AMD's mail servers.
> It looks like my messages did make their way to lore eventually:
> 
>    https://lore.kernel.org/patchwork/patch/1352128/

Ok, so maybe some graylisting.  If it fixes itself it's not a big deal.

Paolo

