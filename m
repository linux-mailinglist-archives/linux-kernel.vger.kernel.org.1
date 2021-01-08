Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1D2EEA92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbhAHAwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:52:16 -0500
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:36068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727695AbhAHAwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:52:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 57BD9181D337B;
        Fri,  8 Jan 2021 00:51:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1394:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2553:2565:2682:2685:2689:2691:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7652:8603:8957:9025:10004:10249:10848:11026:11232:11473:11658:11783:11914:12043:12266:12297:12438:12555:12740:12895:12986:13153:13228:13255:13439:13845:13894:14181:14659:14721:21080:21324:21347:21365:21433:21451:21627:21740:21795:21939:21990:30012:30051:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: clam92_5d138c7274ee
X-Filterd-Recvd-Size: 5431
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Jan 2021 00:51:32 +0000 (UTC)
Message-ID: <9e111f0f673ae6ced12efc01d32eefe8402c7f72.camel@perches.com>
Subject: Re: deprecated.rst: deprecated strcpy ? (was: [PATCH] checkpatch:
 add a new check for strcpy/strlcpy uses)
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 07 Jan 2021 16:51:31 -0800
In-Reply-To: <202101071310.3AC5F0C4@keescook>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
         <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
         <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
         <3ffe616d8c3fb54833bfc4d86cb73427cf6c7add.camel@perches.com>
         <202101071310.3AC5F0C4@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-07 at 13:16 -0800, Kees Cook wrote:
> On Tue, Jan 05, 2021 at 01:28:18AM -0800, Joe Perches wrote:
> > On Tue, 2021-01-05 at 14:29 +0530, Dwaipayan Ray wrote:
> > > On Tue, Jan 5, 2021 at 2:14 PM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > On Tue, 2021-01-05 at 13:53 +0530, Dwaipayan Ray wrote:
> > > > > strcpy() performs no bounds checking on the destination buffer.
> > > > > This could result in linear overflows beyond the end of the buffer.
> > > > > 
> > > > > strlcpy() reads the entire source buffer first. This read
> > > > > may exceed the destination size limit. This can be both inefficient
> > > > > and lead to linear read overflows.
> > > > > 
> > > > > The safe replacement to both of these is to use strscpy() instead.
> > > > > Add a new checkpatch warning which alerts the user on finding usage of
> > > > > strcpy() or strlcpy().
> > > > 
> > > > I do not believe that strscpy is preferred over strcpy.
> > > > 
> > > > When the size of the output buffer is known to be larger
> > > > than the input, strcpy is faster.
> > > > 
> > > > There are about 2k uses of strcpy.
> > > > Is there a use where strcpy use actually matters?
> > > > I don't know offhand...
> > > > 
> > > > But I believe compilers do not optimize away the uses of strscpy
> > > > to a simple memcpy like they do for strcpy with a const from
> > > > 
> > > >         strcpy(foo, "bar");
> > > > 
> > > 
> > > Yes the optimization here definitely helps. So in case the programmer
> > > knows that the destination buffer is always larger, then strcpy() should be
> > > preferred? I think the documentation might have been too strict about
> > > strcpy() uses here:
> > > 
> > > Documentation/process/deprecated.rst:
> > > "strcpy() performs no bounds checking on the destination buffer. This
> > > could result in linear overflows beyond the end of the buffer, leading to
> > > all kinds of misbehaviors. While `CONFIG_FORTIFY_SOURCE=y` and various
> > > compiler flags help reduce the risk of using this function, there is
> > > no good reason to add new uses of this function. The safe replacement
> > > is strscpy(),..."
> > 
> > Kees/Jonathan:
> > 
> > Perhaps this text is overly restrictive.
> > 
> > There are ~2k uses of strcpy in the kernel.
> > 
> > About half of these are where the buffer length of foo is known and the
> > use is 'strcpy(foo, "bar")' so the compiler converts/optimizes away the
> > strcpy to memcpy and may not even put "bar" into the string table.
> > 
> > I believe strscpy uses do not have this optimization.
> > 
> > Is there a case where the runtime costs actually matters?
> > I expect so.
> 
> The original goal was to use another helper that worked on static
> strings like this. Linus rejected that idea, so we're in a weird place.
> I think we could perhaps build a strcpy() replacement that requires
> compile-time validated arguments, and to break the build if not.
> 
> i.e.
> 
> given:
> 	char array[8];
> 	char *ptr;
> 
> allow:
> 
> 
> 	strcpy(array, "1234567");
> 
> disallow:
> 
> 	strcpy(array, "12345678");	/* too long */
> 	strcpy(array, src);		/* not optimized, so use strscpy? */
> 	strcpy(ptr, "1234567");		/* unknown destination size */
> 	strcpy(ptr, src);		/* unknown destination size */

I think that's not a good idea as it's not a generic equivalent of the
string.h code.

I still like the stracpy variant I proposed:

https://lore.kernel.org/lkml/24bb53c57767c1c2a8f266c305a670f7@sk2.org/T/#m0627aa770a076af1937cb5c610ed71dab3f1da72
https://lore.kernel.org/lkml/CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com/

Linus liked a variant he called copy_string:

https://lore.kernel.org/lkml/CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com/

I think the cocci scripts that convert:

	strlcpy -> strscpy (only when return value unused)
	str<sln>cpy(array, "string") -> stracpy(foo, "string")
	s[cn]printf -> sysfs_emit

would leave relatively few uses of strcpy and sprintf variants and would
make it much easier to analyze the remainder uses for potential overflows.


