Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF34E26952F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgINStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgINStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:49:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF470C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:49:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so1480605ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNLJ+xjVvOMpCmSdVCa36PkRJx42dV1m6nWMcfy3Glo=;
        b=wFfqFtYMOLI+0jTr1Ju46hgUfEjxynPRcCieujDSTYPQLO3Wz7Cb0Rs9Vah5e73rtv
         XQdQtmK3qvGtjdCiQgNDRhEGZJiwtxY/J6R/WOTGNCGSqzCFmjiRgxR1O4kB7OvkyrAC
         z/Rr65zwnnGTVClj/Rd/Z9od9eQfOhs/onK9rH0bn9BVvfYYrv5/KAb6715waA5HOXX+
         //dfl/hE0zs+XivvUe+jX8QEzv0w3JgunUKQuhaAVeXg8ff5i1geWCXNByBWz58oJygN
         gvZriXMB6vq6+0pbrUsGxpTMwQOvHE3EV6tI4fiJv00lR+xO3ti/beabAFmq2hzcyrnL
         Di0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNLJ+xjVvOMpCmSdVCa36PkRJx42dV1m6nWMcfy3Glo=;
        b=PGG2c9c/zETr++fj8d/Uzg4hW4xynDlGqo9/uSw3weXQ4CB7k9GqN0mQD7R3Quf+dW
         kWjsNjAAU2rQF/LGb20iYTOx4sK9U/RfKHGO2qnMG6JOCZe56w2lIYrQ06BV/OUxqnKN
         N7i+PmuOFEzLYDUKyG0jsKFwAPw4FF/SYT43NXVsMpBbhGsJBK8Cvi2vD+RDkNiHadkw
         dy1EIVNa95OS4J8RfwfcrOx/GLAo4L2Rud0eWhAUdRzP8TXRA7lTTQXq6fm7SM5t2nqO
         UFLqyske0iFlyjKf++B09ejavvi6yH8pioi3SNuq7yrRMIoxwegWidk6rSzC/MI2E6fG
         WSug==
X-Gm-Message-State: AOAM530BeI+QZ2cZjZPypzlEQM7q3CeIirHbkijPw8iIACja5pZJXNzl
        /p5I7/k+DF0d3pLsGEqts3T3xmJEaDU3zGN/s2nf0PWJ9ro=
X-Google-Smtp-Source: ABdhPJyQc42CNpKB/uvcBWCzbEhFPJVjqubuleFZPmg0KttJXoHjk6uL8u2I35aisclmSe/0Gr6qtMTDuYA+Ch/b2JY=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr15831636ejw.323.1600109346470;
 Mon, 14 Sep 2020 11:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
In-Reply-To: <20200914175604.GF680@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Sep 2020 11:48:55 -0700
Message-ID: <CAPcyv4hqxs1zuXb5jkA-6Fm72Vu0ZDCfqeWJKSePM+zFyY9kzg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess speculation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Sep 10, 2020 at 12:22:53PM -0500, Josh Poimboeuf wrote:
> > +/*
> > + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> > + * pointer.  This prevents speculative dereferences of user-controlled pointers
> > + * to kernel space when access_ok() speculatively returns true.  This should be
> > + * done *after* access_ok(), to avoid affecting error handling behavior.
>
> Err, stupid question: can this macro then be folded into access_ok() so
> that you don't have to touch so many places and the check can happen
> automatically?

I think that ends up with more changes because it changes the flow of
access_ok() from returning a boolean to returning a modified user
address that can be used in the speculative path.
