Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1170D27B16A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgI1QIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:08:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD174C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:08:17 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k14so1986107edo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofB/nv2GCR1iBpmgOJtZPjrK0vaQJ8MfIT5aS/7qZSs=;
        b=TXz1uRJzzB/pr3oAfTmpUw47xO1t1ZD/4Gzv3Nfj/orcUBgE+FvmSJa4zy1lbUKQjk
         UA8aK0zPsPb4AmNcJNfeH2DbKSXicWsSPqJU3NptPVtx2X2yi0/3QWsQA31pJYw2eEKO
         dITUIaCkl16BLjkTNOqPLxAV90OJfu/pbEO6BqjURT54nddvrNjoOX6nLfJ2DbtiqWvf
         UYNMKUdn66e7aqbNSgR14gvmqRpxzWFpo4kCvIcAnL3nKSaF+HGbBEK5Hg9af3V1x51o
         zwNDymM2jKoCD625YWKMYt4APTULrVTNbXLKgYgFFYmT4XkpPeXb2DbevTaKC3pSBnXW
         rtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofB/nv2GCR1iBpmgOJtZPjrK0vaQJ8MfIT5aS/7qZSs=;
        b=mIQetCzDThFLUBwkg1GnRY6CuRfIztkN1jhFwJmAsZaojOjSpnQ8hzywhKiFq2TtWj
         VQbkMWRmVGQF2efll/wb3GlgERXq/jBowRYfk1BVcLhLizqaOvnUxPNqlLau0YsxiuF3
         TR8cIsVjByZMhOCi0gNbjm818GOyQLccq3rttEbTkkaItpeu2dg8bXYci92AOiI73dbO
         T8PqtEvd0MrGrNGrk+HfXPG1CDQfSsnSTJR6+vQHDAmbT03Nux/P9ERZQpwvTxVP8u5v
         HtGUQVZIV9Scz9EJJrFTBTjUQMgRRZ+l7PYcDU7CIuiXggUhZ/XTydxSf3Y0lV28/eJn
         VnhQ==
X-Gm-Message-State: AOAM533Xi1rjtWC7tIxx8eGhwywhux1fgCPguH165rFRasa+95i9BaNN
        y/7so7zatSjZUJjqXHG3Kj1L+/f3jKB/RXqP7NXldA==
X-Google-Smtp-Source: ABdhPJxGmoa8fxh96Nu08ZI31iPAe002nm5dbBSAH1X1Q5vkX2UMdMl4Ale5/X1hNgzP5fPTDrX7TZ5wtpfcCAyra0A=
X-Received: by 2002:a50:e78f:: with SMTP id b15mr2645686edn.104.1601309296249;
 Mon, 28 Sep 2020 09:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200925143422.21718-1-graf@amazon.com> <20200925143422.21718-4-graf@amazon.com>
In-Reply-To: <20200925143422.21718-4-graf@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Mon, 28 Sep 2020 09:08:05 -0700
Message-ID: <CAAAPnDHN3eNig6nWGsV120dzy55Vd9k8i1vL6S7_Z2sDR0FQFg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] KVM: x86: Add infrastructure for MSR filtering
To:     Alexander Graf <graf@amazon.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 7:36 AM Alexander Graf <graf@amazon.com> wrote:
>
> In the following commits we will add pieces of MSR filtering.
> To ensure that code compiles even with the feature half-merged, let's add
> a few stubs and struct definitions before the real patches start.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>

Reviewed-by: Aaron Lewis <aaronlewis@google.com>

>
> ---
>
> v7 -> v8:
>
>   s/KVM_MSR_ALLOW/KVM_MSR_FILTER/g
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/include/uapi/asm/kvm.h | 2 ++
>  arch/x86/kvm/x86.c              | 6 ++++++
>  arch/x86/kvm/x86.h              | 1 +
>  4 files changed, 10 insertions(+)
