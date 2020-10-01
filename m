Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696BD28080C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgJATtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:49:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:34939 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgJATtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:49:46 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 091Jdd8m014394;
        Thu, 1 Oct 2020 14:39:39 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 091Jdccq014393;
        Thu, 1 Oct 2020 14:39:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 1 Oct 2020 14:39:37 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of __section(foo) to __section("foo")
Message-ID: <20201001193937.GM28786@gate.crashing.org>
References: <20200929192549.501516-1-ndesaulniers@google.com> <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com> <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com> <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com> <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com> <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com> <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com> <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com> <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com> <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Oct 01, 2020 at 12:15:39PM +0200, Miguel Ojeda wrote:
> > So it looks like the best option is to exclude these
> > 2 files from conversion.
> 
> Agreed. Nevertheless, is there any reason arch/powerpc/* should not be
> compiling cleanly with compiler.h? (CC'ing the rest of the PowerPC
> reviewers and ML).

You need to #include compiler_types.h to get this #define?

(The twice-defined thing is a warning, not an error.  It should be fixed
of course, but it is less important; although it may be pointing to a
deeper problem.)


Segher
