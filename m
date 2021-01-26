Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB10E30461B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394370AbhAZSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393816AbhAZR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611683727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMaRRif4x/o1qr3EHWx3D3A3paOWJunfGP7cUczujlk=;
        b=APJk68J32PY3pKhg5gMrs+7PPZIDeDLVaivQG4R9b5fIWnqz2yIfd7ev86YFqTc27vY/m+
        m/7fo38AUIO5EgjCiU3aGxFLml/iB4F7ZfUg3DbpDZ43Cgii16N780VGmxkKOqP3xNNvjH
        B0y8sKdKnBUnIUvNgZGgwK2nViyDz9w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-qdDcLVCZMualDhxZR39wfA-1; Tue, 26 Jan 2021 12:55:25 -0500
X-MC-Unique: qdDcLVCZMualDhxZR39wfA-1
Received: by mail-ed1-f70.google.com with SMTP id m18so3126120edp.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 09:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rMaRRif4x/o1qr3EHWx3D3A3paOWJunfGP7cUczujlk=;
        b=KAIM3fhpAKsOSeJFzJJF3cv9DyG9x6TMniwgAwvE3y0izmm3VlQisZbT++JPoznLbm
         A6HrWIi7Gxfy0ByaciD5a6Dy4YOaFLq+7FiGBO9oBvxdH+Ah7dTZZ1WQZ+MBhOwOe+zy
         LOFX9nUgE4mF+GE9DoaijHxIl1KjQQ+YQ5pv/4ZFmfF9WXQCV3/BidieV0SbYgVkXLWw
         hfinru9v/eWS7cF7TePiiPC2AENWWr09FgWWV+7Cw4xEEogFIh6qGWej+YOpImLnpViZ
         pdBatrOfokzydAKKhYAlPsNEHT3MQPCnhcPrNXLqsflU4bkiliU5+gfgQc+1qRZkodjG
         CBCw==
X-Gm-Message-State: AOAM533skGwVZ3AvKKPzFwhwbpWy70QpQZixgxr1imUcKL6o51rx/8RA
        qtc3j1A2HhnJ5ply+jY7MAk5kl+ayNEy32LSN60qXRyq4wPnU2bQ2E1sJr9vkdQ8a1S5eRrLdd1
        K4y4kteZvaNbr3j2zu2UX0vXb
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr3994039ejk.311.1611683723883;
        Tue, 26 Jan 2021 09:55:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6rarq4cXLZKda6ZVXoCfOJgKXeUCmPj3eahyTXTqq3OCDu6EEaLCS8azd/93eAI0Bboegcg==
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr3993860ejk.311.1611683718719;
        Tue, 26 Jan 2021 09:55:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x16sm10255151ejc.22.2021.01.26.09.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:55:17 -0800 (PST)
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
To:     Ben Gardon <bgardon@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-16-bgardon@google.com> <YAjIddUuw/SZ+7ut@google.com>
 <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
 <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com>
Date:   Tue, 26 Jan 2021 18:55:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 18:47, Ben Gardon wrote:
> Enough that it motivated me to implement this more complex union
> scheme. While the difference was pronounced in the dirty log perf test
> microbenchmark, it's an open question as to whether it would matter in
> practice.

I'll look at getting some numbers if it's just the dirty log perf test. 
  Did you see anything in the profile pointing specifically at rwlock?

Paolo

