Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9663627F60D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgI3XfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730624AbgI3XfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:35:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601508899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlnOJSN7jtIyA5UuOYpzxC90dJDluDPDVDlZFnKVX1I=;
        b=PdqGGU6+tI+HYJDDOx2pRPKt9xAo2QrWSPSZlqdaM/9VrqxCrbzXoALXytaXsdCvI3iBrI
        X+3OYlAsbSRTSzmx81BeaMMTy5fBJARJvUtgynTTH38sSHLXF5UXzVi2UJQvvKB9DYCgDx
        /rUjZq8onEbVt7SQ/b/i3S5zrwQ6Q3E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375--cTTe3x2N46Gjl9ZjOq4Pw-1; Wed, 30 Sep 2020 19:34:57 -0400
X-MC-Unique: -cTTe3x2N46Gjl9ZjOq4Pw-1
Received: by mail-wr1-f69.google.com with SMTP id d9so1254184wrv.16
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wlnOJSN7jtIyA5UuOYpzxC90dJDluDPDVDlZFnKVX1I=;
        b=Cuu+Am3n9bqNpC7DpAQLDx6kTkv58kK3IXtF4njfAU5726z+ohVC/yM4eqJlx7Mfej
         Okd6n9d6anu2MkohshOYfvfx9ZyD7/u/Oa+YIa6vuDuyJugpywjmVJvyckmybLkbU8el
         3aaHSJOwv7nwPpPlCjYvfwj/akc72VANuhmAvT+q41PqJnMV01jwFHK0c2V3BPGO42F5
         UeBNMEIqViCl/RyxNslA1jaHG+QbkoTrvMz8EOZvn+E8Uk6nu1y73n5Uf0q2e+mq5a18
         pNs37HzOC7UWDahoKI4ONsCXZmCvucYTpAnNmFs/+UTlNLIvtalDSaryxlKINpc6WX/w
         siXw==
X-Gm-Message-State: AOAM530wrH1OFYWR7YHXg8y4Oybtiy+WV9/IA/V54GCY0KPksA+9X0T+
        AesZMQPfSHKBprz4N2+2F9jfDkTEOTLyUUftcddlAjdFtWhFtuBebqSY/yZx3kv+ix3yfu0izRS
        U0kTP31dhEh/6sO2q7RBaAinO
X-Received: by 2002:a1c:c906:: with SMTP id f6mr5669770wmb.9.1601508895756;
        Wed, 30 Sep 2020 16:34:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKn6uKUCblewMLqqfaHFaoCFp4t4CwvbbE55rUiCAz+ic2k4Fli2bDYK8jRAyxLTah9/YmTA==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr5669750wmb.9.1601508895573;
        Wed, 30 Sep 2020 16:34:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id f23sm1425248wmc.3.2020.09.30.16.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 16:34:55 -0700 (PDT)
Subject: Re: [PATCH 02/22] kvm: mmu: Introduce tdp_iter
To:     Eric van Tassell <evantass@amd.com>,
        Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-3-bgardon@google.com>
 <4a74aafe-9613-4bf2-47a1-cad0aad34323@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d43d29f-d29c-3dd7-1709-4414f34d27da@redhat.com>
Date:   Thu, 1 Oct 2020 01:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4a74aafe-9613-4bf2-47a1-cad0aad34323@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 01:20, Eric van Tassell wrote:
>>
>> +int is_shadow_present_pte(u64 pte)
>>   {
>>       return (pte != 0) && !is_mmio_spte(pte);
> From <Figure 28-1: Formats of EPTP and EPT Paging-Structure Entries" of
> the manual I don't have at my fingertips right now, I believe you should
> only check the low 3 bits(mask = 0x7). Since the upper bits are ignored,
> might that not mean they're not guaranteed to be 0?

No, this a property of the KVM MMU (and how it builds its PTEs) rather
than the hardware present check.

Paolo

