Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83154280854
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgJAUTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:19:23 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:60940 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgJAUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:19:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 283CD180A7FF8;
        Thu,  1 Oct 2020 20:19:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:4321:5007:6120:6742:9040:9108:10004:10400:10471:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14180:14659:14721:21060:21080:21433:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mice75_5c06f2d2719e
X-Filterd-Recvd-Size: 2850
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 20:19:19 +0000 (UTC)
Message-ID: <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Date:   Thu, 01 Oct 2020 13:19:18 -0700
In-Reply-To: <20201001193937.GM28786@gate.crashing.org>
References: <20200929192549.501516-1-ndesaulniers@google.com>
         <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
         <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
         <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
         <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
         <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
         <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
         <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
         <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
         <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
         <20201001193937.GM28786@gate.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-01 at 14:39 -0500, Segher Boessenkool wrch/ote:
> Hi!
> 
> On Thu, Oct 01, 2020 at 12:15:39PM +0200, Miguel Ojeda wrote:
> > > So it looks like the best option is to exclude these
> > > 2 files from conversion.
> > 
> > Agreed. Nevertheless, is there any reason arch/powerpc/* should not be
> > compiling cleanly with compiler.h? (CC'ing the rest of the PowerPC
> > reviewers and ML).
> 
> You need to #include compiler_types.h to get this #define?

Actually no, you need to add

#include <linux/compiler_attributes.h>

to both files and then it builds properly.

Ideally though nothing should include this file directly.

> (The twice-defined thing is a warning, not an error.  It should be fixed
> of course, but it is less important; although it may be pointing to a
> deeper problem.)
> 
> 
> Segher

