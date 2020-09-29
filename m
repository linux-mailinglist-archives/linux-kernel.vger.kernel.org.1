Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444F27D580
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgI2SKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbgI2SKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:10:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601403015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bzMnYsI8s4Q3hq/GIll4V70MTiboyVXjBtRnA700rQ=;
        b=L2fTFZm0ESkkbbGSMpEI5nDB4q9JwRGi18+nL/QPx9J3lgI9omdqV62/wBLwwMtmIO+8Bd
        E85ouCP4cA7YQOHIsw421ciBfO6yY/hsEZI33Oin5bfNSsV5VPwY/1BMGg5nINnXg6d5CA
        hSl0amQl26tUtZP7mzT+UzrqK7JrKSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-AK_eJpfCM2KwecyOC6Rv0A-1; Tue, 29 Sep 2020 14:10:13 -0400
X-MC-Unique: AK_eJpfCM2KwecyOC6Rv0A-1
Received: by mail-wm1-f70.google.com with SMTP id r83so1728731wma.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1bzMnYsI8s4Q3hq/GIll4V70MTiboyVXjBtRnA700rQ=;
        b=B9vKM4oq76MahNRR/OQrHTSiPecbxSloV+1SWP1ULQYi/fC+xJxyKAqKHZmjGJi1BR
         NXOvhZn80iauogehXZVNlVDKVySXx6KCuu/kqmmZj1P44hYK1eHiOtgQqFpEfLnKVN2i
         mkOgdPBZfvl3WHtzgDnzg5BRWaF/ruIEVGFvYU5XXrZTiqckBHfHNhHjOQ0Kahntps5g
         wt6vvUyubmpK37OpuQWN7fOd9xEfxvtfQmrSYN0CN8os8hIkkPiRpCnVD3Vtf1Re5TXT
         gCbziPY4tr56+JSpf5784cEJdIT6OAqxi1HH7s2vslfzuKdthIR2fqHmXA3EBz6KlaQM
         Qncg==
X-Gm-Message-State: AOAM531PFEWUF5vo59xJaiT3LGq4CsAdOQ1FgFw7cZ8YjSOMwfgSXjey
        FlrdNNiHg/oIHwntc+BBAoBJnnH52/3ioxjSeyOtNW1DDncBc9My/Tj8EQcdKBWgTkmd+TkRfqL
        XVyNvicTbjaRzXOg9vvcHfeGG
X-Received: by 2002:a5d:5751:: with SMTP id q17mr5796166wrw.409.1601403012636;
        Tue, 29 Sep 2020 11:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNAVYAPamXAJNpLCeK5kDwsEKR8jrhZaIZsRfbDIRLLNl9cWa99w5qQ7pOZAJ+/T8VOdyBzw==
X-Received: by 2002:a5d:5751:: with SMTP id q17mr5796137wrw.409.1601403012355;
        Tue, 29 Sep 2020 11:10:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dbe:2c91:3d1b:58c6? ([2001:b07:6468:f312:9dbe:2c91:3d1b:58c6])
        by smtp.gmail.com with ESMTPSA id l18sm7152799wrp.84.2020.09.29.11.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 11:10:10 -0700 (PDT)
Subject: Re: [PATCH 00/22] Introduce the TDP MMU
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
 <425b098c-dbe0-d614-8e62-1f50b2f63272@redhat.com>
 <CANgfPd-zgP8GD+yOwZ1V-S=r9W92hFSEBpmjLzaqZDg=O20Hnw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6c18282-4fc7-5c66-9a34-f066823114e5@redhat.com>
Date:   Tue, 29 Sep 2020 20:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd-zgP8GD+yOwZ1V-S=r9W92hFSEBpmjLzaqZDg=O20Hnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/20 19:40, Ben Gardon wrote:
> I'll get to work responding to your comments and preparing a v2.

Please do respond to the comments, but I've actually already done most
of the changes (I'm bad at reviewing code without tinkering).  NX
recovery seems broken, but we can leave it out in the beginning as it's
fairly self contained.

I was going to post today, but I was undecided about whether to leave
out NX or try and fix it.

>> One feature that I noticed is missing is the shrinker.  What are your
>> plans (or opinions) around it?
> I assume by the shrinker you mean the page table quota that controls
> how many pages the MMU can use at a time to back guest memory?
> I think the shrinker is less important for the TDP MMU as there is an
> implicit limit on how much memory it will use to back guest memory.

Good point.  That's why I asked for opinions too.

Paolo

