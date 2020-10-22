Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C235B2962B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901829AbgJVQfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901817AbgJVQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:35:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88438C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:35:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h62so2025333oth.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbSMA5cK3miC1rzFMhai9G9EaizvndI8Vbc8mXaHBiM=;
        b=nZIh96vLRMh0Ow8Ly4Hs0wc8R3HeQkQnSQxbsVO5jlJQLv/aXOAHg78lVxecrJlhVW
         wPtxxsJQv2kyGZY6P4twp0KTNPIoU0AtfQepe9TMpdKxPk/vbHfCp4qKZjd66giG+N26
         hGOGSfhUB7WMF1DuBXurA2e/NWhFsG0PFTB9VPf33RPA5TmqsAsmf+BjEIa0omG6irN/
         YhYXfuhI6Z8mQGnYHv9xtEkY4lSrDWzZ1TU8JmaLY+1ZF9EKgS7jVeWLKxECMQbNL9o1
         CJ9/OlhclHJ8KtpN7WpmmVLvHP/cjx68IOT+UtjX5jqXcOYO/xuCy9dtlxAC+Hw+YHt9
         OYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbSMA5cK3miC1rzFMhai9G9EaizvndI8Vbc8mXaHBiM=;
        b=p1Y3Eh0eRQpbFLtsBZW/2aNPxJGSN35uwEvwgPlBW4L4hL0jRJPwYDs6EOx6nNwcvf
         MSmfPLugSnSKdJQIGJGF5jEq4X2QyNZWaKP5IYXCPwIJPqS8WARDLs92yVS3SpaDGB0q
         ZFYrynFiHdewAkqjNKBlbkh/y6FHbzaCN+sCjEl8IdKeSNlE/Dzkt3Iu57G8n8djODcZ
         eHtUZrAj61FBlarGueW4QfZsbVC+zELYHqBWZvgQuUzbEro1eOUcOyIIgccKDZG74DAj
         IgZoB7qT2EhCBNWBd3RunvKkBDD0pZ9VOMOV/S6qlyURhnFs+l0jIN+o/GgRbktINiI/
         U9WQ==
X-Gm-Message-State: AOAM531zrwYeaaJEvJCNi/GQXrBaYiULJrP7vBYncpHaHeQrh4vn/3bV
        OkGWXcqFcK+BY/sSleA9eSntzewrrBFc1Q8SDJYQ9Y5IZDI=
X-Google-Smtp-Source: ABdhPJyML06zQWTxD8dp86b7yMaSNOqc3eJVWGAi6uiMa1J9oPuyqQ8lOr30tx2rXF03mgY6Iibn0MS3pOltULfUNHc=
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr2454249otq.241.1603384516604;
 Thu, 22 Oct 2020 09:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1603330475-7063-1-git-send-email-wanpengli@tencent.com> <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
In-Reply-To: <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 22 Oct 2020 09:35:03 -0700
Message-ID: <CALMp9eR3Ng-WBrumXaJAecLWZECf-1NfzW+eTA0VxWuAcKAjAA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Expose KVM_HINTS_REALTIME in KVM_GET_SUPPORTED_CPUID
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 6:02 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 22/10/20 03:34, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > Per KVM_GET_SUPPORTED_CPUID ioctl documentation:
> >
> > This ioctl returns x86 cpuid features which are supported by both the
> > hardware and kvm in its default configuration.
> >
> > A well-behaved userspace should not set the bit if it is not supported.
> >
> > Suggested-by: Jim Mattson <jmattson@google.com>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>
> It's common for userspace to copy all supported CPUID bits to
> KVM_SET_CPUID2, I don't think this is the right behavior for
> KVM_HINTS_REALTIME.

That is not how the API is defined, but I'm sure you know that. :-)

> (But maybe this was discussed already; if so, please point me to the
> previous discussion).
>
> Paolo
