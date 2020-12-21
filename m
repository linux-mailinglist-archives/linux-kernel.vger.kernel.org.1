Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE22E0206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgLUVXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLUVXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:23:44 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00373C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:23:03 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 7so7674208qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hvt27dTXDiSjMU6MIcLPLG5yEyjYiKStuEJMa1eqpVM=;
        b=ADjHnaygiDeqRjgU2aRMkXr7J5W/tzZ5K52ugZR6Pas3mXN0y/mRa6WAp/Uqf0cY0i
         b7fvBrnGBjrt6QmGSTq0nKqwhOt4u6Hv1JSwIYST9Jd1/1Tnnc9+Xgjz8+5xolSVNaTz
         YEkqIRAnsrI6U+mKUFMVFkLD4Oi8ziAL2bbd2D9zznutIcqsDVZK56VqYFxJ+7ISAHH3
         fReRQYTq8bEBX27sWsQYytUfGGuZb/TZyJ+hKKoJ5OShy456UU80+S/F82saK65wCp3b
         /Jxf7V8Q5wnNC69O2UF+NW81ausjfk7T1q1AdY1apZQh2lpSIqm6dtjXeygSEpovSaQi
         hONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hvt27dTXDiSjMU6MIcLPLG5yEyjYiKStuEJMa1eqpVM=;
        b=tcgMuVA969Gg+UpWmZS+YqJOP53aMQb1iHYT1JChXvz0+dKgrrixHyYxBaZ90gv5Xd
         hVIHQUCZ+5/4Tmv7JCYeQPgZV6CjnWHM+YoAYR/2EAvWdCmFSIi9MlhlXgjWrz74JPdj
         PC/jgNXemO3j1fRsVzYcuSY5/FF5nsXzUi11DpE6Z3J5qqqhFS+aQxWmJLsqTHpf7q1K
         5YI60QNX456uxPaiklf3t/0dc+6qHC0W1D3PGQMkmEc6aIXLjeBnggxldbmKNfkB3kuS
         jTTCRniz4uQEGtVvXOlL8FrPNH6N5piB9lBQhzDI4UmeWXi47IIukfg+km0e2jB2HCuf
         dBBg==
X-Gm-Message-State: AOAM531Vo5vPx5bfpcC5Qeny6rGBBKPOygjYYgSBs2XZcJWCLOVGBS9A
        AH6pExtycP8B8uyMaFly3uc=
X-Google-Smtp-Source: ABdhPJx25tQ4SHAkInOq5XlAttX99/xXCC3l8CpjvpnKkVeRfUhVrpgBNF0bgPfyY3yy7XCjRFQb1w==
X-Received: by 2002:ac8:3a63:: with SMTP id w90mr18297507qte.225.1608585783083;
        Mon, 21 Dec 2020 13:23:03 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l1sm11461151qtb.42.2020.12.21.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:23:02 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 21 Dec 2020 16:23:00 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cmdline: Disable jump tables for cmdline.c
Message-ID: <X+ESNP6HdYQpd7g3@rani.riverdale.lan>
References: <20200903023056.3914690-1-nivedita@alum.mit.edu>
 <CAKwvOdm8qUpueOdO7e-rQotO5UynrgU2TZ9DEe=O4f9eU5EY0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm8qUpueOdO7e-rQotO5UynrgU2TZ9DEe=O4f9eU5EY0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:14:39AM -0800, Nick Desaulniers wrote:
> On Wed, Sep 2, 2020 at 7:31 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > When CONFIG_RETPOLINE is disabled, Clang uses a jump table for the
> > switch statement in cmdline_find_option (jump tables are disabled when
> > CONFIG_RETPOLINE is enabled). This function is called very early in boot
> > from sme_enable() if CONFIG_AMD_MEM_ENCRYPT is enabled. At this time,
> 
> Hi Arvind, sorry I missed this when you first sent it.  I'm going
> through and mass deleting my inbox (email bankruptcy) but noticed
> this.  I couldn't reproduce jump tables in cmdline_find_option with
> CONFIG_RETPOLINE disabled but CONFIG_AMD_MEM_ENCRYPT on today's
> linux-next. Can you please confirm that this is still an issue? I will
> reread the disassembly, but it looks like a bunch of cmp/test+jumps.
> 

The patch got merged and is in v5.10 -- are you testing with it reverted
or just plain linux-next?
