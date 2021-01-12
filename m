Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D72F2BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392780AbhALJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbhALJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:52:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D02C061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:51:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c124so1322787wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kGqJqM+WMCcTD3fT9OGAlv624iwYZ5dObhUcI90VOiI=;
        b=YNctUgf8dt27MHnsqHy7GGqQMGB0dlxnW6P/Hq8s5vrm9RNUkp9NGZkONE++kDxT7T
         U7jU4by85oPF1vJDzvJwcAfOPnBUCXR/zclJrHyu1tzh1u92lNkPlR2+3z46r1fq/g5m
         IrR+vuZMuPGO1P7fyyICYqnduVYU1NJ892fvjXVaIYRoHRNk8oW9bxZA4FBKwZq9Rlo6
         2kbyY3Q//P6GDLoCmbPwp3QW0XeFbfEviwnu6em2BJXwTLGoXEMAet88e90/JKRuOHLe
         XQfOh9mIVLfUWGpeTYNpES7H9flRB7wNdv6zktN03Bb8yauJt9FzGvVzjI2Xm6/jpVIa
         0tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGqJqM+WMCcTD3fT9OGAlv624iwYZ5dObhUcI90VOiI=;
        b=npYUFz6Rz4+ctOY2Ke8t0fgIg0mmonIzs9o4NIXmSZPyU+YmEfvPLGk+O087cDkzxp
         9YwLr7M0wtFnQz1RgqbLdiRnTr7WohQuHHPm0Q4ENyj+1Y6mqhunIEDzf9XLezsPaJ/f
         14yVrvABK80dDK1U0btHlWo1fHJWi5qcEWyg1JDRTSCim97m/DU4WK2zsoPQJOE+Kt0t
         wGU3+iV4l5WSGfZ7dwMoMmMgCShtdtK830v1Hi2zdfLTT5NXliPyzkvt02E1FrfwUDQc
         /GZBjKNwFnuHHTJCe4ZTr3mhqpzCFsFd5nUuIrwLWGok1xv/8ZnRZxAibCdgn6fB7Cfi
         /gLA==
X-Gm-Message-State: AOAM530EfsZEYTB1O/0wQo2PAe9oEZjs4fFYzG928/wiG/FkRhBsJDVf
        z5xS/ujkxQLxhf9+t+G7l0IKBw==
X-Google-Smtp-Source: ABdhPJyannuEzJ8s+cicyxOh3wgUmPKHSocFYoH2gsdTqcMhFGEpJUgFPRSxz6Y87UQnjYt6TxbX8g==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr2773011wmj.154.1610445114219;
        Tue, 12 Jan 2021 01:51:54 -0800 (PST)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id b7sm3938742wrv.47.2021.01.12.01.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 01:51:53 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:51:51 +0000
From:   Quentin Perret <qperret@google.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 15/26] of/fdt: Introduce
 early_init_dt_add_memory_hyp()
Message-ID: <X/1xN2UxiUxkzAiN@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-16-qperret@google.com>
 <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 Jan 2021 at 08:45:10 (-0600), Rob Herring wrote:
> On Fri, Jan 8, 2021 at 6:16 AM Quentin Perret <qperret@google.com> wrote:
> >
> > Introduce early_init_dt_add_memory_hyp() to allow KVM to conserve a copy
> > of the memory regions parsed from DT. This will be needed in the context
> > of the protected nVHE feature of KVM/arm64 where the code running at EL2
> > will be cleanly separated from the host kernel during boot, and will
> > need its own representation of memory.
> 
> What happened to doing this with memblock?

I gave it a go, but as mentioned in v1, I ran into issues for nomap
regions. I want the hypervisor to know about these memory regions (it's
possible some of those will be given to protected guests for instance)
but these seem to be entirely removed from the memblocks when using DT:

https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L1153

EFI appears to do things differently, though, as it 'just' uses
memblock_mark_nomap() instead of actively removing the memblock. And that
means I could actually use the memblock API for EFI, but I'd rather
have a common solution. I tried to understand why things are done
differently but couldn't find an answer and kept things simple and
working for now.

Is there a good reason for not using memblock_mark_nomap() with DT? If
not, I'm happy to try that.

Thanks,
Quentin
