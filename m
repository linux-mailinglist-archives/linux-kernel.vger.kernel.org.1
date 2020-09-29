Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459DC27D225
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgI2PIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728953AbgI2PIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601392079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATkTYcE6abvtZsnqbXxZ3DqrF8xItuHfBg8J1L8+iQ0=;
        b=KbLfTZUttPjHoft9cPlBzU64BNvPXx1rfjNz6H1WpYmZ3M+Ti9MNelYfzcXVept0XIG3pV
        2AFeegiK/sMYwTYvQv8g6FmtVjxFohB1TTIRkU0c5XLeidboO5FgGEo1mtrzVln6svzvAR
        X5n1wk0Xp4TDm1uw5RmZ2DGu+bwr4EE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-FoavBgmTMqa-QL2WW2iPJA-1; Tue, 29 Sep 2020 11:07:57 -0400
X-MC-Unique: FoavBgmTMqa-QL2WW2iPJA-1
Received: by mail-wm1-f69.google.com with SMTP id y18so1833805wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 08:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ATkTYcE6abvtZsnqbXxZ3DqrF8xItuHfBg8J1L8+iQ0=;
        b=Zd4xMCQpoT6jgZZojX4VEbv7Xlz3vxAZaeWg7QY7gKw6ZJKknEUZdDfEhEqlsQYpGn
         LHTHpXKfhxZoebupO4pHakwil3QsW0U+DAJzKXK1/aV/4jkQJhgWY2i38dd0ipOIuCoA
         hIHSlJvLuar4zp258N2+6npPnTw4brba4erYpxFeF+LxY7AlFB7sDbfuqY+EPRhmGw27
         pYios+l6lJQVtEyfshpkbXbBK5JYItmJ2SMb9M88XcEgI78R11hjX1KJhV1k3HE8Rxl0
         NtH1TwNtHqnNDoSxNN0lvvwGExQDentO6BbNxYq3fdtoLCVENLlN1M4YRXMSRPG15Jjk
         n9/g==
X-Gm-Message-State: AOAM531BmQOGxy2SaDVGdZrJ9tKb0jGiKEdcvVttXxg9D/MN39ZTlWWM
        CodnhZlFVny636HAdNV9HEYEpO7aj5QehMuiyvb0JCQO3tDqj+hkkDpYSvfFs0E2npsowJA7eYE
        EcX+AAA4RR/CB0SUEubx4MCQZ
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr5016158wma.111.1601392075955;
        Tue, 29 Sep 2020 08:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya48B0QW3dph1tb9JdX9nlLaz1scgdROIsHArpeP7pTdOKyw+sgYuIwp/ksbF821eJ3zw6Ww==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr5016134wma.111.1601392075676;
        Tue, 29 Sep 2020 08:07:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6? ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
        by smtp.gmail.com with ESMTPSA id 70sm6347471wmb.41.2020.09.29.08.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 08:07:54 -0700 (PDT)
Subject: Re: [PATCH 17/22] kvm: mmu: Support dirty logging for the TDP MMU
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
 <20200925212302.3979661-18-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aabb139e-6801-cd45-bf16-f698ce8e66e2@redhat.com>
Date:   Tue, 29 Sep 2020 17:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-18-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> +	for_each_tdp_pte_root(iter, root, start, end) {
> +iteration_start:
> +		if (!is_shadow_present_pte(iter.old_spte))
> +			continue;
> +
> +		/*
> +		 * If this entry points to a page of 4K entries, and 4k entries
> +		 * should be skipped, skip the whole page. If the non-leaf
> +		 * entry is at a higher level, move on to the next,
> +		 * (lower level) entry.
> +		 */
> +		if (!is_last_spte(iter.old_spte, iter.level)) {
> +			if (skip_4k && iter.level == PG_LEVEL_2M) {
> +				tdp_iter_next_no_step_down(&iter);
> +				if (iter.valid && iter.gfn >= end)
> +					goto iteration_start;
> +				else
> +					break;

The iteration_start label confuses me mightily. :)  That would be a case
where iter.gfn >= end (so for_each_tdp_pte_root would exit) but you want
to proceed anyway with the gfn that was found by
tdp_iter_next_no_step_down.  Are you sure you didn't mean

	if (iter.valid && iter.gfn < end)
		goto iteration_start;
	else
		break;

because that would make much more sense: basically a "continue" that
skips the tdp_iter_next.  With the min_level change I suggested no
Friday, it would become something like this:

        for_each_tdp_pte_root_level(iter, root, start, end, min_level) {
                if (!is_shadow_present_pte(iter.old_spte) ||
                    !is_last_spte(iter.old_spte, iter.level))
                        continue;

                new_spte = iter.old_spte & ~PT_WRITABLE_MASK;

		*iter.sptep = new_spte;
                handle_change_spte(kvm, as_id, iter.gfn, iter.old_spte,
				   new_spte, iter.level);

                spte_set = true;
                tdp_mmu_iter_cond_resched(kvm, &iter);
        }

which is all nice and understandable.

Also, related to this function, why ignore the return value of
tdp_mmu_iter_cond_resched?  It does makes sense to assign spte_set =
true since, just like in kvm_mmu_slot_largepage_remove_write_access's
instance of slot_handle_large_level, you don't even need to flush on
cond_resched.  However, in order to do that you would have to add some
kind of "bool flush_on_resched" argument to tdp_mmu_iter_cond_resched,
or have two separate functions tdp_mmu_iter_cond_{flush_and_,}resched.

The same is true of clear_dirty_gfn_range and set_dirty_gfn_range.

Paolo

