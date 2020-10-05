Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5799D283D24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgJEROr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgJEROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:14:46 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64412C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 10:14:46 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so1070472ilo.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LH4HLYCvANgOu28hyUJsPrZS3FtxlNqZenjGShu6i3M=;
        b=Nsz6vjB4YNeOuA8rlM+cnNlM41tHyrHptBH7E54oAL5LTQ2wQHIAoX5QzUgFsrAn1o
         7+0RRStSJejV1xx7LNi6ax50hU7N0J3BWdqwh/pshWSvMolQQrp8lqUhR1d1Y9KLmqnk
         2U5d50WnWNXTXuaT0L6UM7lx5+UMLoyDdRWs6Se5JaTvJIV8Yak7cDjEpJ6eMiaoHagu
         iPfCkW0YA+7cfmPlztEAlJ8KCcpU2ntbCayznh7a746qZULpmi93ZyAGLDThJU+mqm44
         jbupf2glWYatQWwmhfq9gRubIcugXhPWRx6eMpjUxFjbRyOyrIhYMGeAhRzyva/zn2Ip
         S0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LH4HLYCvANgOu28hyUJsPrZS3FtxlNqZenjGShu6i3M=;
        b=kMKqaS8o2GVKncxhejUnJgea1s2iEsdh2VcppJLfBz9c7jC26UEilic/hUp77X4iGY
         tIFEwFrw0xZR6SusHnkZtYctULXCdwp4ardiJgnMi1tVS4ZKRRirl7s3dYHqB9H7MMF2
         ZcCl3DI6nUqeJHamGdtI5MJoPHUZXW4WTo9tLPSz49mdirKyWX7+LEhBotR6QXYwajgI
         E3NCucJCni8vBR2epxFavbxeNarayGj+GPXwf4+GGpF/9PHN13jFa0sqyIlRk3pEa14K
         dqzG+lavJktzxJuDnIhJurEw3sVqWYvM29IQPQPDTQzTXLssRKjMY2icqNrgHMJqzn93
         4asw==
X-Gm-Message-State: AOAM530GzBbllgFyxIsN1mSlrFFLV521Xw0CoMl14I+5dH1DKFYVsF7b
        Wo2o19vJs96dJmFwOQ625yFvuYuYb48lGhI6tm3oYg==
X-Google-Smtp-Source: ABdhPJyMs4E0zbdNzw5x6P/5OcoWZCN+MNgzV2yAJf40F/IPPZ3fzWp9Vu8SW8fLgk4WOVfExl1eJOHr+F2ZQtdM4Hs=
X-Received: by 2002:a92:1e07:: with SMTP id e7mr302036ile.154.1601918085308;
 Mon, 05 Oct 2020 10:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601770305.git.joe@perches.com> <ed95eef4f10fc1317b66936c05bc7dd8f943a6d5.1601770305.git.joe@perches.com>
In-Reply-To: <ed95eef4f10fc1317b66936c05bc7dd8f943a6d5.1601770305.git.joe@perches.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 5 Oct 2020 10:14:34 -0700
Message-ID: <CANgfPd8_Crt0VO3phV7ec55ghSLiJzmzTypNvnZAYq=uJL8r8Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] kvm x86/mmu: Make struct kernel_param_ops definitions const
To:     Joe Perches <joe@perches.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 5:18 PM Joe Perches <joe@perches.com> wrote:
>
> These should be const, so make it so.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 71aa3da2a0b7..6500dd681750 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -64,12 +64,12 @@ static uint __read_mostly nx_huge_pages_recovery_ratio = 60;
>  static int set_nx_huge_pages(const char *val, const struct kernel_param *kp);
>  static int set_nx_huge_pages_recovery_ratio(const char *val, const struct kernel_param *kp);
>
> -static struct kernel_param_ops nx_huge_pages_ops = {
> +static const struct kernel_param_ops nx_huge_pages_ops = {
>         .set = set_nx_huge_pages,
>         .get = param_get_bool,
>  };
>
> -static struct kernel_param_ops nx_huge_pages_recovery_ratio_ops = {
> +static const struct kernel_param_ops nx_huge_pages_recovery_ratio_ops = {
>         .set = set_nx_huge_pages_recovery_ratio,
>         .get = param_get_uint,
>  };
> --
> 2.26.0
>
