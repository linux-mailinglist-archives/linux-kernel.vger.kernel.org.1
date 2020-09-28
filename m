Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03C127B08B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1PLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbgI1PLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:11:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601305890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlwOFkZa79dswmCrZ/uMRqRS1jmqGoMfOKy6A9Hyy7M=;
        b=bJSxrKI9I4fIZKC5BtbUbnXEJEOsy6hAT3bqOvKcrWQpruv106kXvdGpnTiRalSSShUxl0
        XZf1kH2q2zaAS9i1WZ/dnncr5W8e9EcWulclSdS0iPOOX+1N7w5OqrPXQ0+/lhOMpzTNQG
        Q49hBBzz7zRB4IqXJBqH6mTJU8D4PTo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-kHwmu4CaP5yhf54iE9Ru9g-1; Mon, 28 Sep 2020 11:11:28 -0400
X-MC-Unique: kHwmu4CaP5yhf54iE9Ru9g-1
Received: by mail-wr1-f70.google.com with SMTP id d13so515640wrr.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 08:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlwOFkZa79dswmCrZ/uMRqRS1jmqGoMfOKy6A9Hyy7M=;
        b=SsfQlzWWMx7IAD0GvPRIkcwGyXiYvSeJe2Z6KlSQHxm7AyU/JPG7lVZaAPCc2TBPtB
         XorHpuSG8faSnyPxRtK7EeWBtd0PCbxVjhYNIdIn6mkGcO/w/lvuvWvvpNMJGgLj4yk8
         uaAsgyeD9P6oyUkhJ3l8Df4KqrY8rrX2OAVDILHDAvQzrwq3KwbaXP4oJDYFn3zbS063
         wE0ObYBTm5xbwTbK0ZqXj1+JmXIGiBBtwGGu+6I4zy1U5IyZR6zYhByjFPzinNsFMQDX
         1silhG90hqHgdZP9W+novwFGudIdlyvFePnrONC/E7wz/Ty71dvPyz+W8iOd+bYWTNiZ
         jDQQ==
X-Gm-Message-State: AOAM5323TR9/UUFUAB1o0i9rC69O7Eq2aJxNVkd5tVc8k/G6TFhk21Zy
        O7g3Wd+1U+PPMuqugf+p6qd+dAuux/cWzo6uHvU6jd+dD/n4tTJ11dupOYh36d9lqH4rYHPyqcq
        gIJ7AGYbN2q2OcZr4qq9Y6jtb
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1994831wmi.163.1601305887285;
        Mon, 28 Sep 2020 08:11:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgH0fT+EfPSAu5naON5BaV2Jj5VdZVepiW0koYQfjuo8C9SZFrH2qlZO6pNrjHwWe3U9fRrg==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1994807wmi.163.1601305887080;
        Mon, 28 Sep 2020 08:11:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7? ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
        by smtp.gmail.com with ESMTPSA id y5sm1636990wmg.21.2020.09.28.08.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 08:11:26 -0700 (PDT)
Subject: Re: [PATCH 15/22] kvm: mmu: Support changed pte notifier in tdp MMU
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
 <20200925212302.3979661-16-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <622ffc59-d914-c718-3f2f-952f714ac63c@redhat.com>
Date:   Mon, 28 Sep 2020 17:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-16-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> +		*iter.sptep = 0;
> +		handle_changed_spte(kvm, as_id, iter.gfn, iter.old_spte,
> +				    new_spte, iter.level);
> +

Can you explain why new_spte is passed here instead of 0?

All calls to handle_changed_spte are preceded by "*something = 
new_spte" except this one, so I'm thinking of having a change_spte 
function like

static void change_spte(struct kvm *kvm, int as_id, gfn_t gfn,
                        u64 *sptep, u64 new_spte, int level)
{
        u64 old_spte = *sptep;
        *sptep = new_spte;

        __handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level);
        handle_changed_spte_acc_track(old_spte, new_spte, level);
        handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte, new_spte, level);
}

in addition to the previously-mentioned cleanup of always calling
handle_changed_spte instead of special-casing calls to two of the
three functions.  It would be a nice place to add the
trace_kvm_mmu_set_spte tracepoint, too.

Paolo

