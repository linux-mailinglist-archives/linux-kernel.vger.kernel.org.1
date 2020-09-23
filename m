Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07862760E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWTUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWTUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:20:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6EC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:20:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so227264plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kKqcvuGlQ6LG4FDQ95wmTDMpeFrWbr+yPkxJgd66iJ4=;
        b=Ainj+HfyS0rs0jjsdB5fQstwTvarA1MaDFpak3lfGeLgis8DIG/SpaenHTpJlZSiB6
         ztZ104XSE2HIsklsFbly+ee0ReD+HnbehvvRLOQi0yeml0gQY7Dxp+LwlR8W+mmLlN/a
         1mf09IrmGcWorWXFn0A5Ygc54qew0fC0zuMr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKqcvuGlQ6LG4FDQ95wmTDMpeFrWbr+yPkxJgd66iJ4=;
        b=bAZPgLwPHvzusNJLtby71OEStWO/G7koGyucK2ksLpV55Yjv+je5jwg4XTr/d4qqfr
         2WwplIqROt5qruW1noUIuebSgVZRZLfSo6ftlwpwMJWZ2y/P9hDIEGK1tdREQzWVl9dM
         Jzu5ssdR9batyPt5DemaIqyT8VC1a91jCa5HVRWLTswGlQ2w97lBNS2YhgyuNTfgCICy
         Mz3iepACbgfKYFL0TKF9Aozjs8dmb0DHpWW/gQkjuiyOBpRjwhLEnmhynve3aiHRyxPq
         uHILxEPxPC3kv1zqKKa6VjiojPIc37nhH3qbkKGlHxidqBUDM7wOWGVE83Z7P1irS7JT
         nGhw==
X-Gm-Message-State: AOAM530OLf78HFfl3FELSElRyoyVT3SRzkC8DAxCvIUrcE6YvAnOpn0N
        frpwwCn4lgw00glrIdgIZmJ47A==
X-Google-Smtp-Source: ABdhPJxMMPaWoC/wKDISJh44gp4TXRj4T+eHJyURPfFTVKYla8QGGmwQPKFn6Wv5PTSFvigOuex4vQ==
X-Received: by 2002:a17:902:fe10:b029:d2:b7b:be42 with SMTP id g16-20020a170902fe10b02900d20b7bbe42mr1240590plj.69.1600888799613;
        Wed, 23 Sep 2020 12:19:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm258492pjs.47.2020.09.23.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 12:19:58 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:19:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Jann Horn <jannh@google.com>
Subject: Re: x86/irq: Make run_on_irqstack_cond() typesafe
Message-ID: <202009231209.F5F3999D@keescook>
References: <87pn6eb5tv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn6eb5tv.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:58:52AM +0200, Thomas Gleixner wrote:
> -void asm_call_on_stack(void *sp, void *func, void *arg);
> +void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
> +void asm_call_sysvec_on_stack(void *sp, void (*func)(struct pt_regs *regs),
> +			      struct pt_regs *regs);
> +void asm_call_irq_on_stack(void *sp, void (*func)(struct irq_desc *desc),
> +			   struct irq_desc *desc);

Eeeh, err. So, this is nice for the CFI case, but can we instead just
inline asm_call_on_stack() instead? Having any of these as distinct
functions in the kernel is really not safe: it provides a trivial
global stack-pivot[1] function for use in ROP attacks, which is one
of the central requirements for mounting such attacks. This allows a
completely arbitrary sp argument, function, and first argument. :(

Much better would be to keep asm_call_on_stack() as an inline so the
stack pointer is always coming from percpu variables, and to have the
irq_count actually checked (i.e. freak out if it falls below zero to
catch jumps into the middle of a function when an attempt to bypass the
load from the percpu area happens). I would expect this form to be much
robust:

inc
load sp from per-cpu
pivot sp
make call
restore sp
WARN(dec_and_test)


-Kees

[1] https://security.stackexchange.com/questions/44418/return-oriented-programming-how-to-find-a-stack-pivot

-- 
Kees Cook
