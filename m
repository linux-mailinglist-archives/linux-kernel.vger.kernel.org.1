Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3F2746CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgIVQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600792760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xBbtaESBNONtl2sEaNAAY6yvG0vlYmdzD4boWs1/M0=;
        b=L6Qp5xTl2GkuyCK61UFbRgZt9AO47xQESnFQD3mWlum3nnilSucsyqdXT6qRdLt/mNVYj5
        wgdR+vr4/YJkmoYcpU3bg8l/unuj1i6pLomYt7P2jqbzYb2PZoT3acon1XTVKwAgSMUxDm
        b5rl1y8+zEdgxClemgte/YEXKh5zOKg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-aQQRvrsYMxOFXp_YgO-k1A-1; Tue, 22 Sep 2020 12:39:19 -0400
X-MC-Unique: aQQRvrsYMxOFXp_YgO-k1A-1
Received: by mail-wr1-f70.google.com with SMTP id b2so1481953wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9xBbtaESBNONtl2sEaNAAY6yvG0vlYmdzD4boWs1/M0=;
        b=HeB6nvHc+El8jmD0sTXA750S/2rIKuiBMbNqpbEVvmX7ZxpcDGRQG81udN6bpZdylh
         pV0VqmQ7nmdSXFodz7k7UFwbVDUsTRM/QCv0uN6wUOnD1VOjRmX1BsgESBYLVgltSiGH
         bdOM3gCjabci9+pfPFfNMp7OBS4p1RtP5EX7RFZXzHidF9yvbm5BbcpAgtxonvLQMsWg
         IDdsqJU25XTv5tZmgPB1xbJVjL5fabDEDkuh/YgmyFUjrm9CHhHQRfUUEsB31btBeIc/
         7uIo+oQEVSIK3PHHUTnxKYtnnmlp4izUBA6VGdSIl20djKxXjFXXN2Ax7tJ5IAaQAFma
         hHLw==
X-Gm-Message-State: AOAM531rgKK01Ec9c/eS0j3wVECtaEQCcojXLDH336l9yK9aXA8UI/57
        uH/SqfRzyPZFPjzXMwHV2mQJD7PtL3pDW+ccZ0pLK8AWkw235RbbmJr7lJOUqMs15zbBU4vxiu2
        YaOS/BKgAAfhi2UFbBrZMH9sl
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr6311136wrw.348.1600792757923;
        Tue, 22 Sep 2020 09:39:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy55yy1otoo4eP/r/wzYIY/yD2fT568vjN8DvRtJ7I7RnyRbSpv6lMckPNIRrBW7YhJr2SF1Q==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr6311107wrw.348.1600792757673;
        Tue, 22 Sep 2020 09:39:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id r15sm4982205wmn.24.2020.09.22.09.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 09:39:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] KVM: x86: fix MSR_IA32_TSC read for nested
 migration
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200921103805.9102-1-mlevitsk@redhat.com>
 <20200921103805.9102-2-mlevitsk@redhat.com>
 <20200921162326.GB23989@linux.intel.com>
 <de9411ce-aa83-77c8-b2ae-a3873250a0b1@redhat.com>
 <7db1383cc9d40f76a02076c3b86cf832fd7463cc.camel@redhat.com>
 <5d19bbf5bcc4975e4ac6c4aef8b92b4a1ed4bc16.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0821152-19b7-9d46-aefd-759f462902b7@redhat.com>
Date:   Tue, 22 Sep 2020 18:39:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5d19bbf5bcc4975e4ac6c4aef8b92b4a1ed4bc16.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/20 17:39, Maxim Levitsky wrote:
>>> I'll talk to Maxim and see if he can work on the kvmclock migration stuff.
> 
> We talked about this on IRC and now I am also convinced that we should implement
> proper TSC migration instead, so I guess I'll drop this patch and I will implement it.
> 
> Last few weeks I was digging through all the timing code, and I mostly understand it
> so it shouldn't take me much time to implement it.
> 
> There is hope that this will make nested migration fully stable since, with this patch,
> it still sometimes hangs. While on my AMD machine it takes about half a day of migration
> cycles to reproduce this, on my Intel's laptop even with this patch I can hang the nested
> guest after 10-20 cycles. The symptoms look very similar to the issue that this patch
> tried to fix.
>  
> Maybe we should keep the *comment* I added to document this funny TSC read behavior. 
> When I implement the whole thing, maybe I add a comment only version of this patch
> for that.

Sure, that's a good idea.

Paolo

