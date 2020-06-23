Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC69620640B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 23:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393340AbgFWVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390878AbgFWU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:28:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:28:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i4so22312334iov.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSPtdAoBezoYzD8XC8jNDB6bATmQyei/lRaAJLxm7dw=;
        b=moQfH9pCQ4VqWT4Y7KzG1qf3keLcBnZnTHixTqrnDXhSW/qaw5cRXwuGHcN4gOtyP/
         WKeIXq96XY/WjRtkkgv5myED1TEeWxWMFI+qkQJS2IOYFbR0uA/03nMHTFStmTUS9nDA
         VvNG359xj9w56+kyALW0DQH91iR92W2Hf97LceZDtdEKpv/pDsoi4jaRVWo4xI5P5bce
         Fk0c9VRL8d0tS67VKbGTOU/SfLOyZqY3fYyYMK2uyXONFZJkl0FaKM/k+SU5/KBOOmFY
         ZYGhNbKn3HNH4s+ZuTFvQn/as8jscuATSlVVbRD3poFI9Taoz5GLt/G2/6V6Zp1FrjTj
         F/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSPtdAoBezoYzD8XC8jNDB6bATmQyei/lRaAJLxm7dw=;
        b=VmXfbc7iT1/EJEdtI1arl4Fs76Fz4vN1JJrQWIorbPVYq0GTg1gIpLPi5QrwNvoglI
         NKED4Oe52u81wpKBu72cC74H6HASEhBzqYbufFsmihP4xLrbKTIeYdlmApkACtRz2Rm+
         XhSzX4uEdDEbNdIDLNyMZ4y85Gw3Kw+QBWKShgEoeGwV7VixDxsnUVryg8/o6gkBj52h
         +F/67lVUUZKfnuFBx9e6NbT1yXTIs7oZEr3EEvgc7tvxRPv8WqoLERV34vA3AxDYyQXc
         NP2Gf0d9pASY7XqCLvhE9ec4eUnMWEsvMO35iF3KLTdebqFwGQLpHuoIqeYD9LmIFH2f
         JjKg==
X-Gm-Message-State: AOAM533YEppM0pu8Q4THulACYco6JYIrhhbbyjGMIA3PWgbK0H9hUMNY
        VeCKjuBHhSC6MFL00COFgOFLKW5fGE66YRC0MVW3kA==
X-Google-Smtp-Source: ABdhPJxlYU8JWVYxZvphpJBgmzBHsYDxrytL4SZcIB21fkLOEXFrgJ0/tjn/KsDSq3GAKIklzlj9PiYc0oNBsAH3lBY=
X-Received: by 2002:a05:6602:2dca:: with SMTP id l10mr27131901iow.163.1592944110821;
 Tue, 23 Jun 2020 13:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200623194027.23135-1-sean.j.christopherson@intel.com> <20200623194027.23135-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200623194027.23135-3-sean.j.christopherson@intel.com>
From:   Jon Cargille <jcargill@google.com>
Date:   Tue, 23 Jun 2020 13:28:18 -0700
Message-ID: <CANxmaygUwYDT38zde=hoMw+xE2PgVE+eG-dDYguneX=-i=ML+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Optimize MMU page cache lookup for
 fully direct MMUs
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.

Reviewed-By: Jon Cargille <jcargill@google.com>


On Tue, Jun 23, 2020 at 12:40 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Skip the unsync checks and the write flooding clearing for fully direct
> MMUs, which are guaranteed to not have unsync'd or indirect pages (write
> flooding detection only applies to indirect pages).  For TDP, this
> avoids unnecessary memory reads and writes, and for the write flooding
> count will also avoid dirtying a cache line (unsync_child_bitmap itself
> consumes a cache line, i.e. write_flooding_count is guaranteed to be in
> a different cache line than parent_ptes).
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 67f8f82e9783..c568a5c55276 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2475,6 +2475,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                                              int direct,
>                                              unsigned int access)
>  {
> +       bool direct_mmu = vcpu->arch.mmu->direct_map;
>         union kvm_mmu_page_role role;
>         struct hlist_head *sp_list;
>         unsigned quadrant;
> @@ -2490,8 +2491,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>         if (role.direct)
>                 role.gpte_is_8_bytes = true;
>         role.access = access;
> -       if (!vcpu->arch.mmu->direct_map
> -           && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
> +       if (!direct_mmu && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
>                 quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
>                 quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
>                 role.quadrant = quadrant;
> @@ -2510,6 +2510,9 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                 if (sp->role.word != role.word)
>                         continue;
>
> +               if (direct_mmu)
> +                       goto trace_get_page;
> +
>                 if (sp->unsync) {
>                         /* The page is good, but __kvm_sync_page might still end
>                          * up zapping it.  If so, break in order to rebuild it.
> @@ -2525,6 +2528,8 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                         kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>
>                 __clear_sp_write_flooding_count(sp);
> +
> +trace_get_page:
>                 trace_kvm_mmu_get_page(sp, false);
>                 goto out;
>         }
> --
> 2.26.0
>
