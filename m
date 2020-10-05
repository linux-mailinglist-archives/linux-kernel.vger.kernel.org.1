Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA83283EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgJESq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:46:59 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:58712 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbgJESq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:46:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 27638121A;
        Mon,  5 Oct 2020 18:46:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:6120:6742:10004:10400:10471:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13255:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sense91_3616e57271c0
X-Filterd-Recvd-Size: 2564
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 18:46:55 +0000 (UTC)
Message-ID: <64ccf7f562b753572b123d747c43222eb99378f8.camel@perches.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Mon, 05 Oct 2020 11:46:54 -0700
In-Reply-To: <CAKwvOdmW4ZSo0yz9ZUjFhjzzDkNAghKYk_hxn9tvrKLBgCXx-A@mail.gmail.com>
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
         <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
         <CAKwvOdmW4ZSo0yz9ZUjFhjzzDkNAghKYk_hxn9tvrKLBgCXx-A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-05 at 11:36 -0700, Nick Desaulniers wrote:
> I don't think there's anything wrong with manually including it and adding `-I
> <path>` (capital i) if needed.

All of this is secondary to the actual change to use
quoted __section("foo") rather than __section(foo)

I'd rather get that done first and then figure out if
additional changes could be done later.



