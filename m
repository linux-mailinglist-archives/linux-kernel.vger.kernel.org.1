Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4813304F31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392492AbhA0Bmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394953AbhAZSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:52:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A461DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:51:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v19so12014443pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JqkcLdrRWfRT7A5ZhCapzuQXGaNgtjBzs0pEpKsy3fA=;
        b=ogZA7OpLvF3JgDTUZ4JR7pDMmyOcvz+tSUZo73/pavgQEihCeV5pJMjzg+kn1F1ALT
         MR0G5nnNCay7cKcL1WqQgpdLmKFiTaIH+PpW9v+E/jgnFBtuJ1XRr6+u+2wi+7MFr0HU
         Z9H0DNaV5p3HWPxJfdTOIgI2A2s/zw9Iav77Pt8BDjoWkP8nUJ7I5TgkwgIaUFSpk+RA
         sK+VJiESf26q0a2k0zvqqZi53GE6/DUgLWWLMIqFbaT4kW1jTKt+J7y+G+t14u5KFu8T
         vIV1YBcDOgl2e+N+gzCnKFzVsqnosQX7ZyAh2NxLuZsC0rnBmJ8QvRErvCz0zOXyaOB4
         3sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JqkcLdrRWfRT7A5ZhCapzuQXGaNgtjBzs0pEpKsy3fA=;
        b=FTC28ns0hf1heOd0ufbLoSpI89it1XeTp3XYwgI2irnjeRDQmuqywoMbVEOnCcQhzU
         54G5wWMhYYa53+bP8l8fp0eX9ItRa9EvzT6O31zjjBT4tEabWXz5y5P6puwV3esrnLQY
         HklZH9+9DL8N7bMql/f/7+hlGDVK2VShMNV469CjopZQpG/L2oybgChpA/PWgImMN1PD
         7EhXlGa3GCMulWTGULyQLE/DOKb6apxbyVZHCUoTeqSZKuEmgzxRzpfhbexPWBiROO9S
         NDCkOjDQXXSFDo3d4w7hRAfSg/+nu0NXDwgEogoJOgokPO+0EiIYLhFC4YOgT65ixi2n
         tI8A==
X-Gm-Message-State: AOAM530jufD0uec9MoBp99HTo6zS2GWnaLTiWaeyMBpcYUjm/yHP4IaW
        Jair4IATJCDWg9oTEjuiZJGFsQ==
X-Google-Smtp-Source: ABdhPJwYbRZ7JYTsskmgCfktmCHFvRkWcvMluxQ9k2GAdepgICHaRqokhUawBJnCT9L1XAzWUXiKjw==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr7107242pgm.70.1611687082027;
        Tue, 26 Jan 2021 10:51:22 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id 83sm9788962pfu.134.2021.01.26.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:51:21 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:51:14 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Cun Li <cun.jia.li@gmail.com>, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: update depracated jump label API
Message-ID: <YBBkovGz4ym7NFaA@google.com>
References: <20210111152435.50275-1-cun.jia.li@gmail.com>
 <87h7nn8ke8.fsf@vitty.brq.redhat.com>
 <24e29c32-f6cb-cf7b-9376-1281b9545e69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e29c32-f6cb-cf7b-9376-1281b9545e69@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021, Paolo Bonzini wrote:
> On 11/01/21 18:15, Vitaly Kuznetsov wrote:
> > kvm_no_apic_vcpu is different, we actually need to increase it with
> > every vCPU which doesn't have LAPIC but maybe we can at least switch to
> > static_branch_inc()/static_branch_dec(). It is still weird we initialize
> > it to 'false'
> 
> "kvm_no_apic_vcpu" is badly named.  It reads as "true if no vCPU has APIC"
> but it means "true if some vCPU has no APIC".  The latter is obviously false
> in the beginning, because there is no vCPUs at all.
> 
> Perhaps a better name would be "kvm_has_noapic_vcpu" (for once,
> smashingwordstogether is more readable than the alternative).

+1
