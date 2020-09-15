Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BDB269EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIOG4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgIOG4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:56:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:56:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so1776923ljj.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RifvNOOLyJbnwbwVWOF+enDD+qjD5Fjm0V/Mfqvmyes=;
        b=Ok+Gb7RSq0mYYx+0CWHlM3W78iPr+yr7ivPGBVwnLh/BuOKWy90Ma/i2VS7Q/jgtxO
         oCFqkSrxTfPbvmX64o7DrS7NwjwgR6qJ0V22sjaC6EXlUfruJNf2BmK+Jx03F/RbiG0I
         nXGxWy47Pu87zH1DeP3m4W32SIPgIILk7JZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RifvNOOLyJbnwbwVWOF+enDD+qjD5Fjm0V/Mfqvmyes=;
        b=Y8uGD24ocRWGSLZxfKjRoUCxHE+UMFCS406qcrgC9DDuic7hHiyY34qYxQXuJxptGC
         E/p8vSwqTpSwR+8kuArlxUjO/rCbDq+MY2/nFYmiiRHfAWHRXlS+LYVJB+vCRWlesT8n
         YdFx/kg1eopxWtnWkjBILit2iwa/iPD+7Gdi4vl7YSsYbdfYlGwsKzb52NDhD1XiOCgd
         2exoRzSpuF895pkp3q+HGyVonJOvQ3kMmyyC5y2cflmcIsHCElyUU7jWFuYf9r+Iiqj6
         r0GLoKPi1dJMpWXczOO3MKk9hMwOVYFxT1g43b4anFcRy9VJsYPaasazho3Cx+fpwBSL
         wf/Q==
X-Gm-Message-State: AOAM532p/wBuVSFX8emjhSF+beV8XhfcDDdTgpddqzZnwPGp48TTxQBW
        WXACtbsjYdUn2km5vKDNVR6u0oAk0mNddQ==
X-Google-Smtp-Source: ABdhPJyATuzPRwMqlZdRAj3DYdfp/PzOFzVqFShfg5+WVxHmKLH6XN28kIqGuseLOt/htFJtZ9KDGA==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr5977088lji.247.1600152971188;
        Mon, 14 Sep 2020 23:56:11 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h25sm3806112lfl.273.2020.09.14.23.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 23:56:10 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id n25so1827754ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:56:10 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr5956337ljc.371.1600152969778;
 Mon, 14 Sep 2020 23:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com>
 <20200915033024.GB25789@gondor.apana.org.au> <CAHk-=wgX=ynJAXYYOAM7J8Tee8acERrGOopNu6ZcLN=SEXdGKA@mail.gmail.com>
In-Reply-To: <CAHk-=wgX=ynJAXYYOAM7J8Tee8acERrGOopNu6ZcLN=SEXdGKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 23:55:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wie0Kb-+XOZNasoay7AKCaQ8Ew8=LyvWTBeiPXC3v2GSA@mail.gmail.com>
Message-ID: <CAHk-=wie0Kb-+XOZNasoay7AKCaQ8Ew8=LyvWTBeiPXC3v2GSA@mail.gmail.com>
Subject: Re: [PATCH] crypto: lib/chacha20poly1305 - Set SG_MITER_ATOMIC unconditionally
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I mean, I did find one case that didn't set it (cb710-mmc.c), but
> pattern-matching to the other mmc cases, that one looks like it
> _should_ have set the atomic flag like everybody else did.

Oh, and immediately after sending that out I notice
nvmet_bdev_execute_rw(), which does seem to make allocations inside
that sg_miter loop.

So those non-atomic cases do clearly exist.

It does make the case for why kmap_atomic() wants to have the
debugging code. It will "just work" on 64-bit to do it wrong, because
the address doesn't become invalid just because you sleep or get
rescheduled. But then the code that every developer tests (since
developers tend to run on good hardware) might be completely broken on
bad old hardware.

Maybe we could hide it behind a debug option, at least.

Or, alterantively, introduce a new "debug_preempt_count" that doesn't
actually disable preemption, but warns about actual sleeping
operations..

             Linus
