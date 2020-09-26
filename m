Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9912795E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgIZBPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729912AbgIZBPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:15:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601082899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9t91khu5vk6R18LNGpi1kxYeJVbZeFj+fLbOp41La0I=;
        b=clFTypVyxcTZtc3dC3To4ywgK/dl2yWS05kvL9wufsvjN/uthI4eXsdo+/of8FMb6YLGhR
        iE83x4+qyzkHM9boGBZWL6KnweLY2Hcyfsp5UcS6lzppWJeTPAWWzPar32BN/v6Wx8k4+t
        7/DKmzSeEA73fd0ot48yyG76EiQK2lI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-qAge1mPPMpiBKRNPzx9Mgw-1; Fri, 25 Sep 2020 21:14:57 -0400
X-MC-Unique: qAge1mPPMpiBKRNPzx9Mgw-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1779323wrv.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9t91khu5vk6R18LNGpi1kxYeJVbZeFj+fLbOp41La0I=;
        b=Sjf/yy32BlJUVh2pqfyqBTo5vqgjgauM7fZe6diTh7FgHNy10WaWtwJO0e5rOLhqpi
         DEeUtvNQEO6Tcw3cTReSP2EiwMF2nICE57Q1A3AaOEiNsl0Btw55NryiIiQp9sUuh2Pv
         YG+urFBYBTdPejLKsU7YRrYkcBSjP4zi570RwjhmwcbksZ1nn6iaQibSQxO9qcVGM/K7
         JgQWd8GFPVxf62z27Rsoiv7nbz38y35etna4Cqmq0Jn2hEFTo24qkkRz1b1CaPC0iy68
         h+6fHY1Aj/zrS1uEmPQGJWmJ2GH0M+R8v/wtfqrP98vfIcrR8V9pXpE+5a6gs602hJIy
         nH/Q==
X-Gm-Message-State: AOAM531F3LQuo/7mKkK/CEqDq8wCIHtFWks+nQQ1metvarWd0aEhw8xJ
        LgASlrCOet9jCpq4wSCKJ/2eHh+cyS5Znvn9uiMZpmArz9VpJovUssyhZ083PpWMTrTGRqrYN7K
        QxsvoB8WnXWffQJTjmvhdjgFX
X-Received: by 2002:a5d:568d:: with SMTP id f13mr6997067wrv.303.1601082896780;
        Fri, 25 Sep 2020 18:14:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDWq9bI57HwJozrRwYYvXyr2jmAFd4opRR6yOqDR5DFbCSCdevp1w/4eWjfo8bIhIjq2HJ9w==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr6997045wrv.303.1601082896563;
        Fri, 25 Sep 2020 18:14:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id v204sm789831wmg.20.2020.09.25.18.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 18:14:55 -0700 (PDT)
Subject: Re: [PATCH 20/22] kvm: mmu: NX largepage recovery for TDP MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
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
 <20200925212302.3979661-21-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa7752b0-d2d2-f387-602f-fbf3f0edf450@redhat.com>
Date:   Sat, 26 Sep 2020 03:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-21-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:23, Ben Gardon wrote:
> +
> +	if (!kvm->arch.tdp_mmu_enabled)
> +		return err;
> +
> +	err = kvm_vm_create_worker_thread(kvm, kvm_nx_lpage_recovery_worker, 1,
> +			"kvm-nx-lpage-tdp-mmu-recovery",
> +			&kvm->arch.nx_lpage_tdp_mmu_recovery_thread);

Any reason to have two threads?

Paolo

