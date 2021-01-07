Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814362ECCE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbhAGJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbhAGJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610012002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bexx/1QAEmvajYjTmjllbo8myiCOlF8Qg+6LqEVDzgw=;
        b=VD67IWbA6cA3IY42PDJiRb6acekHeBaXfHIpgSsPUO7dF15iLZ999tMdQ6SAelW7RTmOfy
        6nNKRuIyP30BC9ZRbmZDAPLhyqhxsaMLvwEbykpvNUA3SAm3fJL+/O8yH9nE+wm9WU5/Nj
        TjdsMoeUZeZXfJ9acYvslUGM9bO6bOU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-G8G0slHPOCab9N3nMsAY7w-1; Thu, 07 Jan 2021 04:33:21 -0500
X-MC-Unique: G8G0slHPOCab9N3nMsAY7w-1
Received: by mail-ej1-f69.google.com with SMTP id ov1so2204796ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bexx/1QAEmvajYjTmjllbo8myiCOlF8Qg+6LqEVDzgw=;
        b=bESneGLnvm+sJg5BYim6bIxJc6DivjGVVPNYtCiMu+5bQG8OwqhQsYE43LPNc+teOs
         agLhfXDklm9RK5UvlQEpt09LU+8TJYLzD5Z0M8TxIKeERhNww2OCj1liT0kXliyEdNzA
         sKaJaf5PThYnPPbxV14x4GY3zMhAnYb8NwE4jTkU4K9o7VB2lxEXLLmQ8K6dveXVuvIC
         wpOTjl3RJWakTIyopBYi5B9Xmfkf+aH4pfLPIBlkN1hinWQQvfCMd3pCJkl6raxh0rqi
         E3tmp+mCagzNtW+PuRX545idyI1MtBlMIUMJZPAjkEH6h+XshzWtOe1TWwWg//8HYb3g
         +otw==
X-Gm-Message-State: AOAM530mdvx10RD03ulNcnkSZklkGX9B9yTewzGHf+g5SDDWq31rtvuN
        07MzztE8nQ/zLWZIjvz/2dvN5HMjtxluQl9Y0e8Et8NOmua5qQNLHNUaagR7F6/E6yu3T7VC/Ti
        z7Ww0KF0LuTLlw930aFL4HWGV
X-Received: by 2002:a50:c053:: with SMTP id u19mr1023383edd.109.1610012000018;
        Thu, 07 Jan 2021 01:33:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3yvR6FyOsCpgbBreuEaI9dX1NxPrbN7EUgqcItzd7OZXT9hMVqAEOdYvD/nUozuoSQtmL0Q==
X-Received: by 2002:a50:c053:: with SMTP id u19mr1023371edd.109.1610011999816;
        Thu, 07 Jan 2021 01:33:19 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p3sm2459530edh.50.2021.01.07.01.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:33:19 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        w90p710@gmail.com, pbonzini@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert "KVM: x86: Unconditionally enable irqs in guest
 context"
In-Reply-To: <X/XvWG18aBWocvvf@google.com>
References: <20210105192844.296277-1-nitesh@redhat.com>
 <874kjuidgp.fsf@vitty.brq.redhat.com> <X/XvWG18aBWocvvf@google.com>
Date:   Thu, 07 Jan 2021 10:33:18 +0100
Message-ID: <87ble1gkgx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jan 06, 2021, Vitaly Kuznetsov wrote:
>> 
>> Looking back, I don't quite understand why we wanted to account ticks
>> between vmexit and exiting guest context as 'guest' in the first place;
>> to my understanging 'guest time' is time spent within VMX non-root
>> operation, the rest is KVM overhead (system).
>
> With tick-based accounting, if the tick IRQ is received after PF_VCPU is cleared
> then that tick will be accounted to the host/system.  The motivation for opening
> an IRQ window after VM-Exit is to handle the case where the guest is constantly
> exiting for a different reason _just_ before the tick arrives, e.g. if the guest
> has its tick configured such that the guest and host ticks get synchronized
> in a bad way.
>
> This is a non-issue when using CONFIG_VIRT_CPU_ACCOUNTING_GEN=y, at least with a
> stable TSC, as the accounting happens during guest_exit_irqoff() itself.
> Accounting might be less-than-stellar if TSC is unstable, but I don't think it
> would be as binary of a failure as tick-based accounting.
>

Oh, yea, I vaguely remember we had to deal with a very similar problem
but for userspace/kernel accounting. It was possible to observe e.g. a
userspace task going 100% kernel while in reality it was just perfectly
synchronized with the tick and doing a syscall just before it arrives
(or something like that, I may be misremembering the details).

So depending on the frequency, it is probably possible to e.g observe
'100% host' with tick based accounting, the guest just has to
synchronize exiting to KVM in a way that the tick will always arrive
past guest_exit_irqoff().

It seems to me this is a fundamental problem in case the frequency of
guest exits can match the frequency of the time accounting tick.

-- 
Vitaly

