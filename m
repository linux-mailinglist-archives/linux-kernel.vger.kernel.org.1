Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1C2951EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503824AbgJUSA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391710AbgJUSA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603303256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbxpcoafqvR5Wfx4mp32Hf3bB+wCJpwzD7mR5FoCQJI=;
        b=G8wFZzoPayRvXDqrOM/JaUYGXqZLh7RJeMS/Q5X7vT/jfMAkl8moPTqhETAFSAbfGcxStG
        5vVzWfTjjs78FAf7oQmnE/siYknzpXdfKQQj50tZlFQt9sgUmxcXDIkmBKfqSwmqyovd+4
        B2fD3vgvf0OmJVKVQQNGbSS1XdQ24mo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-mqc0cB6oOtakamufBfxBwA-1; Wed, 21 Oct 2020 14:00:54 -0400
X-MC-Unique: mqc0cB6oOtakamufBfxBwA-1
Received: by mail-wr1-f72.google.com with SMTP id f11so2993241wro.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbxpcoafqvR5Wfx4mp32Hf3bB+wCJpwzD7mR5FoCQJI=;
        b=TNh6rNzb1BjB3BNGE6CcoRRlJgL8xKG72sltupstFSj8TTDT25Se5rqoZvdvaQadpM
         m4xP5V7dTh+hnXjvMZIMkF+Rjs00rrSVMlUbBkJUBVsXT+vIkFahoGkrevCCCJR5ENZ8
         kuJ8Fys+oks0dMe5soDvzBESyf9W5XQrHrSI+rcM5OsPp0zR607X+keky+ZxzjjLnSBf
         jA9Zv+WNw9YDPVrmyMggnPARf2pfckKf9QVIyQNjflTrKM/bUAY+OOGfUih0k3/ur8zQ
         Bi7cLBLdFvkqerUyZ+eax7+0WTIRTtCNhzlnZS8sWZAXGrcg4PVG0Qh07Mr3TVGXQLkp
         rNHg==
X-Gm-Message-State: AOAM532vVKlKnPnobChb9TRjbs2sbQ7LH+xys5/Pd4ugjBJxvlSpuptd
        uYnd/r7ND4i8S8ik5K4yuZqYSlCOA5TrpD+GbgTJr0j7BGgJBmInAjik0LYNl+wVEQBZO3qeyZ1
        7JFvQYmM402+qgtQnMdQkH97k
X-Received: by 2002:a1c:a3c2:: with SMTP id m185mr4719995wme.161.1603303253479;
        Wed, 21 Oct 2020 11:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL0unEWvDAgPUJo4G6dpG5YcS8xS5VuaGwHlELD4qz/kk02Zk6nMzy2q6fnCIxHQn2tg1R6Q==
X-Received: by 2002:a1c:a3c2:: with SMTP id m185mr4719960wme.161.1603303253238;
        Wed, 21 Oct 2020 11:00:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f17sm4978983wme.22.2020.10.21.11.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 11:00:49 -0700 (PDT)
Subject: Re: [PATCH v2 07/20] kvm: x86/mmu: Support zapping SPTEs in the TDP
 MMU
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Cannon Matthews <cannonmatthews@google.com>,
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
 <6985f630-3b2a-75f5-5b55-bd76cf32f20b@redhat.com>
 <20201021172409.aids3y2mlyx776lx@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f2e00fe-4f30-88d3-e345-089f1afc4fb9@redhat.com>
Date:   Wed, 21 Oct 2020 20:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021172409.aids3y2mlyx776lx@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/20 19:24, Yu Zhang wrote:
> On Wed, Oct 21, 2020 at 07:20:15PM +0200, Paolo Bonzini wrote:
>> On 21/10/20 17:02, Yu Zhang wrote:
>>>>  void kvm_tdp_mmu_free_root(struct kvm *kvm, struct kvm_mmu_page *root)
>>>>  {
>>>> +	gfn_t max_gfn = 1ULL << (boot_cpu_data.x86_phys_bits - PAGE_SHIFT);
>>>> +
>>> boot_cpu_data.x86_phys_bits is the host address width. Value of the guest's
>>> may vary. So maybe we should just traverse the memslots and zap the gfn ranges
>>> in each of them?
>>>
>>
>> It must be smaller than the host value for two-dimensional paging, though.
> 
> Yes. And using boot_cpu_data.x86_phys_bits works, but won't it be somewhat
> overkilling? E.g. for a host with 46 bits and a guest with 39 bits width?

It would go quickly through extra memory space because the PML4E entries
above the first would be empty.  So it's just 511 comparisons.

Paolo

