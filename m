Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0E28443B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgJFDXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:23:02 -0400
Received: from smtprelay0062.hostedemail.com ([216.40.44.62]:42854 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgJFDXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:23:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2D810180A8135;
        Tue,  6 Oct 2020 03:23:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6120:6742:7903:8985:9025:10004:10400:10471:10848:11232:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:21811:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: smile39_3a0ca7d271c3
X-Filterd-Recvd-Size: 2790
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 03:22:57 +0000 (UTC)
Message-ID: <1fe3add91c0de96a24460c94725ebc3a352dc22a.camel@perches.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
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
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Mon, 05 Oct 2020 20:22:56 -0700
In-Reply-To: <CACPK8XdwX=1T8WrsVYurL+JedEsb1ZTyrWtJXDLXycu-qu4UTg@mail.gmail.com>
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
         <CACPK8XdwX=1T8WrsVYurL+JedEsb1ZTyrWtJXDLXycu-qu4UTg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 00:34 +0000, Joel Stanley wrote:
> arch/powerpc/boot is the powerpc wrapper, and it's not built with the
> same includes or flags as the rest of the kernel. It doesn't include
> any of the headers in the top level include/ directory for hysterical
> raisins.
> 
> The straightforward fix would be to exclude this directory from your script.

I agree and that's why I submitted another script
that does just that.

https://lore.kernel.org/lkml/75393e5ddc272dc7403de74d645e6c6e0f4e70eb.camel@perches.com/


