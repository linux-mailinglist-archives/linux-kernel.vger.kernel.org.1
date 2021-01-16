Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8F2F89C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbhAPAJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbhAPAJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:09:47 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B68C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:09:06 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id i6so10311899otr.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T96/LrmrX4v1El2ImPseDYJC7X8vCHw3ch5hAsrm1bA=;
        b=JgHq9YwcfkarHPYgR2P0+n7SkGpYtgtsd6SnV9KRsUnKQ+BAcHjRdpmSiHIT6lsMOL
         7K1ltiSeekgfO/OdzsON8YHZEboJy8cswSlrGzH7qud3Iec4wRwuVRvKv1O37BWLMzr0
         9R4/24oXo3TAAyO0VhtPA3IGx5mLPbvpEGZBsoWg7bVjdezaLKC/Bq2gC4psRNvcfz+/
         pMTffgA1G7YHF1f5L4APsZlf2WpCM7Zl5Pe2yem0uoxO+kadgw49Lt7PUgIDDWHm2tlX
         rKZstY3UWdNJEvKlJ674kY3lf/JY3XQpoPMJ6pf7vVyUWAO/Du4rbJgfusxe/zv9vaGd
         3P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T96/LrmrX4v1El2ImPseDYJC7X8vCHw3ch5hAsrm1bA=;
        b=nLRsjBa/PWTOfmpsbQdRpEB1kv4DBt1ITw1YCOHdUl99TTq8adHeLfXfr/JzYIrwih
         zC3z5kuWetN/XV/AX9m1LW6C+jaDrMmYaNiTA/tt9FG3RgiOd2wY/aOXsof3JVWJxN0R
         8XLwR01Q1eZeY0qLzvWpkHqk8HNuk2MmRifyqmFii5AqONwOk2T4MURxNXfXl6KMAyH4
         8IHQXZfup9lj/YOfidNNgbaysjJmN5t6KwgAIh+PzCibUPmNJ2DRRoEI0tmISVLGsKUU
         emVtedkkSaWBa+7fv5aOT8NaOuy1awUXDo5YCVUHlXDSXHOT/P2cxZzyEFvp3IJRfVr8
         8x7g==
X-Gm-Message-State: AOAM531OCEaWlvdbUQumh8oJfjcCaIKT9zRDnvn42lwruFsbURkODpYG
        emY2ireFjETgtaNTdGr2Qm3cUXDDdaOIqm6LcrAfrg==
X-Google-Smtp-Source: ABdhPJyX5epGpS79rxarctVemmuXjNYVy1RFTLvTcq4yLzceLtn/p5JPoe5zCaa+iDP/L3UzLB9UZZRrm4vKmT6/Ky4=
X-Received: by 2002:a9d:620d:: with SMTP id g13mr10334421otj.56.1610755745980;
 Fri, 15 Jan 2021 16:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20200903141122.72908-1-mgamal@redhat.com>
In-Reply-To: <20200903141122.72908-1-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 15 Jan 2021 16:08:54 -0800
Message-ID: <CALMp9eT7yDGncP-G9v3fC=9PP3FD=uE1SBy1EPBbqkbrWSAXSg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 7:12 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> This patch exposes allow_smaller_maxphyaddr to the user as a module parameter.
>
> Since smaller physical address spaces are only supported on VMX, the parameter
> is only exposed in the kvm_intel module.
> Modifications to VMX page fault and EPT violation handling will depend on whether
> that parameter is enabled.
>
> Also disable support by default, and let the user decide if they want to enable
> it.
>
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 15 ++++++---------
>  arch/x86/kvm/vmx/vmx.h |  3 +++
>  arch/x86/kvm/x86.c     |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 819c185adf09..dc778c7b5a06 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -129,6 +129,9 @@ static bool __read_mostly enable_preemption_timer = 1;
>  module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
>  #endif
>
> +extern bool __read_mostly allow_smaller_maxphyaddr;

Since this variable is in the kvm module rather than the kvm_intel
module, its current setting is preserved across "rmmod kvm_intel;
modprobe kvm_intel." That is, if set to true, it doesn't revert to
false after "rmmod kvm_intel." Is that the intended behavior?
