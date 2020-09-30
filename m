Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FAC27F0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbgI3Rjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbgI3Rjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:39:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601487582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZu2yzQOUkV+i1qfHrvNEBe2+2yFsnEQhQroRKDZ2nQ=;
        b=e5UpyoCLW91qZ7V7M1vmPGjMDkcppkneHH1exoZyC5Ohm1H0kKysuS548j1ab1l/kjjL6C
        Pj8U95ezXFdmsEalkiy7JUhAHrc1Hb1NbtQ4H/Y4EigLMx2wPYv1hVUJpF7C8pTrXe5WN3
        xgeScbIFCo63NbRYeobvtITteuo3B7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-AWJrqCbPMHyeWXHruygS3Q-1; Wed, 30 Sep 2020 13:39:40 -0400
X-MC-Unique: AWJrqCbPMHyeWXHruygS3Q-1
Received: by mail-wr1-f71.google.com with SMTP id a12so871958wrg.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZu2yzQOUkV+i1qfHrvNEBe2+2yFsnEQhQroRKDZ2nQ=;
        b=icp1lcVs/u7o8VbOwZpPgViiJ832YksjXdtMmFfAyVXrMHKxd6L/c+Im46xYhqdLSS
         pkui1Y5JE7+avFG69cye6CzPBcbyE4WKjCq92ow/TvFrnQ0Izgw70utTaio5K50UQwH/
         7NoQie01+O18zFcS+M6+AuOgzQ3SBFyLBQbuTr3st2qYB+hDOQ5TSa9suU70Y30rMC2w
         OUDNcE7+cicfAJRVDD+cyijrqCDWG8FdjUz0tgazI6ezDUY5otW607JP6erJeKTnd5jV
         93MmLVuDn3JxX21RjR50fGiFNo6sg9BTh9S9bqHo723hIIw1K6AFdLnp4/p2Q6k39Bst
         gpbA==
X-Gm-Message-State: AOAM531dxFPNt+ZyddvEqdB7DZme82RbO52DCLUKb8ASaBVMmvIQLHBe
        lzcGHOzRq0b7dckR7CYvhPxX923W0A5/m47MhdeJpg4z3UllX2Y2HEYGVMD8duVD8XT+uvkuxA9
        dVhtlqeZhnxPN8i90NNN37kt+
X-Received: by 2002:a05:600c:2252:: with SMTP id a18mr4483687wmm.154.1601487579702;
        Wed, 30 Sep 2020 10:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO2v6b1MLDbXuOGsIlDoiN82H14bkUhC2J/AKOCMVJMmYPj0XDIDRB5bjedoAROwucfpsoYA==
X-Received: by 2002:a05:600c:2252:: with SMTP id a18mr4483660wmm.154.1601487579513;
        Wed, 30 Sep 2020 10:39:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id o4sm4123220wrv.86.2020.09.30.10.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 10:39:38 -0700 (PDT)
Subject: Re: [PATCH 03/22] kvm: mmu: Init / Uninit the TDP MMU
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-4-bgardon@google.com>
 <20200930165734.GE32672@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2633cc07-f106-25ba-0ab9-d4a422aca171@redhat.com>
Date:   Wed, 30 Sep 2020 19:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930165734.GE32672@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 18:57, Sean Christopherson wrote:
>> +
>> +static bool __read_mostly tdp_mmu_enabled = true;
>> +module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
> This param should not exist until the TDP MMU is fully functional, e.g. running
> KVM against "kvm: mmu: Support zapping SPTEs in the TDP MMU" immediately hits a
> BUG() in the rmap code.  I haven't wrapped my head around the entire series to
> grok whether it make sense to incrementally enable the TDP MMU, but my gut says
> that's probably non-sensical.

No, it doesn't.  Whether to add the module parameter is kind of
secondary, but I agree it shouldn't be true---not even at the end of
this series, since fast page fault for example is not implemented yet.

Paolo

