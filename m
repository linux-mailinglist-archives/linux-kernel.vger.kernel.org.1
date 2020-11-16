Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCB2B52C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgKPUih convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 15:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgKPUig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:38:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95B5208C3;
        Mon, 16 Nov 2020 20:38:35 +0000 (UTC)
Date:   Mon, 16 Nov 2020 15:38:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] samples/ftrace: mark my_tramp[12]? global
Message-ID: <20201116153834.57ace64e@gandalf.local.home>
In-Reply-To: <CABCJKudNGa2=65vATJMqo--8guvWHZ6-wMWHZQy-ZaH32dXdnA@mail.gmail.com>
References: <20201113183414.1446671-1-samitolvanen@google.com>
        <20201116113931.2b60a191@gandalf.local.home>
        <CABCJKudNGa2=65vATJMqo--8guvWHZ6-wMWHZQy-ZaH32dXdnA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 12:10:10 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Mon, Nov 16, 2020 at 8:39 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 13 Nov 2020 10:34:14 -0800
> > Sami Tolvanen <samitolvanen@google.com> wrote:
> >  
> > > my_tramp[12]? are declared as global functions in C, but they are not
> > > marked global in the inline assembly definition. This mismatch confuses
> > > Clang's Control-Flow Integrity checking. Fix the definitions by adding
> > > .globl.
> > >  
> >
> > Actually, since that function is not really global, would it work if you
> > removed the "extern" from the my_tramp declaration?  
> 
> Unfortunately not, removing the "extern" doesn't seem to change anything.
> 
> > In other words, is there a way to tell C that a function is declared in an
> > inline assembly block?  
> 
> I'm not sure if there's a way to tell C that a static function is
> declared in inline assembly. At least I couldn't find a way that would
> make the compiler happy.

I'm trying to see the warning. What option makes clang trigger a warning on
this?

From user space, I'm just using the following file:

#include <stdio.h>

void my_direct_func(char *str)
{
	printf("%s\n", str);
}

int test(char *str);

asm (
"	.pushsection    .text, \"ax\", @progbits\n"
"	.type		test, @function\n"
"   test:"
"	pushq %rbp\n"
"	movq %rsp, %rbp\n"
"	pushq %rdi\n"
"	call my_direct_func\n"
"	popq %rdi\n"
"	leave\n"
"	ret\n"
"	.size		test, .-test\n"
"	.popsection\n"
);

int main (int argc, char **argv)
{
	test("hello");
	return 0;
}

