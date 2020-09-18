Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB82708FE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRWkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 18:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIRWkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 18:40:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A41C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 15:40:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n18so6545889qtw.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=es6nlpMnUB0/QWXaKLyRiwxeJ49wlctuXlJpG4K6HaM=;
        b=Cv+KobsWzYG75r7cZiugx4mWU3cn+OCwM+12M5mVbeCY/pV2gRAV7BWtd5cthNJGiV
         qvCbPN6WJwrh9INuPDca4XD9h45s84N87p+cCbh+fVMfX1YMLhVaK7q9Xb20dkIwZ1ZL
         DtpdtLqqMjVmEs6PxzDz3nUCrVTIjzgM20D1KToiRaScrRH1VnYPN2aCu4G6f2dpkrn0
         0lvKbB7KNdQkTHswv53i7n9aToY3gtdDOOlTjFG3H6hNZnyM9gYoRIN3rTQ67HIAlIf/
         xjbLcyzBoduV8cRlL6i1zQ2MgAWagb0BXo0vI+g7h2KNdPsCBaNoTZToTIi7MocbWveW
         fveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=es6nlpMnUB0/QWXaKLyRiwxeJ49wlctuXlJpG4K6HaM=;
        b=OPyWVVJmhsfVmAxXue93FshJR5t53/K7qrdE+k9lDUeJkpadY617UT+mfz1tk+ywuI
         P/iaxlg0QWIn2ylCeU1ElRXr8I1aP/VhQHbOF/xZSm7FVVgedkdYW1bT0loIh3hbGDMe
         AOUK+3qCRWZbn1xRe4S/MUUk6ynScZzKCmPnru0MczBnLS/Vi4U1izc18+TQG+L9SJhj
         VYH6CLAumH+kAWCXHnNtmrhaI29Ge/uawENnCyjDB6vy4jktXxx34xqfCdwhGgXUDGDW
         T+VyIuRHXxhrXy9pxNX51c98hIJ0zevMftnZ8e6OBJh92ZN+wYuJ4C/g7Th3Lr1a+jIi
         JFJA==
X-Gm-Message-State: AOAM532Zwh5grmbGZM3k23NfCUc3vWNsameA3XGyypBF8Gx0IJeFWs1P
        9kICixnjVeLaYMf1ljjDDJc=
X-Google-Smtp-Source: ABdhPJwA6lfuOUEZisRe5dar8OcYP03cG9uD7Vk9P3dwKhG/Em2LlaJceNq+u0nEcqObocyWkCZo2w==
X-Received: by 2002:ac8:4d07:: with SMTP id w7mr35735943qtv.243.1600468800475;
        Fri, 18 Sep 2020 15:40:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m64sm3038264qkd.80.2020.09.18.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 15:39:59 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 18 Sep 2020 18:39:57 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918223957.GA2964553@rani.riverdale.lan>
References: <20200918162305.GB25599@embeddedor>
 <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
 <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
 <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan>
 <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan>
 <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 02:18:20PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 2:00 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > You could just assert that offsetof(typeof(s),flex) == sizeof(s), no?
> 
> No, because the whole point is that I want that "sizeof(s)" to *WARN*.
> 
> It's a nonsensical thing to do. That 's' has no statically known size.
> 
> The C standard is being very confused here, in that it tries to claim
> that the flexible arrays are somehow fundamentally different from a
> zero-sized one. But then it acts as if they are exactly the same wrt
> sizeof() and structure copies.
> 
> It should warn, exactly because right now it causes potential bugs
> like the one that started this thread.
> 
> You can't have both "zero-sized arrays are bad and shouldn't be used"
> and "flexible arrays are good, and work exactly like zero-sized
> arrays".
> 
> Either zero-sized arrays are bad or they aren't. And if they are bad,
> then flexible arrays shouldn't work *exactly* like them apart from
> some UBSAN warnings.
> 
> See my point?
> 
>              Linus

Ouch, offsetof() and sizeof() will give different results in the
presence of alignment padding.

https://godbolt.org/z/rqnxTK

I think, grepping at random, that at least struct scsi_vpd is like this,
size is 24 but data[] starts at offset 20.

	struct scsi_vpd {
		struct rcu_head	rcu;
		int		len;
		unsigned char	data[];
	};
