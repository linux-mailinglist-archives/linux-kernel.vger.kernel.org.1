Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79F2795CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgIZBEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729495AbgIZBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:04:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601082293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+AwseT+/GGS6sFSPoMzAPTCoGWM/VtfjGcVl9z21PIw=;
        b=IPtmVDhIMIZs62Iyyfw7A6SZKrn/KPYqapUEpL0B1xvTxXZ9caPKF2j7Xlh4HWqL4oOqKS
        Ms8kHGcMvswUBSlCqpHVq1/SSozAIjPm+zN9aYvW/OveN5SVQfDY8moYLIeGE5GdC5nXiU
        SXAkwl3Qo7CQSdlFu5lbERxyBYnQ/+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-LgAhFLggM1Go3ZYrYASEMw-1; Fri, 25 Sep 2020 21:04:51 -0400
X-MC-Unique: LgAhFLggM1Go3ZYrYASEMw-1
Received: by mail-wm1-f69.google.com with SMTP id m19so192254wmg.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+AwseT+/GGS6sFSPoMzAPTCoGWM/VtfjGcVl9z21PIw=;
        b=oJKbIBsBK+App8B73fBfYuHo/cI6Ug1iR1klPNEOSBrzTyhHfbmmoT1dZgzijSZrvK
         DYiqT36R89xkyY7FLeL0roM+GLVswnuSnjrCZusuheBxERU/fJ76ZIonCnSbHsWNlPXT
         DE8gu0J9XFYBNNOfkTAE9oMjwqdh+nzRGFiQVIQXEBI+tXxZ5pd1WIo38xzOMm02w4NY
         P8NP55lxatUgzpq60631rlzkbMTb2zdl0cNcuYcmb/0sdengZg0vNMeb2BAhNkpss53R
         2KY1ihcPRHuY3IZK9zRXldxHyV0bOpLIeLpSry9P5snECnzW7V9YJ2UcwtxUTpmTfrei
         QhuA==
X-Gm-Message-State: AOAM531Fh+CuQR2VLzM9qqITcEErfixDDJO/lFw7TXbDGRWcX10m1Buo
        AH38rR93DOUKDUZ4o+BqqVz2YTAyUtv2N3ZxaQnM2uovrW3ihqI6kfJy24HWbhrpNDTSNgZ+6y8
        oSTEV70ydrSUbjqxPGG6PBO/a
X-Received: by 2002:a7b:c345:: with SMTP id l5mr216214wmj.123.1601082289799;
        Fri, 25 Sep 2020 18:04:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4QnWTyDg1SsX25sriM+6EtXy0WYajzU3GY2hw5oItwHCJjibASEiaeipogqWD2RoLdluZlw==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr216191wmj.123.1601082289589;
        Fri, 25 Sep 2020 18:04:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id i3sm4582866wrs.4.2020.09.25.18.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 18:04:48 -0700 (PDT)
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
Message-ID: <6990180c-f99c-3f1d-ef6a-57e37a9999d2@redhat.com>
Date:   Sat, 26 Sep 2020 03:04:47 +0200
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
>  				start_level, KVM_MAX_HUGEPAGE_LEVEL, false);
> +	if (kvm->arch.tdp_mmu_enabled)
> +		flush = kvm_tdp_mmu_wrprot_slot(kvm, memslot, false) || flush;
>  	spin_unlock(&kvm->mmu_lock);
>  

In fact you can just pass down the end-level KVM_MAX_HUGEPAGE_LEVEL or
PGLEVEL_4K here to kvm_tdp_mmu_wrprot_slot and from there to
wrprot_gfn_range.

> 
> +		/*
> +		 * Take a reference on the root so that it cannot be freed if
> +		 * this thread releases the MMU lock and yields in this loop.
> +		 */
> +		get_tdp_mmu_root(kvm, root);
> +
> +		spte_set = wrprot_gfn_range(kvm, root, slot->base_gfn,
> +				slot->base_gfn + slot->npages, skip_4k) ||
> +			   spte_set;
> +
> +		put_tdp_mmu_root(kvm, root);


Generalyl using "|=" is the more common idiom in mmu.c.

> +static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
> +			   gfn_t start, gfn_t end)
> ...
> +		__handle_changed_spte(kvm, as_id, iter.gfn, iter.old_spte,
> +				      new_spte, iter.level);
> +		handle_changed_spte_acc_track(iter.old_spte, new_spte,
> +					      iter.level);

Is it worth not calling handle_changed_spte?  handle_changed_spte_dlog
obviously will never fire but duplicating the code is a bit ugly.

I guess this patch is the first one that really gives the "feeling" of
what the data structures look like.  The main difference with the shadow
MMU is that you have the tdp_iter instead of the callback-based code of
slot_handle_level_range, but otherwise it's not hard to follow one if
you know the other.  Reorganizing the code so that mmu.c is little more
than a wrapper around the two will help as well in this respect.

Paolo

