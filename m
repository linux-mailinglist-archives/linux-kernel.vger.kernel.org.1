Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00C027E0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgI3GYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgI3GYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:24:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601447061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQlVHYMhn8vBG9J1bK/w3aggY2ujDQ0L8SzsncwRqMk=;
        b=VuxG861R5+rZHpSXlYQNvOIwz4/8nVM2NkCsa3t90XjGJIHEFMPhk4ENViGanXTtPCR+0Z
        zPRw0pd1HdTFP8EFBHQqA9h/Y/g8QsYhHOQo3xkdp+4Z1CjtN4/djIRwXrC+3W7MJe0gsd
        GcOsI8HE7s/QUn3taH52w7JuGeuG0sc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-i2dY4SpqPy-PD_T6LPM6fw-1; Wed, 30 Sep 2020 02:24:19 -0400
X-MC-Unique: i2dY4SpqPy-PD_T6LPM6fw-1
Received: by mail-wr1-f70.google.com with SMTP id a10so202034wrw.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQlVHYMhn8vBG9J1bK/w3aggY2ujDQ0L8SzsncwRqMk=;
        b=r3u+EKKxkHEKTPI4DGPJbsWS2lPV8UCDG62orsbEFUqUmgdyqdcBXufKfzUqHeHFNG
         lTJVB1hKsOpshzBO59y5GpdQ5lYel/xY2BHLirEINZrv/2LcVdDpzBhzPf4ZBhL+vaqV
         KSQtjabSfBFijXuB7lNWaqK9Irkgu9XW8CuHz+f3Fwp0kvd603UyWieTOTsxk+so4iPx
         B3xmt1F7MrUy9HogeBbAWT/nfQ2f68U8tIpr64hiNJDb89Br6vS5yAucrTuWOD61XMPP
         fLdVofm75JrffbRTolw4aYskBKVIuk7cXdz8fsGhCkX+oL0x+svSYe18zAkRUVMuS5Xk
         zx9A==
X-Gm-Message-State: AOAM530GjRg+UboWUw13RZdvsSxPB7fH1CZ85sYb2zJYV1fkJjhrJhze
        bIiSGfjGKHFFQ9L1drT/ms/zKILWU1G6L+PSr2z6LAeLGa8vMoQ8uX7gGZExhQn5G5B1mZ3+fES
        Di2EIL7ELOESf8QTgKSFUV0QL
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr1256571wrw.34.1601447058643;
        Tue, 29 Sep 2020 23:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGcdxJdjm9pMwDJq9hEe59B3jvrWEmZgnX+vF1hzorRoj7r5nqs307SpW+Di5YlvUMjSDFTA==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr1256535wrw.34.1601447058417;
        Tue, 29 Sep 2020 23:24:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id 63sm1246438wrc.63.2020.09.29.23.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 23:24:17 -0700 (PDT)
Subject: Re: [PATCH 02/22] kvm: mmu: Introduce tdp_iter
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
 <20200925212302.3979661-3-bgardon@google.com>
 <20200930052336.GD29405@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61d23bc0-771d-9110-6528-3658a55ccba6@redhat.com>
Date:   Wed, 30 Sep 2020 08:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930052336.GD29405@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 07:24, Sean Christopherson wrote:
> Maybe use the params, if only to avoid the line wrap?
> 
> 	iter->gfn = goal_gfn - (goal_gfn % KVM_PAGES_PER_HPAGE(root_level));
> 
> Actually, peeking further into the file, this calculation is repeated in both
> try_step_up and try_step_down,  probably worth adding a helper of some form.

Also it's written more concisely as

	iter->gfn = goal_gfn & -KVM_PAGES_PER_HPAGE(iter->level);

> 
> 
> 	bool done;
> 
> 	if (try_step_down(iter))
> 		return;
> 
> 	do {
> 		done = try_step_side(iter);
> 	} while (!done && try_step_up(iter));
> 
> 	iter->valid = done;

I pointed out something similar in my review, my version was

	bool done;

	if (try_step_down(iter))
		return;

	do {
		if (try_step_side(iter))
			return;
	} while (try_step_up(iter));
	iter->valid = false;

Paolo

