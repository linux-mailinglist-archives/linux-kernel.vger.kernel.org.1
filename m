Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660DF279573
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgIZAPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725272AbgIZAPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:15:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601079303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMsu9Cf7UyAelokyn8g8ZGbGX3wAMlHQf3WPi/7a2fw=;
        b=atKI8RunUgxjP0Om8IkKHMY/CuIrn8vr2GYUuckNp0Yaixwgai0xvRGbdopY6YuKo3TUQq
        gplQKCJl7MaQMziRQX7AUfJpZveKUTl1/8scob0jEy6a5rYodn4rSgq5Dju1jNG4Zqrgj6
        CWp0NuJEVVLRGlNzBjcueuvhQIBZGUU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-V4OS4TMnNkaQfCc6SyXOLA-1; Fri, 25 Sep 2020 20:15:01 -0400
X-MC-Unique: V4OS4TMnNkaQfCc6SyXOLA-1
Received: by mail-wr1-f72.google.com with SMTP id j7so1718807wro.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMsu9Cf7UyAelokyn8g8ZGbGX3wAMlHQf3WPi/7a2fw=;
        b=Y3ZXpAameDrU8CAM3+Y254t+CVpszsUDNuQLGSRpB5kKQH0IX69e9xit02zx2GQEBj
         O7zfwNBdTlM80S9mpg1SEFvSpnquU9tSiLBSjxBLKmKQXBKigNhdcW1O/Jdzy5JhOOk+
         caixY7ffn7ziimf5KzhucdaPHR766wgMivA4JarJyqHCWzJZLGZx2umgIqGFmT7WWW4h
         jyvP3Vk6ddE+iMGHzdefP2BgP3s5lFS8sQCla4k8qmBltE5bj6Wi4h3YZp6HPk4gRFAv
         znMvAiGVueicaSWQfUXDiQMq87iJqbHWrZSnDg5LGDNfl1QcPvoimIDCqzGNc1E5z352
         BGXw==
X-Gm-Message-State: AOAM5320HS6s8GbA332bhoqcvv5oIP1vzb1DP8e63t7nqQ2PvnHwPJCB
        66wMla1CfFTuenseEHEM6L9BJ0UvSV4ouYhXaVcFYzp4lxraTVwzVjckjQiz2loWN/DrsdrLvKM
        w+AoJoy/ABNuogSIYXduto44I
X-Received: by 2002:adf:9c93:: with SMTP id d19mr7025296wre.275.1601079300097;
        Fri, 25 Sep 2020 17:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm1wiUlEdC2g5dhJZLl41obJmPj5jTOu28bJLiTneBSvhZddgQf2aWWPtCvm+OThg8ei5WMg==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr7025279wre.275.1601079299851;
        Fri, 25 Sep 2020 17:14:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id v9sm5041404wrv.35.2020.09.25.17.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:14:59 -0700 (PDT)
Subject: Re: [PATCH 07/22] kvm: mmu: Support zapping SPTEs in the TDP MMU
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
 <20200925212302.3979661-8-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fd0ef13-77bd-ed84-684a-be364a62f8fa@redhat.com>
Date:   Sat, 26 Sep 2020 02:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-8-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> +/*
> + * If the MMU lock is contended or this thread needs to yield, flushes
> + * the TLBs, releases, the MMU lock, yields, reacquires the MMU lock,
> + * restarts the tdp_iter's walk from the root, and returns true.
> + * If no yield is needed, returns false.
> + */

The comment is not really necessary. :)

Paolo

> +static bool tdp_mmu_iter_cond_resched(struct kvm *kvm, struct tdp_iter *iter)
> +{
> +	if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
> +		kvm_flush_remote_tlbs(kvm);
> +		cond_resched_lock(&kvm->mmu_lock);
> +		tdp_iter_refresh_walk(iter);
> +		return true;
> +	} else {
> +		return false;
> +	}

