Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942C29CBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374775AbgJ0WOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:14:44 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43006 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374766AbgJ0WOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:14:44 -0400
Received: by mail-il1-f194.google.com with SMTP id c11so2930551iln.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLa0ggCrzpl+1zNDrFJmUAlVnfUbq2tIBn21AbCWrR4=;
        b=Ab5SZreFab0MUToC7RtrhUrxDozrkIhBug1AKrn9y6vd5CPXHhNwqTFnVDBHgqR8FD
         192bltT+MfBayz4Hv6X0+3deNdtDEVwN0jB7WghhtVDKRac6a5SkpOlmhDcptH16F93R
         tSwE0X8yzRuI24yEKUE9kBrTt+5Ngq7zut3OI8pEehaphk1KWOQ9APOPC5K0+wCT8EnC
         6Yc1UCDzxaetbos/steWfLkHzgfacWeMbGZ3bxkk/XvnbgneEeFJUEBuoQRItTF3OkXg
         vmWLzp3BvAmHGVdfBjgeeV2qp5kQKHRuU3yI2bkjoWrNCndtCjQOtacL7LgQ1Sqab4nh
         1Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLa0ggCrzpl+1zNDrFJmUAlVnfUbq2tIBn21AbCWrR4=;
        b=s+PxyMDiEJjYmhiRGfr4ZCdY4Q/XmkEhwtjK2T8Y2WxLbr0BFWQDXFdcyeWlc9Se2H
         oFbJMtZG9n30To6gdUtG8yo0sN+2fhN+6MLVrjCGDnChm565VO5Q+VEih4seDRQn8cAA
         O7AX3qmsPrwT95hy0HuxreFynlCwgIK+SEyOn1Smi4HXeXSp0Rf7cEfAk4kboLjj5Jtu
         IYN1lz9x8yYf3ANNGJFDVq2C8hl49F+2YymmcBwv4n/zA7OoLaaa/0p96jOe/XWUgvRh
         qreIbLJ7hv6U5lEPUQdteVUVRzPfWTELA1N97rX0rvzkMk/EvLpnGgLD5bbQFVhfoZJC
         ARXQ==
X-Gm-Message-State: AOAM5311NKCWXs6C3MJjh438mVlyJsbIq5eUiyd4zj2ywqX2Za264J6E
        Qs6PkWkGRDmbE49gsBQ1Lt5eUTneH3r1qT6TZh+ngg==
X-Google-Smtp-Source: ABdhPJz/WQDT5EeuSdzml82I2MSH54zA1Js11Dp661HOzB7vFz+ftCfrQRn3W6Jxph7YXNUtQxqTvmvZ7OB/beDGRdU=
X-Received: by 2002:a92:d5c4:: with SMTP id d4mr3238097ilq.154.1603836821762;
 Tue, 27 Oct 2020 15:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201027214300.1342-1-sean.j.christopherson@intel.com> <20201027214300.1342-3-sean.j.christopherson@intel.com>
In-Reply-To: <20201027214300.1342-3-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 27 Oct 2020 15:13:30 -0700
Message-ID: <CANgfPd9JrE3Mrbbb4Kc+jfDU+hi65XuPY2HVkqgxTF2g4DAD1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86/mmu: Open code GFN "rounding" in TDP MMU
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 2:43 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Drop round_gfn_for_level() and directly use the recently introdocued
> KVM_HPAGE_GFN_MASK() macro.  Hiding the masking in a "rounding" function
> adds an extra "what does this do?" lookup, whereas the concept and usage
> of PFN/GFN masks is common enough that it's easy to read the open coded
> version without thinking too hard.
>
> No functional change intended.
>
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_iter.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
> index c6e914c96641..4175947dc401 100644
> --- a/arch/x86/kvm/mmu/tdp_iter.c
> +++ b/arch/x86/kvm/mmu/tdp_iter.c
> @@ -15,11 +15,6 @@ static void tdp_iter_refresh_sptep(struct tdp_iter *iter)
>         iter->old_spte = READ_ONCE(*iter->sptep);
>  }
>
> -static gfn_t round_gfn_for_level(gfn_t gfn, int level)
> -{
> -       return gfn & KVM_HPAGE_GFN_MASK(level);
> -}
> -
>  /*
>   * Sets a TDP iterator to walk a pre-order traversal of the paging structure
>   * rooted at root_pt, starting with the walk to translate goal_gfn.
> @@ -36,7 +31,7 @@ void tdp_iter_start(struct tdp_iter *iter, u64 *root_pt, int root_level,
>         iter->level = root_level;
>         iter->pt_path[iter->level - 1] = root_pt;
>
> -       iter->gfn = round_gfn_for_level(iter->goal_gfn, iter->level);
> +       iter->gfn = iter->goal_gfn & KVM_HPAGE_GFN_MASK(iter->level);
>         tdp_iter_refresh_sptep(iter);
>
>         iter->valid = true;
> @@ -82,7 +77,7 @@ static bool try_step_down(struct tdp_iter *iter)
>
>         iter->level--;
>         iter->pt_path[iter->level - 1] = child_pt;
> -       iter->gfn = round_gfn_for_level(iter->goal_gfn, iter->level);
> +       iter->gfn = iter->goal_gfn & KVM_HPAGE_GFN_MASK(iter->level);
>         tdp_iter_refresh_sptep(iter);
>
>         return true;
> @@ -124,7 +119,7 @@ static bool try_step_up(struct tdp_iter *iter)
>                 return false;
>
>         iter->level++;
> -       iter->gfn = round_gfn_for_level(iter->gfn, iter->level);
> +       iter->gfn &= KVM_HPAGE_GFN_MASK(iter->level);
>         tdp_iter_refresh_sptep(iter);
>
>         return true;
> --
> 2.28.0
>
