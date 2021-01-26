Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAB304052
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405851AbhAZOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405910AbhAZO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611671279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2rkCrBfD5bDyHEtmODfflBbzJI4arxA1fFAqYtnYDM=;
        b=jSv7tTVizSLIaAJIf00Z1c8xTmZ2jl0i0azTuCnNQR1jGXP9j3ZmdZvqXNvnhVs6KtNpXb
        UPweVla/kcawclvogkz0Jnc/h0nJHJl6GWyjTxrFUWQLdr59Itc3QDRQRKmJ227Fkp/L1S
        yslkXf1CUWVU75EELRBTWVcQRWnlkXI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-53-N1UyxMv2J24kkv46ZuQ-1; Tue, 26 Jan 2021 09:27:58 -0500
X-MC-Unique: 53-N1UyxMv2J24kkv46ZuQ-1
Received: by mail-ej1-f70.google.com with SMTP id jg11so5006150ejc.23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S2rkCrBfD5bDyHEtmODfflBbzJI4arxA1fFAqYtnYDM=;
        b=haOr41eUpJOyg69O0DzsFUNAAvVKxgUXjcHJQOnsrQIK2diMxSXwHYpUiDvUvgsFRB
         hn6cJ4ApuxhHBDA1mkA662x5kTCEntvy3F+8dYXiJCkFEajhKQRAiMbUL9Mt2ysstahw
         BEvRB+S5CMlwK7rcNNnbWATXgfkOIys/Gh2fnkjtoBaAf5HrW4u3GGpyjhxFNoFPQG+Z
         9u6iQ4htzwPbYCHO535GToH0cYJ8I2gZvAUmgeXOv0ibQ34SytfPlCuJiULqlRqjO/AN
         1bo7dMx0R9oMXBkKgcyKosAEbiEghNh1yxRv7R5CADDHZ0krHMsJ/uE8Nfg4da1zdRuO
         Z9Cg==
X-Gm-Message-State: AOAM533W0qJqMCg4tni4nXZoF+G6tITYO9UXkNaU8vFp4FAhD8yjlvP2
        CeTUvU+mjZaT/5HnE1tET8XiyoWMih7F0bq9AHectd+Mh8pyeeyt+7Vj7cvjUlIU0Yh2bnuM1M7
        voUbxhyAk6sfJ2taY5/4zXRdT
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr4765436edw.314.1611671276829;
        Tue, 26 Jan 2021 06:27:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymiLts94MhJprL7ggs26FXkQnjVmTw7hH1In4bWJNPScrukS4CJH/wOJ+P5zaNXELDyYRxBg==
X-Received: by 2002:a05:6402:11d3:: with SMTP id j19mr4765416edw.314.1611671276648;
        Tue, 26 Jan 2021 06:27:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dj25sm12362694edb.5.2021.01.26.06.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:27:55 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-20-bgardon@google.com> <YAnUhCocizx97FWL@google.com>
 <YAnzB3Uwn3AVTXGN@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 19/24] kvm: x86/mmu: Protect tdp_mmu_pages with a lock
Message-ID: <335d27f7-0849-de37-f380-a5018c5c5535@redhat.com>
Date:   Tue, 26 Jan 2021 15:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAnzB3Uwn3AVTXGN@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 22:32, Sean Christopherson wrote:
> Coming back to this series, I wonder if the RCU approach is truly necessary to
> get the desired scalability.  If both zap_collapsible_sptes() and NX huge page
> recovery zap_only_  leaf SPTEs, then the only path that can actually unlink a
> shadow page while holding the lock for read is the page fault path that installs
> a huge page over an existing shadow page.
> 
> Assuming the above analysis is correct, I think it's worth exploring alternatives
> to using RCU to defer freeing the SP memory, e.g. promoting to a write lock in
> the specific case of overwriting a SP (though that may not exist for rwlocks),
> or maybe something entirely different?

You can do the deferred freeing with a short write-side critical section 
to ensure all readers have terminated.

If the bool argument to handle_disconnected_tdp_mmu_page is true(*), the 
pages would be added to an llist, instead of being freed immediately. 
At the end of a shared critical section you would do

	if (!llist_empty(&kvm->arch.tdp_mmu_disconnected_pages)) {
		struct llist_node *first;
		kvm_mmu_lock(kvm);
		first = __list_del_all(&kvm->arch.tdp_mmu_disconnected_pages);
		kvm_mmu_unlock(kvm);

		/*
		 * All vCPUs have already stopped using the pages when
		 * their TLBs were flushed.  The exclusive critical
		 * section above means that there can be no readers
		 * either.
		 */
		tdp_mmu_free_disconnected_pages(first);
	}

So this is still deferred reclamation, but it's done by one of the vCPUs 
rather than a worker RCU thread.  This would replace patches 11/12/13 
and probably would be implemented after patch 18.

Paolo

(*) this idea is what prompted the comment about s/atomic/shared/

