Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBD295E06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897870AbgJVMHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897854AbgJVMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:07:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37075C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:07:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z2so1964482lfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZA39m5B4lfhB7qi65Cq382t5m8SNmLhvXePaPr7AO4w=;
        b=ag1A3+hDk6wBaHU7tVEqAGouGpo8ukJV++f6+bRpXuby9BfbKDoEexFJBA/cf+y2qp
         /IS9F7M0Iyubb8pI64mgjCbtpwWeprftcbIWFdchDE0IKQxzVnZt3TN7lBO9FNBZF23A
         /BqNhvrshCX6I/s4oatmngPWfTHgnKjatSCAHF6bloJOdoTi2TqyOrGZVjiTk2s0XJIB
         g9LK6pwxhhNyHuVF7kGYgniPzaV6lrBuEWp6CaEata+zn0ZB2rWyow7wfe693xA7l2Yo
         Q1vAxB6k4HKhq/cmLdhyvFVG6dgL9i6crSL8SQtHCNdTr6kuTg2rFzeB5/O6QpqO+Y+s
         GTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZA39m5B4lfhB7qi65Cq382t5m8SNmLhvXePaPr7AO4w=;
        b=fsYDIBqJohbG5OAHs6zfCWs3DP960Zmlru1NgJ5HIzSVVRKiAwqiG5mnxf1M5skvwQ
         JzPEg7QuGp/Sj9YAjjoVMzdN3JQN2auUZh6TxiVOq8KL+JIz4G8nEpkd9hM3cQecjEal
         0hFmYgmTaoTtUZ0D4XwfRYC5h1pDZDxF7DQguph6drM5bV+MqnALbXvfVulWhlMzQBgQ
         8TErq2cv5F5g8kiJgm1Vf1I4bUFu/8rPfNG4PeHrZlIYDgEZF3/l3r9+0rtebJ7XKhT1
         zKGk9unt03+cIGYbMQdB8LBT9+QRZpBdYh1/SBOTfnzBOdcD6FdwQWGI7PeVhdkaRgJn
         vjMw==
X-Gm-Message-State: AOAM531qzTdI7QTYUe/htAcSlaA9WXtYt07YtzeaODPLrm2JR2lJHoJX
        olydQaqzFLFr2CrGvois904Mpw==
X-Google-Smtp-Source: ABdhPJzv4cMC9f5whc1/8PrlqdKus3Ypn6OTbtFMlq/llXt/prAe3CBMuvyqIY+7JRXyBV1qXMs+hw==
X-Received: by 2002:a05:6512:2098:: with SMTP id t24mr809068lfr.116.1603368465669;
        Thu, 22 Oct 2020 05:07:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f129sm238766lfd.201.2020.10.22.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 05:07:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 70D33102F6D; Thu, 22 Oct 2020 15:07:44 +0300 (+03)
Date:   Thu, 22 Oct 2020 15:07:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFCv2 14/16] KVM: Handle protected memory in
 __kvm_map_gfn()/__kvm_unmap_gfn()
Message-ID: <20201022120744.t5ap3f6maeuspkd3@box>
References: <20201020061859.18385-1-kirill.shutemov@linux.intel.com>
 <20201020061859.18385-15-kirill.shutemov@linux.intel.com>
 <20201022052647.6a4d7e0b.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022052647.6a4d7e0b.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 05:26:47AM +0200, Halil Pasic wrote:
> On Tue, 20 Oct 2020 09:18:57 +0300
> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > We cannot access protected pages directly. Use ioremap() to
> > create a temporary mapping of the page. The mapping is destroyed
> > on __kvm_unmap_gfn().
> > 
> > The new interface gfn_to_pfn_memslot_protected() is used to detect if
> > the page is protected.
> > 
> > ioremap_cache_force() is a hack to bypass IORES_MAP_SYSTEM_RAM check in
> > the x86 ioremap code. We need a better solution.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 +-
> >  arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
> >  arch/x86/include/asm/io.h              |  2 +
> >  arch/x86/include/asm/pgtable_types.h   |  1 +
> >  arch/x86/kvm/mmu/mmu.c                 |  6 ++-
> >  arch/x86/mm/ioremap.c                  | 16 ++++++--
> >  include/linux/kvm_host.h               |  3 +-
> >  include/linux/kvm_types.h              |  1 +
> >  virt/kvm/kvm_main.c                    | 52 +++++++++++++++++++-------
> >  9 files changed, 63 insertions(+), 22 deletions(-)
> > 
> 
> You declare ioremap_cache_force() arch/x86/include/asm/io.h  in and
> define it in arch/x86/mm/ioremap.c which is architecture specific code,
> but use it in __kvm_map_gfn() in virt/kvm/kvm_main.c which is common
> code.
> 
> Thus your series breaks the build for the s390 architecture. Have you
> tried to (cross) compile for s390?

Obviously not. I've got reports already from 0day and going to fix it.

Thanks.

-- 
 Kirill A. Shutemov
