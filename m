Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E6303EED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404763AbhAZNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392035AbhAZNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611668264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5j8pQllFKQxPrqWZ1anCyJsDg/+zpfGgGPYxYabCaU8=;
        b=VksebxE3q0WtHGsRmLNQ89MXTSCaA9C/+etCj9dQtwfXpENOc5Zhkh1YEitGC+jImbNa5Y
        SjA0odRfYatgQ005Um3Hb9Pqt60nMXF8YnI3B+nU0dAzu3kYVPMvLFDFMhW55u/tBROGGU
        aL8ZRloCT5EZJA7eq0Akizl1zyRMAR0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-AAgSv0ROOva9cgxjAvQV5g-1; Tue, 26 Jan 2021 08:37:43 -0500
X-MC-Unique: AAgSv0ROOva9cgxjAvQV5g-1
Received: by mail-ej1-f69.google.com with SMTP id h18so4935445ejx.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5j8pQllFKQxPrqWZ1anCyJsDg/+zpfGgGPYxYabCaU8=;
        b=ZgnsdA2joyDnSd+YHD4yaJvV1tFUoihWZsIxWec06SSe92Db8RmswfZ/WtkcBwcBlm
         z+/jBlN5YeTqs2luRpSVwmzKEQ+1re+YGb7yeKu7qS0uIqkHCltmf9l954rZrqse2/Aj
         7JV9lUKiGUXxyTJx5h31HCjSlt2lRC7owz+Hk1KN6ZUtwWPL6Q7Hn2Q9CnE8J+OX4TWA
         UZMcPoqvBl4lYpGN2TXowj+0FVFcbTNW1r4MYiuF/SpvnpPKcg5WcVdMqj+6v7mrTkFs
         mWgcE+1v+7IBbH8AUFfF6r0mPnDP4W6YmFBsfXYnYsDzJXb1Y1jtVQRbMIA6pVt0/yuW
         SxjQ==
X-Gm-Message-State: AOAM531xJxPfcqbwjeNR6V8UG9KURxl+RTDXCL59i2wOJyUvxPyjegmG
        jdJg04/eBcXJn/Rk+FrqGlmwS3DaXp/cptQmkkp70uCTFxd8eBO9c8Vnq2GvKWmcLnCaUX6Irei
        D3ZO+CbPeqsGfL14QeKJDW/9I
X-Received: by 2002:a17:906:dbf2:: with SMTP id yd18mr3405945ejb.45.1611668261801;
        Tue, 26 Jan 2021 05:37:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgOSwhx7PScb9UCOX6vbEBbq/P7OBx6h3Jx7iIjwk1PADyZsfXUMbn6cWGh/XzSO50XoWU7w==
X-Received: by 2002:a17:906:dbf2:: with SMTP id yd18mr3405938ejb.45.1611668261677;
        Tue, 26 Jan 2021 05:37:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q22sm9747892ejx.3.2021.01.26.05.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 05:37:40 -0800 (PST)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-25-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 24/24] kvm: x86/mmu: Allow parallel page faults for the
 TDP MMU
Message-ID: <8079ca49-d9fe-94ae-9e6c-ebe6e8e1035d@redhat.com>
Date:   Tue, 26 Jan 2021 14:37:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112181041.356734-25-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 19:10, Ben Gardon wrote:
> +	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
> +		kvm_mmu_lock_shared(vcpu->kvm);
> +	else
> +		kvm_mmu_lock(vcpu->kvm);

Perhaps the better API would be kvm_mmu_lock/unlock_root; not exposing 
kvm_mmu_lock/unlock_shared and kvm_mmu_lock/unlock_exclusive at all, 
just like you use rwlock_needbreak directly in kvm_mmu_lock_needbreak.

Paolo

