Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE47829516C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503418AbgJURUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2443297AbgJURUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603300822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyI41PRL+WxaH1Fvui6MNjfCggVmcgscFdVMrkl76BI=;
        b=NbzxymfBjks/u+gYqxDl7UPPxljSfaKeTurO7AyQmuUx1fhjcTApLvkBKB0ih2GwFXYmgn
        JVoCvJWcrbGAjQx77AkAcpL5l2gHkdJkkAqcLkDD3chQ+DpkN9J7FkcIV3XAldCTW0OGX2
        Bbo9bWHB9TMsJVIgOKwUGB5F62nDbLo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-cdDXn1EHO6aaCd3xAzwA9g-1; Wed, 21 Oct 2020 13:20:18 -0400
X-MC-Unique: cdDXn1EHO6aaCd3xAzwA9g-1
Received: by mail-wm1-f69.google.com with SMTP id p17so1811460wmi.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyI41PRL+WxaH1Fvui6MNjfCggVmcgscFdVMrkl76BI=;
        b=L0nZJR/YjeGWFUh6vvBEN3oqO6b0+noTX4p+vwCWmQDSRYn/E0NmxP3plgMCIXjtom
         vPCsWbQM+uTkdYyohHGsCpbFmh2AzXLxDiOnEfC+7unpJA7/23F9D2xhjWBgZXpex8mW
         8Kz6EQSfikBQwk9OQSIQccDBGINU5N5b4DMLSvc6TMZ+v/G2DZ94ZbJq1L30Byuzewty
         cX5IOopd8CPXoP1Mg1rUgT55MLcJ6kTWVBVT5luHWjTBLbSR1IJ7eVryXun6+ELj7odT
         85JEXhQztR9n7plfvS3tIc+mxICn9fIpR3Qfys33J9zJJu3vDrqbYQtdRXbF2T/KYJDF
         IT0g==
X-Gm-Message-State: AOAM530SRlk/XVFhNAlMGE7wJB3weqhcj55+JbL3FKp3pz9ksdTLGklZ
        9qG7gT10ePKl2CLBW30sZje9DFjDEufwI0GgUnGGj9OjUZlU+Te7Gw/trGAFUfKR/FMGT8VHARR
        QPXSaMXn7X6fGXmHouUjxlpya
X-Received: by 2002:adf:8b15:: with SMTP id n21mr6165906wra.313.1603300817387;
        Wed, 21 Oct 2020 10:20:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHrzCaWtJG3CGGML8HAUgVZrIalLo2t+pU+pjNP9Ao5LODt12Kp4C+mRMglqdpQWXgae4p9w==
X-Received: by 2002:adf:8b15:: with SMTP id n21mr6165883wra.313.1603300817122;
        Wed, 21 Oct 2020 10:20:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s185sm4402213wmf.3.2020.10.21.10.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 10:20:16 -0700 (PDT)
Subject: Re: [PATCH v2 07/20] kvm: x86/mmu: Support zapping SPTEs in the TDP
 MMU
To:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
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
References: <20201014182700.2888246-1-bgardon@google.com>
 <20201014182700.2888246-8-bgardon@google.com>
 <20201021150225.2eeriqlffqnsm4b3@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6985f630-3b2a-75f5-5b55-bd76cf32f20b@redhat.com>
Date:   Wed, 21 Oct 2020 19:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021150225.2eeriqlffqnsm4b3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/20 17:02, Yu Zhang wrote:
>>  void kvm_tdp_mmu_free_root(struct kvm *kvm, struct kvm_mmu_page *root)
>>  {
>> +	gfn_t max_gfn = 1ULL << (boot_cpu_data.x86_phys_bits - PAGE_SHIFT);
>> +
> boot_cpu_data.x86_phys_bits is the host address width. Value of the guest's
> may vary. So maybe we should just traverse the memslots and zap the gfn ranges
> in each of them?
> 

It must be smaller than the host value for two-dimensional paging, though.

Paolo

