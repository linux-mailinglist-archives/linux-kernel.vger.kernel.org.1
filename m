Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D679A27F591
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgI3W4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:56:10 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:43440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731870AbgI3W4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:56:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 45BDB181D330D;
        Wed, 30 Sep 2020 22:56:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:152:355:379:599:800:857:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:1801:1981:2194:2198:2199:2200:2393:2525:2553:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4049:4119:4321:4384:4605:5007:6119:6120:6742:7875:7903:9010:9025:9108:9121:10004:10394:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12895:12986:13255:13894:14659:21080:21433:21451:21627:21740:21773:21789:21811:21939:30025:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: home48_220463127196
X-Filterd-Recvd-Size: 8288
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 22:56:06 +0000 (UTC)
Message-ID: <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 30 Sep 2020 15:56:05 -0700
In-Reply-To: <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
         <20200929192549.501516-1-ndesaulniers@google.com>
         <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
         <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
         <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
         <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
         <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
         <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
         <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 15:25 -0700, Joe Perches wrote:
> On Wed, 2020-09-30 at 15:20 -0700, Nick Desaulniers wrote:
> > On Wed, Sep 30, 2020 at 3:06 PM Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2020-09-30 at 14:40 -0700, Nick Desaulniers wrote:
> > > > On Wed, Sep 30, 2020 at 12:16 PM Joe Perches <joe@perches.com> wrote:
> > > > > Use a more generic form for __section that requires quotes to avoid
> > > > > complications with clang and gcc differences.
> > > > > 
> > > > > Remove the quote operator # from compiler_attributes.h __section macro.
> > > > > 
> > > > > Convert all unquoted __section(foo) uses to quoted __section("foo").
> > > > > Also convert __attribute__((section("foo"))) uses to __section("foo")
> > > > > even if the __attribute__ has multiple list entry forms.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > > ---
> > > > > 
> > > > > This is the current output from the script against next-20200930
> > > > > attached in this link:
> > > > > 
> > > > > https://lore.kernel.org/lkml/0e582a7f5144a33f465978d97701f9b3dcc377f3.camel@perches.com/
> > > > > 
> > > > > It might be useful to run the script immediately before
> > > > > the next -rc1.
> > > > 
> > > > $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
> > > > powernv_defconfig
> > > > $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
> > > > ...
> > > > arch/powerpc/boot/main.c:193:44: error: expected ';' after top level declarator
> > > > static char cmdline[BOOT_COMMAND_LINE_SIZE]
> > > 
> > > The script does not convert files in
> > > 
> > >         scripts/
> > >         tools/
> > >         uapi/
> > >         and include/linux/compiler_attributes.h
> > > 
> > > It otherwise assumes that any __attribute__((__section__
> > > use should be converted to __section.
> > > 
> > > If this ppc file is the only file outside of the
> > > listed exclusions, I can either exclude it directly
> > > or add compiler.h to it.
> > > 
> > > You have a preference?
> > 
> > If compiler_types.h which includes compiler_attributes.h is being
> > implicitly including by Kbuild add `-include` flags to most
> > translation units in the kernel, it would be nice to be able to use it
> > everywhere.  I consider open coded __attribute__'s a portability bug.
> > So including the header in arch/powerpc/boot/*.c would be my
> > preference.
> > 
> > > Perhaps these are also possible files that need exclusions:
> > > 
> > > ./arch/x86/boot/video.h:#define __videocard struct card_info __section(".videocards") __attribute__((used))
> > > ./arch/x86/boot/compressed/pgtable_64.c:unsigned long *trampoline_32bit __section(".data");
> > > ./arch/x86/boot/tty.c:static void __section(".inittext") serial_putchar(int ch)
> > > ./arch/x86/boot/tty.c:static void __section(".inittext") bios_putchar(int ch)
> > > ./arch/x86/boot/tty.c:void __section(".inittext") putchar(int ch)
> > > ./arch/x86/boot/tty.c:void __section(".inittext") puts(const char *str)
> > > ./arch/s390/boot/startup.c:static struct diag210 _diag210_tmp_dma __section(".dma.data");
> > > ./arch/powerpc/boot/main.c:     __section("__builtin_cmdline");
> > > ./arch/powerpc/boot/ps3.c:      __section("__builtin_cmdline");
> > > 
> > > 
> 
> no ppc cross compiler here, so can't test but maybe:
> ---
>  arch/powerpc/boot/main.c | 2 ++
>  arch/powerpc/boot/ps3.c  | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
> index 6a5b937a7f5c..ce6e27798f79 100644
> --- a/arch/powerpc/boot/main.c
> +++ b/arch/powerpc/boot/main.c
> @@ -6,6 +6,8 @@
>   */
>  #include <stdarg.h>
>  #include <stddef.h>
> +#include <linux/compiler.h>
> +
>  #include "elf.h"
>  #include "page.h"
>  #include "string.h"
> diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
> index a71714b454b1..86ca9c30562a 100644
> --- a/arch/powerpc/boot/ps3.c
> +++ b/arch/powerpc/boot/ps3.c
> @@ -8,6 +8,8 @@
>  
>  #include <stdarg.h>
>  #include <stddef.h>
> +#include <linux/compiler.h>
> +
>  #include "types.h"
>  #include "elf.h"
>  #include "string.h"
> 
> 

So I installed the powerpc cross compiler, and
nope, that doesn't work, it makes a mess.

So it looks like the best option is to exclude these
2 files from conversion.

  BOOTCC  arch/powerpc/boot/main.o
In file included from ./include/linux/kcsan-checks.h:7,
                 from ./include/asm-generic/rwonce.h:27,
                 from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:232,
                 from arch/powerpc/boot/main.c:9:
./include/linux/compiler_attributes.h:64: warning: "__always_inline" redefined
   64 | #define __always_inline                 inline __attribute__((__always_inline__))
      | 
In file included from ./include/linux/stddef.h:5,
                 from ./include/uapi/linux/posix_types.h:5,
                 from ./include/uapi/linux/types.h:14,
                 from ./include/linux/types.h:6,
                 from ./include/linux/kasan-checks.h:5,
                 from ./include/asm-generic/rwonce.h:26,
                 from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:232,
                 from arch/powerpc/boot/main.c:9:
./include/uapi/linux/stddef.h:5: note: this is the location of the previous definition
    5 | #define __always_inline inline
      | 
In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:232,
                 from arch/powerpc/boot/main.c:9:
./include/asm-generic/rwonce.h:64:31: error: expected ‘;’ before ‘unsigned’
   64 | static __no_sanitize_or_inline
      |                               ^
      |                               ;
   65 | unsigned long __read_once_word_nocheck(const void *addr)
      | ~~~~~~~~                       
./include/asm-generic/rwonce.h:82:28: error: expected ‘;’ before ‘unsigned’
   82 | static __no_kasan_or_inline
      |                            ^
      |                            ;
   83 | unsigned long read_word_at_a_time(const void *addr)
      | ~~~~~~~~                    
In file included from arch/powerpc/boot/ops.h:15,
                 from arch/powerpc/boot/main.c:15:


