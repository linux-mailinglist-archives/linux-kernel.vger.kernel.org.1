Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0515E231417
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 22:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgG1Ukl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 16:40:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49984 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgG1Ukl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:40:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D21D91C0BDF; Tue, 28 Jul 2020 22:40:38 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:40:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200728204037.GC1012@bug>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
 <20200710125022.alry7wkymalmv3ge@wittgenstein>
 <20200710225934.GA16881@localhost>
 <CAHk-=wipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5WC=KkgAjRRw@mail.gmail.com>
 <20200711210317.GA60425@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711210317.GA60425@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, please make it a "is rust available" automatic config option. The
> > exact same way we already do the compiler versions and check for
> > various availability of compiler flags at config time.
> 
> That sounds even better, and will definitely allow for more testing.
> 
> We just need to make sure that any kernel CI infrastructure tests that
> right away, then, so that failures don't get introduced by a patch from
> someone without a Rust toolchain and not noticed until someone with a
> Rust toolchain tests it.

So... I'm fan of Rust, but while trying to use it one thing was obvious: it
takes _significantly_ longer than C to compile and needs gigabyte a lot of RAM.

Kernel is quite big project, can CI infrastructure handle additional load?

Will developers see significantly longer compile times when Rust is widespread?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
