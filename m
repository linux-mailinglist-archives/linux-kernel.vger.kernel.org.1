Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3329060A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406133AbgJPNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405491AbgJPNJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:09:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939CCC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:09:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r4so3762958ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yp8oGC1qLJa3fVmY6JrC1L9UJhRc84mqlHy8af6Cn50=;
        b=l5JkWgGpacumvqPaV9GL7UyK6GQcOZY8H4dNN+Qg3JHFbnAIj42mT1eKzEeBqeL3uL
         4euKtKyWVXYmonZ3uaZ2gSdjzyyr+ovhJaVKdwf3hA4coqbKFRi9vusmH+/7/zGQtRlV
         DhLMDsGx/2eM9PiiXIYDRoPy0xS97kTU8fXWNKn3RSL8EHRnFZEcUihYHB4Xy5QWHSfO
         OkqY2tWGrOeSNIV5kOF2stIW2h4prSCuYqoRVCg4p/5P7/R2mQTlsIIGbvVLXnyNHeUj
         VKG/7Lm1+BL71BOHXvr36wuwA3EByPclwByWyKbu1Sn9y7NT6jyWbyRNtYpTmyk7n2mK
         on7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Yp8oGC1qLJa3fVmY6JrC1L9UJhRc84mqlHy8af6Cn50=;
        b=LWVOs6MUsTYbhIKWnXjzsW7Rf/oc4znyriLYNhc2UaV0rYZRDBa0VucODvfmgufxL/
         zuLz8B6psmIcdy768g9F9frz49fHm5ZWiMIjKEiZqsuAbDegNheqBXQ8fBJkzWUP3KFY
         Z+OmyvGGjx0UMT1VMOIyvkjAD/1dNLxdE3Gx0t55v1ow+GRFpEfVXE2Zbzk1KQDCOcMM
         UllXijwrquqqceB4++/iBoXpujp7c8z5GaDOuBFjDxCL48Y/2pGtiHzso7m13cQ/EqDx
         pzgX9SgNKsYncR+gaf1ibUIY07PvTxEfIt0h5EwCBvoYL/gQ1wmDUawfzFAEjEafj81z
         LyJg==
X-Gm-Message-State: AOAM530lgPcuRCjfeVcqhztlvtp422qixKUD8U2G7IidAMI0j5oIrrc4
        3K0Mpd6CXj9y7G8jjz6ZvVo=
X-Google-Smtp-Source: ABdhPJwVovhppXP9bDarC44xLG0zchRIUopGJMfHTlXhMW/Hq6a3Nz6EKe13qUvOX3kpdFktOF466A==
X-Received: by 2002:a05:6602:c2:: with SMTP id z2mr2246377ioe.81.1602853781839;
        Fri, 16 Oct 2020 06:09:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h14sm1980212ilc.38.2020.10.16.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 06:09:41 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 16 Oct 2020 09:09:39 -0400
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compiler.h: Clarify comment about the need for
 barrier_data()
Message-ID: <20201016130939.GB1040839@rani.riverdale.lan>
References: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
 <20201015181340.653004-1-nivedita@alum.mit.edu>
 <72958fd25e33490181b0df9413ec08b4@AcuMS.aculab.com>
 <20201015220123.GA919128@rani.riverdale.lan>
 <407e91d1d36d48faa8bbdfe4f51033ad@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <407e91d1d36d48faa8bbdfe4f51033ad@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:13:44AM +0000, David Laight wrote:
> From: Arvind Sankar
> > Sent: 15 October 2020 23:01
> ,,,
> > I think it's helpful to have the more detailed explanation about
> > register variables -- at first glance, it's a bit mystifying as to why
> > the compiler would think that the asm can't access the stack. Spilling
> > registers to the stack is actually an undesirable side-effect of the
> > workaround.
> 
> That is the very bit that just confuses things.
> The data the memzero_explictit() is trying to clear is (probably)
> on-stack already - it won't be in registers.
> 

Are you saying the explanation is confusing things?

What I think is confusing is the fact that the compiler believes that an
asm with a memory clobber cannot access a variable that happens to be in
memory, and the comment is explaining how the compiler came to that
conclusion. The comment is already saying that this applies to LLVM
(unlike GCC) even if the variable isn't actually in registers.

> If it were in registers you wouldn't need the memset().

There's obviously no guarantee of where the compiler decided to keep the
variables. This isn't so clear-cut: for SHA, there is a 256-byte array
that you can be pretty sure will be in memory, but there are also 10 u32
variables which may or may not be in registers depending on how many
registers the arch has and how clever the compiler was in allocating
them.

> 
> Actually I suspect that the memset() is inlined so that is
> just assigns zeros to all the variables.
> This will be done using 'virtual registers' that cache the
> on-stack value.
> You then need to do something to force the instructions to flush
> the 'virtual registers' back to stack to be generated.

This is definitely getting too much into the weeds. What the compiler
knows is that memset does nothing other than writing to the variable,
and if the variable is never used after that, then the memset can be
eliminated.  Whether the memset ends up getting inlined or not is not
relevant here: clang doesn't inline it, for eg.
