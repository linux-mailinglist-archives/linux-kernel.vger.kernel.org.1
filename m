Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F826295257
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504300AbgJUSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:35:36 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:51810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504248AbgJUSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:35:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CDAE918224D70;
        Wed, 21 Oct 2020 18:35:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1543:1593:1594:1711:1730:1747:1777:1792:1801:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6120:6742:7901:9121:10004:10400:10848:11026:11232:11233:11658:11914:12043:12048:12297:12438:12740:12760:12895:13439:13972:14096:14097:14181:14659:14721:21080:21451:21627:30054:30056:30079:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: air39_5f006092724a
X-Filterd-Recvd-Size: 5767
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 18:35:25 +0000 (UTC)
Message-ID: <3ec15b41754b01666d94b76ce51b9832c2dd577a.camel@perches.com>
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, Aditya <yashsri421@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKP <lkp@lists.01.org>, Kees Cook <keescook@chromium.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-toolchains@vger.kernel.org
Date:   Wed, 21 Oct 2020 11:35:23 -0700
In-Reply-To: <CANiq72m+_QYtn_1gyrjXFs6yeDdiMoS4DVcWqYcTgyCFnSFXbw@mail.gmail.com>
References: <20200629003127.GB5535@shao2-debian>
         <20200630124628.GV4817@hirez.programming.kicks-ass.net>
         <20200630144905.GX4817@hirez.programming.kicks-ass.net>
         <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
         <20201021080031.GY2628@hirez.programming.kicks-ass.net>
         <20201021131806.GA2176@tucnak>
         <20201021134436.GJ2628@hirez.programming.kicks-ass.net>
         <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
         <CANiq72m+_QYtn_1gyrjXFs6yeDdiMoS4DVcWqYcTgyCFnSFXbw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding cc's of kernel-mentees and a few checkpatch contributors)

On Wed, 2020-10-21 at 19:54 +0200, Miguel Ojeda wrote:
> On Wed, Oct 21, 2020 at 7:42 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > If you used some of the macros from
> > include/linux/compiler_attributes.h like __section and __aligned, I
> > would prefer it.  Please consider spelling out __attribute__(()) an
> > antipattern.
> 
> +1, the shorthands should be used unless there is a reason not to (and
> please write the reason in a comment in that case).

Perhaps something to add as a generic test in checkpatch.

Right now it checks separately for each __attribute__
use with any of aligned, section, printf and scanf.

Likely it should include more of the #defines from
include/linux/compiler_attributes.h.

include/linux/compiler_attributes.h:#define __alias(symbol)                 __attribute__((__alias__(#symbol)))
include/linux/compiler_attributes.h:#define __aligned(x)                    __attribute__((__aligned__(x)))
include/linux/compiler_attributes.h:#define __aligned_largest               __attribute__((__aligned__))
include/linux/compiler_attributes.h:#define __always_inline                 inline __attribute__((__always_inline__))
include/linux/compiler_attributes.h:# define __assume_aligned(a, ...)       __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
include/linux/compiler_attributes.h:#define __cold                          __attribute__((__cold__))
include/linux/compiler_attributes.h:#define __attribute_const__             __attribute__((__const__))
include/linux/compiler_attributes.h:# define __copy(symbol)                 __attribute__((__copy__(symbol)))
include/linux/compiler_attributes.h:# define __designated_init              __attribute__((__designated_init__))
include/linux/compiler_attributes.h:# define __visible                      __attribute__((__externally_visible__))
include/linux/compiler_attributes.h:#define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
include/linux/compiler_attributes.h:#define __scanf(a, b)                   __attribute__((__format__(scanf, a, b)))
include/linux/compiler_attributes.h:#define __gnu_inline                    __attribute__((__gnu_inline__))
include/linux/compiler_attributes.h:#define __malloc                        __attribute__((__malloc__))
include/linux/compiler_attributes.h:#define __mode(x)                       __attribute__((__mode__(x)))
include/linux/compiler_attributes.h:# define __no_caller_saved_registers        __attribute__((__no_caller_saved_registers__))
include/linux/compiler_attributes.h:# define __noclone                      __attribute__((__noclone__))
include/linux/compiler_attributes.h:# define fallthrough                    __attribute__((__fallthrough__))
include/linux/compiler_attributes.h:#define   noinline                      __attribute__((__noinline__))
include/linux/compiler_attributes.h:# define __nonstring                    __attribute__((__nonstring__))
include/linux/compiler_attributes.h:#define __noreturn                      __attribute__((__noreturn__))
include/linux/compiler_attributes.h:#define __packed                        __attribute__((__packed__))
include/linux/compiler_attributes.h:#define __pure                          __attribute__((__pure__))
include/linux/compiler_attributes.h:#define __section(S)                    __attribute__((__section__(#S)))
include/linux/compiler_attributes.h:#define __always_unused                 __attribute__((__unused__))
include/linux/compiler_attributes.h:#define __maybe_unused                  __attribute__((__unused__))
include/linux/compiler_attributes.h:#define __used                          __attribute__((__used__))
include/linux/compiler_attributes.h:#define __weak                          __attribute__((__weak__))


