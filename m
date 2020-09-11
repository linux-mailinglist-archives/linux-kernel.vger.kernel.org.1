Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C9C2665B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgIKRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:11:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726349AbgIKRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599844266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCrmqBxuZus33kxx8YL4Vlut+6tBeCTGNVK1vsj5srM=;
        b=ZEl9D8cLvt4UbfE0zb3b9i5gn7om9G+2QL6Q/hMzopB5Oi9BMi11JJLabpclkO3h5TA+wE
        qa2zi+MzgaEy0dMXnol/wYu5PojTnxOcg2CnTWLRD05PwapFXj2c53Et7M/NoLK74Wwwl8
        o0m/cSnarZCYFUsalBRA1klUxjQh+Fg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-HZ9rHBgaPl6AQYXZw5bQoA-1; Fri, 11 Sep 2020 13:11:05 -0400
X-MC-Unique: HZ9rHBgaPl6AQYXZw5bQoA-1
Received: by mail-wm1-f72.google.com with SMTP id m125so1168173wmm.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HCrmqBxuZus33kxx8YL4Vlut+6tBeCTGNVK1vsj5srM=;
        b=obpW3dFez0fS6/Zuar0B/3dmnIxKK7zM0q8wq/sDudop8S0dBS65zFNWJvVYx9iMO0
         ssEa24jYW8mKmNHMaOSuB66VeMx20O4TGHU/C1sck3SYfDL72+f0CcHEnu+DBU1jwop/
         rOGPk27ZdpasjJJ/xjXnWgfF1z4f+aCa2pzBkB0rh247hgrS0BvTx55cM1YZy9kCuokZ
         pbdjp/8n36q2baQAftHbnAFPkNQ/vw4tMT4B1tFMBSy06x1GlFZdjtfVWBizntXrCvZ2
         8c/WTPdXap4/QvnlaT9RdSut7Ix2JqaupEph3iIhuyruJGunoIlyKfys5jTxkFWYC/+2
         llCA==
X-Gm-Message-State: AOAM530E/6YwcInNOWt8naIKt1r/1NlCHkCy613/Ni3+QYXSM0coxDqH
        lIFX7SgzUa2QSUYYoBN1nbBJumWJGPw1p0+J9RzMcveUK4IWxbWe+h8dpV9Si6TOnIqGJyBI89y
        eeaf/iX6o2XRn/4pXAtI9i0R3
X-Received: by 2002:a1c:bb88:: with SMTP id l130mr3190587wmf.143.1599844263637;
        Fri, 11 Sep 2020 10:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvUUX2l3Kv2FNmVs54pq+VBq7jW8bPIJ3amyhahMsZdt1JqrCR3uD7SW9gyccRbS7G7MRVaA==
X-Received: by 2002:a1c:bb88:: with SMTP id l130mr3190558wmf.143.1599844263262;
        Fri, 11 Sep 2020 10:11:03 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id n14sm5443386wmi.33.2020.09.11.10.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:11:02 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix nested VMX controls MSRs
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200828085622.8365-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49f9a692-4218-33cf-2d29-0283cac2f1ac@redhat.com>
Date:   Fri, 11 Sep 2020 19:11:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828085622.8365-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/20 10:56, Chenyi Qiang wrote:
> The first three patches fix a issue for the nested VMX controls MSRs. The
> issue happens when I use QEMU to run nested VM. The VM_{ENTRY,
> EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL and VM_{ENTRY_LOAD, EXIT_CLEAR}_BNDCFGS
> in L1 MSR_IA32_VMX_TRUE_{ENTRY, EXIT}_CTLS MSR are always cleared
> regardless of whether it supports in L1. This is because QEMU gets the
> nested VMX MSRs from vmcs_config.nested_vmx_msrs which doesn't expose
> these two fields. Then, when QEMU initializes the features MSRs after
> SET_CPUID, it will override the nested VMX MSR values which has been
> updated according to guest CPUID during SET_CPUID. This patch series
> just expose the missing fields in nested VMX {ENTRY, EXIT} controls
> MSR and adds the support to update nested VMX MSRs after set_vmx_msrs.
> 
> The last two patches are a minor fix and cleanup.
> 
> Chenyi Qiang (5):
>   KVM: nVMX: Fix VMX controls MSRs setup when nested VMX enabled
>   KVM: nVMX: Verify the VMX controls MSRs with the global capability
>     when setting VMX MSRs
>   KVM: nVMX: Update VMX controls MSR according to guest CPUID after
>     setting VMX MSRs
>   KVM: nVMX: Fix the update value of nested load IA32_PERF_GLOBAL_CTRL
>     control
>   KVM: nVMX: Simplify the initialization of nested_vmx_msrs
> 
>  arch/x86/kvm/vmx/nested.c | 79 +++++++++++++++++++++++++++------------
>  arch/x86/kvm/vmx/vmx.c    |  9 +++--
>  2 files changed, 62 insertions(+), 26 deletions(-)
> 

Queued patch 1/4/5, thanks.

Paolo

