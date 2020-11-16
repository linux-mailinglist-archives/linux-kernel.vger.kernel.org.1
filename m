Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47E22B53A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgKPVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKPVSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:18:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937B122240;
        Mon, 16 Nov 2020 21:18:20 +0000 (UTC)
Date:   Mon, 16 Nov 2020 16:18:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] samples/ftrace: mark my_tramp[12]? global
Message-ID: <20201116161819.040408dd@gandalf.local.home>
In-Reply-To: <CABCJKufdFmoEEmx1-P_0d6vE6TOoDwJ43mq8eCQNQZ7rb0PxPQ@mail.gmail.com>
References: <20201113183414.1446671-1-samitolvanen@google.com>
        <20201116113931.2b60a191@gandalf.local.home>
        <CABCJKudNGa2=65vATJMqo--8guvWHZ6-wMWHZQy-ZaH32dXdnA@mail.gmail.com>
        <20201116153834.57ace64e@gandalf.local.home>
        <CABCJKufdFmoEEmx1-P_0d6vE6TOoDwJ43mq8eCQNQZ7rb0PxPQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 13:10:57 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> Clang doesn't warn about this as we're building a module, it just
> generates a reference to a non-existing global "my_tramp" symbol,
> because the one defined in inline assembly has a local binding:
> 
> $ readelf --symbols --wide ftrace-direct.lto.o | grep my_tramp
>     16: 0000000000000000    13 FUNC    LOCAL  DEFAULT    1 my_tramp
>     33: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND my_tramp
>     42: 0000000000000000     8 FUNC    GLOBAL HIDDEN     8 my_tramp.cfi_jt
> 
> This would prevent the module from loading, which modpost catches:
> 
> ERROR: modpost: "my_tramp" [samples/ftrace/ftrace-direct.ko] undefined!
> 
> > From user space, I'm just using the following file:  
> 
> As this error happens only with Control-Flow Integrity, we need to
> take the address of the "test" function to force the compiler to
> generate a jump table entry for it. Here's a slightly tweaked
> stand-alone reproducer:
> 
> https://godbolt.org/z/GnzjE4

Thanks, we don't need to look more into this. It was mostly my curiosity to
find a way to have the compiler know about a function declared statically
in inline assembly. Maybe I'm asking for too much ;-)

I'll take your original patch. Does it need to go to stable, or is this not
that big of an issue to allow it to be added in the next merge window?

-- Steve
