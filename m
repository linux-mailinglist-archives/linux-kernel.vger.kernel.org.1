Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8342D3E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgLIJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgLIJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:22:47 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:22:07 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c79so634909pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lJ/NDJbgWxcT6fOKhdSAr+cmsq+iCmYq+jJ18WX01uM=;
        b=q4DFmtZmDIeK7nwfYx25OR1+aH2qoW24T+oe6su3FMSA9/oU6eB5lElVij6YaLzIDy
         bPeeEaJoK/BMnOsivoj2a0IY0WUKPgzofs5DHDEqXLgIAg/leBQNRwsUIc3Z6tMseXAI
         yP02oU8PHxkmr+aHihvxvcahuJTggr+8COCyG+jypXD/xxgG52mKgTKMdk4M3PLV1zN1
         QgLX3RGoPAkZjf8VdII79LTEMf3Lho4o3mXkiQgMpSNOiaR0uxL6ShBcCJsz8nv/shsL
         /EOlFd5s60KF8/fyjix6MUZ+TMQnLsOPqqShi0ppfiQNwpgmVgsv0Hf5MW+m3ok7915a
         E2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJ/NDJbgWxcT6fOKhdSAr+cmsq+iCmYq+jJ18WX01uM=;
        b=aRUvzXLqy97UOk8q/W9xv1nEGMKujhJHxxVa0M76SPlVtZ8whfSZyvaKIm2UrJnIGG
         Rw0q2CJiNr1phxY9visTLrwi0n7/GybEB0ma7IvcQqd6dEejBK1wgTwKKiDHMLvFWJdz
         Lr/0jHE0IcvyKgZqYIw6OUBwpuhSMA6BV0OHDXtFB3Tyo5wtSAIXXUaGpKWmab5h8VaC
         YjpJDAA6PR844UXG4ANuQAPsoieCS3wu8Qwm1qcoW+YiNn6KQ+/HtAWj0c8XpFmDtuyn
         h1CxQEhUe66bMfYiFyuP53RoZIO3NbsXnDRGEqeR0OeYlvfbXFymgapY2WV9YDFUYSzb
         sT1g==
X-Gm-Message-State: AOAM533hu6tYZFlGwhTB3SxNoVkts6X0XN8Vyya5frYZcsZlmBppoqVd
        f5Ze8we/YdBH67spRBHKpd8=
X-Google-Smtp-Source: ABdhPJynHp+3TusYEjZjW6pvV7nVcsoGw/4RRSwuBIAQBzpPsUc3f8BKUyCmed/dGJbHCN03pECF8A==
X-Received: by 2002:a62:f901:0:b029:160:b5d:fc40 with SMTP id o1-20020a62f9010000b02901600b5dfc40mr1428247pfh.55.1607505727285;
        Wed, 09 Dec 2020 01:22:07 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id 188sm1711319pfd.188.2020.12.09.01.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:22:06 -0800 (PST)
Date:   Wed, 9 Dec 2020 18:22:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201209092204.GD1667627@google.com>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
 <20201209081623.GI2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209081623.GI2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/09 09:16), Peter Zijlstra wrote:
> On Tue, Dec 08, 2020 at 11:36:44PM +0106, John Ogness wrote:
> > For the state variable we chose atomic_long_t instead of atomic64_t for
> > this reason. atomic_long_t operations are available atomically on all
> > architectures.
> 
> Please put on your eye cancer gear and inspect the atomic implementation
> of PA-RISC, Sparc32, feh, I forgot who else.
> 
> Those SMP capable architectures are gifted with just one XCHG like
> atomic instruction :/ Anyway, as said in the other email, they also
> don't have NMIs so it mostly works.

Hmm, wow. OK, I definitely want to look further.

When some CONFIG_DEBUG_FOO_BAR code wants to pr_err from prb->atomic_op
on those archs then we deadlock in printk once again?

	-ss
