Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523B92F1D46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbhAKR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbhAKR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:59:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF98C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:58:37 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h186so406750pfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2lm70Ggq7phoaQdO9eh1J8nKy568IRUhnAqo2gDpwug=;
        b=Yi1bvgxwKfXTkZnOP72Pmv2jaenl99ZsFBSzUvtEwJ17uzJQss8ZzOego2XKqv4otc
         evFFIrPaX1U27ZqTvupdxeRvKk45MrdmtGy+JZx144XDMfu4dg8xG6Bc+1XQgYUdjTxb
         74ZhoVogcEQjbpjheC6e34dQ7qkWzH+JktjuOTsneshLfedvfBcfsCNWo+AI0oPAkOht
         HEth2dS89lsqGBY7pNWjqVGISAMT1RUJzW/hH3mD9a0JfD9VziDVA7osIB+UK2tWNYeL
         nJViH2v83mqPgS8j5BikrBPJTErIqCU33ZZP5j8NDDPmL10cAxvmX0toekm0gt7u5vJV
         jrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2lm70Ggq7phoaQdO9eh1J8nKy568IRUhnAqo2gDpwug=;
        b=MJThZ8GlLfkbiHMHhzdamDhcnMqR/Qyqn5v5IKCgVW1+GTJ7eJ4dt8kdIQDj5Pr0Wl
         dRDB/upuHEtd/Ijtldop3rdjLBgtVRfFK/xWgasthLnvZBGxk/7TWr4sHDsIV1qmGvw6
         bkXCtjcWD5DaGRgNmITubSQy3Qgc2gSbJ41d6pl+0qzzqrYMPwZqYSVOyO3x1YD709eD
         oZsv3Wg+x79gG6Zc1rBiLMFxYWHeN8qamwkTYnz3A2PcWSWRkjTyYx9Ilaj+2xnoYAIn
         Rv7mnt06aVsOHJxC92JibXZjzcHx4wQ+CcYvSyepVUTWY7PcexBRyP681fXVB14WWs2e
         df+w==
X-Gm-Message-State: AOAM533+hn2qtAEgkQ/62z0O2sP6ylxxqKqu1sKHp2OZjuCDWLWXL/NL
        5Wb0mmOVUQ8HRvvtH1lHei6xnw==
X-Google-Smtp-Source: ABdhPJyl9l6RFQcpeTXKU39dwIVyADDHDqn4PQCQHlG/RcoPfTkeFWsCm2MbiPbtssnq7luGy2r0Gw==
X-Received: by 2002:aa7:843a:0:b029:19d:b279:73c9 with SMTP id q26-20020aa7843a0000b029019db27973c9mr765662pfn.3.1610387916649;
        Mon, 11 Jan 2021 09:58:36 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id 84sm277900pfy.9.2021.01.11.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 09:58:35 -0800 (PST)
Date:   Mon, 11 Jan 2021 09:58:29 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 06/13] x86/sev: Rename global "sev_enabled" flag to
 "sev_guest"
Message-ID: <X/yRxYCrEuaq2oVX@google.com>
References: <20210109004714.1341275-1-seanjc@google.com>
 <20210109004714.1341275-7-seanjc@google.com>
 <f6ed8566-6521-92f0-927e-1764d8074ce6@amd.com>
 <5b3a5d5e-befe-8be2-bbc4-7e7a8ebbe316@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b3a5d5e-befe-8be2-bbc4-7e7a8ebbe316@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021, Tom Lendacky wrote:
> On 1/11/21 10:02 AM, Tom Lendacky wrote:
> > On 1/8/21 6:47 PM, Sean Christopherson wrote:
> > > Use "guest" instead of "enabled" for the global "running as an SEV guest"
> > > flag to avoid confusion over whether "sev_enabled" refers to the guest or
> > > the host.  This will also allow KVM to usurp "sev_enabled" for its own
> > > purposes.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Ah, I tried building with CONFIG_KVM=y and CONFIG_KVM_AMD=y and got a build
> error:
> 
> In file included from arch/x86/kvm/svm/svm.c:43:
> arch/x86/kvm/svm/svm.h:222:20: error: ‘sev_guest’ redeclared as different
> kind of symbol

Dang, didn't consider that scenario, obviously.  The irony of introducing a
conflict while trying to avoid conflicts...
