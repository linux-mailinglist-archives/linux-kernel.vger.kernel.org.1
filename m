Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF12DFFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgLUSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgLUSba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:31:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73AEC061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so6931452pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BndlnR8XFV7ufaUUoRBTJ+c5o1iLuwOiCGBoThwMts=;
        b=Fya1rBbEsbyEQQ+HWesPL7CMy2wvqOkx7OLk8aDsoKZy3PmgBwKNg3vz/LaEam8pMY
         Yns4sFjlmT4mmwsPsE2vu2J+srX4q6c66fpGm1Yt8ryY8G8OcXzw57KrSi+e+nPa9c9m
         Q2v5DpqiPly3llZtPexN0PGGooUWox5HJJ8bv/JR7igogjxW47lg69if5f6Fs1fEW3PE
         BHGs5dLhLdpOaUNZhkZbFW5iQu/fvZqz2A8DKqOTgdnUCMH4emOBUOlU73b3Jn67EEcd
         b5JuyFRMe37nqNb09homoUH/NRXj9sxnsSZWmAQcVonRa7jptSTG8C2VxJcwMfQJWkNu
         gseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BndlnR8XFV7ufaUUoRBTJ+c5o1iLuwOiCGBoThwMts=;
        b=JzTdrX0fGDRa6COymrzW1X4pEX4JtJCbur6QumKDuwQtus8TNH9tEauhClr6C9xX/c
         ncjjLLzs28LRG2mmCaXtHwaJvsKwS4QZlXqD+vel3IzjuAzD5l4gX1wMrcvStbQKWUbu
         awQc2e1AgbpW6H+gjj3qIEl4MefwgUwLi56RH5i/sjJMJQVen1RAZNdO6VmtkszrWuKY
         /ROBGDtx9K7OQwlLtH0HJR4czh+6Fs1diVO9peUj/b/LDB8apQXRzc+1X/nsgRezJiOm
         ImKOltC9NwciEeQ7jWO5SIQhlYbain8YbmB/krLg0fZ9FAePsuopxxbQnqwoFWr3LI39
         18IQ==
X-Gm-Message-State: AOAM5329tOQveYJzVDFWP98OwktX4Kwnefc+ZFLdFyxjQvoeUx8VaZWr
        NKWTWNXYz4EAljXw335dMi7Z0A==
X-Google-Smtp-Source: ABdhPJzWkvFh2A1UOPl97SQ4AcJKKgP93CoLuXU9vMBQjF4kQHp2OSo8wtjRTXHm1Wf4N8AmEzXXCQ==
X-Received: by 2002:a17:902:b783:b029:da:6567:f244 with SMTP id e3-20020a170902b783b02900da6567f244mr17115792pls.45.1608575450120;
        Mon, 21 Dec 2020 10:30:50 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id j16sm17737497pgl.50.2020.12.21.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:30:49 -0800 (PST)
Date:   Mon, 21 Dec 2020 10:30:42 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Richard Herbert <rherbert@sympatico.ca>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Get root level from walkers when
 retrieving MMIO SPTE
Message-ID: <X+Dp0kd19twjM0wj@google.com>
References: <20201218003139.2167891-1-seanjc@google.com>
 <20201218003139.2167891-3-seanjc@google.com>
 <87r1nntr7s.fsf@vitty.brq.redhat.com>
 <493c0252-7aa1-b14d-0172-91bf75cf7553@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493c0252-7aa1-b14d-0172-91bf75cf7553@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020, Paolo Bonzini wrote:
> On 18/12/20 10:10, Vitaly Kuznetsov wrote:
> > > -	int root = vcpu->arch.mmu->shadow_root_level;
> > > -	int leaf;
> > > -	int level;
> > > +	int root, leaf, level;
> > >   	bool reserved = false;
> > Personal taste: I would've renamed 'root' to 'root_level' (to be
> > consistent with get_walk()/kvm_tdp_mmu_get_walk()) and 'level' to
> > e.g. 'l' as it's only being used as an interator ('i' would also do).
> 
> Maybe agree on the former, not really on the latter. :)

Same here.  I kept 'root' to reduce code churn, even though I'd probably have
used 'root_level' if I were writing from scratch.
