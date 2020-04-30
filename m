Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E5E1BF07D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD3Gq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 02:46:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50606 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbgD3Gq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588229184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLEL+A2Y8ThCTO/2PBYFiQCG0qUQHEWBfC2HqHC6sUc=;
        b=iq7pg1Nhc9qq7ipNYPveH2Y7+GhPqMO6rdS1ZHgWGpTW88pnFK1EM73e2sEFHWvq7yofRa
        LBDs7Jnmx6zeAyHSYoOkNF8HK5fEBsdoz0Uc/aQMWEt+iib2mtdy44//pXccBMgD8yaCbI
        iw1VZ4L69tEJWMqCgA6Is/GlQRLo1xw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-o-vkuThKP4qbCGIBxpbCsw-1; Thu, 30 Apr 2020 02:46:20 -0400
X-MC-Unique: o-vkuThKP4qbCGIBxpbCsw-1
Received: by mail-wr1-f70.google.com with SMTP id p16so3360784wro.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 23:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RLEL+A2Y8ThCTO/2PBYFiQCG0qUQHEWBfC2HqHC6sUc=;
        b=rv2YsDRxj/7gcUSyw5iutiNd/HqWX4HWytrxhqgeNLmELT50QVCoDwVqAWb4CJQjJ2
         XAK66w68JytCN5UYtBKaJXYn0JMj18KbsSwS+HOvZGY9kB5GqSwrPy6WIEUuJ6gfMR/n
         rvShtBvGihXZUFE6t7EiFqakb7PH88VvYsMLYAGqvUbA6GlmBMgOnlnUmgV+8QAQnuv0
         zO8uouwJl9nxN/D3uXjFTKa9ZCqQNsSpgjAbhiVkeeVmokIwvlLxcaCXGOsjawsJyXVW
         xyZglBniiwnrqPcXIWwLv8M9mk7JvElwwBY3lz7IRYjKuvviRyU17b4Xtk5ik5jWfmuo
         J4TQ==
X-Gm-Message-State: AGi0PuaSevauBADThc3mfb0KCDXivPf5Xn9pyZxU7Budrryo2dYuni4y
        CKgMxlytNYzKM7Kg7P0MDMl042CInh7q78GT/g+Q3wwdJtuJQnO981Jo4cbeIOvYhSaQfg1npGu
        1df44JpdqVep5lMfiD/WKoeyY
X-Received: by 2002:a05:6000:114c:: with SMTP id d12mr1918069wrx.381.1588229179417;
        Wed, 29 Apr 2020 23:46:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcWHDQ8NNR/eZLBVLzbDVLqCqfBNiQOwlCXTe6YPk//VfIN5W3VSPkaw9TeqPPHPYxDiKjcg==
X-Received: by 2002:a05:6000:114c:: with SMTP id d12mr1918041wrx.381.1588229179146;
        Wed, 29 Apr 2020 23:46:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id h16sm2669639wrw.36.2020.04.29.23.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 23:46:18 -0700 (PDT)
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-5-vkuznets@redhat.com>
 <CALCETrXEzpKNhNJQm+SshiEfyHjYkB7+1c+7iusZy66rRsWunA@mail.gmail.com>
 <0de4a809-e965-d0ad-489f-5b011aa5bf89@redhat.com>
 <CALCETrWQBmmVODuSXac965o29Oxqo6uo4Ujm2AN2FUMztwCnzA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2be99d33-7b5d-bf2f-a34f-b841cd5c1936@redhat.com>
Date:   Thu, 30 Apr 2020 08:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWQBmmVODuSXac965o29Oxqo6uo4Ujm2AN2FUMztwCnzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 02:45, Andy Lutomirski wrote:
>> That's a very bad idea since one is synchronous and one is asynchronous.
>>  Part of the proposal we agreed upon was to keep "page not ready"
>> synchronous while making "page ready" an interrupt.  The data structure
>> for "page not ready" will be #VE.
>
> #VE on SVM will be interesting, to say the least, and I think that a
> solution that is VMX specific doesn't make much sense.

You can always inject it manually.  The same is true of Haswell and
earlier processors.

> #VE also has
> unpleasant issues involving the contexts in which it can occur.  You
> will have quite a hard time convincing me to ack the addition of a #VE
> entry handler for this.  I think a brand new vector is the right
> solution.

I need --verbose. :)  For #VE I liked the idea of re-enabling it from an
IPI, at least in the case where we cannot move out of the IST stack.
And any other vector that behaves like an exception would have the same
issue, wouldn't it (especially re-entrancy)?

Paolo

