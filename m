Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1C2865CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgJGRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbgJGRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602091296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ev7l4o4ItRm1VhP9wG9Pez+Vrn0NjvK4cwa9rKvbPLQ=;
        b=bQM53X5RTw2s0rkv3LDXHQfrIz5pyEnffckzIPfwTo7zcQ5uh/ysvpCYVh3W+DYDf+mOhr
        4W42tmKsr2ySWcfzU22uEONyOGRH0kR3cFoiQK201bVNo4WRaZTbT+W0xjxU65Ydgkrv7C
        7DfCV6rqzu+uSUtR8Ajgqaym+ZlZ5Kk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-DIMSMen1N4mwTtLtNEXUPQ-1; Wed, 07 Oct 2020 13:21:34 -0400
X-MC-Unique: DIMSMen1N4mwTtLtNEXUPQ-1
Received: by mail-wr1-f70.google.com with SMTP id y3so1600884wrl.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ev7l4o4ItRm1VhP9wG9Pez+Vrn0NjvK4cwa9rKvbPLQ=;
        b=ICN+d4SsonzFC5XiRdJIHY60Axv1Tv36IC+BKI5iGhDw7eYM4B0vbsvYmstHcH2ft9
         jcyu3DP9UDYBqV+5QZ4qF60LcW+8GkwTgM9rPtr0QEgxpRe+nJuf/jrj3hl6Vaf77qbr
         LGlX01TBnyhB/DTnZZc04NM8iZHhyS1pbIGLqrqcaFeMt1yDYmDRmyK5bVuVu7i5uAfm
         ISnf2wvx6yhksoC4+G0lfPMS/WeKkK4aEtUWXfJ1mFO7s8ySWnaVS98MySoASRHF2yLs
         Uu17VQDR6suOW3YSiQm6wTAOqPno6gdoVlJRWa0M3S6uxEvtiGhLN1KwWqUjwn7qVHL1
         6s3w==
X-Gm-Message-State: AOAM530CrI+VNBwkLLrK5Tfea1WwTkxxMZYZf5cg5lle9qqa+RR+pkhl
        AshvVsbzxA4U/kccT5wwll9r2fMnY47dnXP3vMsAn5+TdBiMIhjGTClgSY0KpDVloOCDQpfZC9d
        LduOC5axKvG3nOUzg3PmQYmMH
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr4378531wmj.130.1602091293250;
        Wed, 07 Oct 2020 10:21:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu5tg4RKDgSfRgtwbzjic91GX3ld6PSc87MB+VHzwPP3V2K3ebPcKG7RE4ZJ9NAurnMXOkXQ==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr4378514wmj.130.1602091293028;
        Wed, 07 Oct 2020 10:21:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff? ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
        by smtp.gmail.com with ESMTPSA id n2sm3737510wrt.82.2020.10.07.10.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 10:21:32 -0700 (PDT)
Subject: Re: [PATCH 18/22] kvm: mmu: Support disabling dirty logging for the
 tdp MMU
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
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
 <20200925212302.3979661-19-bgardon@google.com>
 <44822999-f5dc-6116-db12-a41f5bd80dd8@redhat.com>
 <CANgfPd_dQ19sZz2wzSfz7-RzdbQrfP6cYJLpSYbyNyQW6Uf09Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5dc72eec-a4bd-f31a-f439-cdf8c5b48c05@redhat.com>
Date:   Wed, 7 Oct 2020 19:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd_dQ19sZz2wzSfz7-RzdbQrfP6cYJLpSYbyNyQW6Uf09Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/20 18:30, Ben Gardon wrote:
>> I'm starting to wonder if another iterator like
>> for_each_tdp_leaf_pte_root would be clearer, since this idiom repeats
>> itself quite often.  The tdp_iter_next_leaf function would be easily
>> implemented as
>>
>>         while (likely(iter->valid) &&
>>                (!is_shadow_present_pte(iter.old_spte) ||
>>                 is_last_spte(iter.old_spte, iter.level))
>>                 tdp_iter_next(iter);
> Do you see a substantial efficiency difference between adding a
> tdp_iter_next_leaf and building on for_each_tdp_pte_using_root with
> something like:
> 
> #define for_each_tdp_leaf_pte_using_root(_iter, _root, _start, _end)    \
>         for_each_tdp_pte_using_root(_iter, _root, _start, _end)         \
>                 if (!is_shadow_present_pte(_iter.old_spte) ||           \
>                     !is_last_spte(_iter.old_spte, _iter.level))         \
>                         continue;                                       \
>                 else
> 
> I agree that putting those checks in a wrapper makes the code more concise.
> 

No, that would be just another way to write the same thing.  That said,
making the iteration API more complicated also has disadvantages because
if get a Cartesian explosion of changes.

Regarding the naming, I'm leaning towards

    tdp_root_for_each_pte
    tdp_vcpu_for_each_pte

which is shorter than the version with "using" and still clarifies that
"root" and "vcpu" are the thing that the iteration works on.

Paolo

