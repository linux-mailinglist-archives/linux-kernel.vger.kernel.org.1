Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D62EA75D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbhAEJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:29:03 -0500
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:57022 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727853AbhAEJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:29:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 63E22100E7B46;
        Tue,  5 Jan 2021 09:28:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2689:2691:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3874:4321:5007:7652:8603:10004:10249:10400:10471:10848:11026:11232:11473:11658:11783:11914:12043:12297:12438:12740:12895:13161:13229:13255:13439:13894:14181:14659:14721:21080:21324:21433:21627:21795:21939:30051:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: books34_27150c3274d7
X-Filterd-Recvd-Size: 3489
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Jan 2021 09:28:19 +0000 (UTC)
Message-ID: <3ffe616d8c3fb54833bfc4d86cb73427cf6c7add.camel@perches.com>
Subject: deprecated.rst: deprecated strcpy ? (was: [PATCH] checkpatch: add a
 new check for strcpy/strlcpy uses)
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 05 Jan 2021 01:28:18 -0800
In-Reply-To: <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
         <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
         <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-01-05 at 14:29 +0530, Dwaipayan Ray wrote:
> On Tue, Jan 5, 2021 at 2:14 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2021-01-05 at 13:53 +0530, Dwaipayan Ray wrote:
> > > strcpy() performs no bounds checking on the destination buffer.
> > > This could result in linear overflows beyond the end of the buffer.
> > > 
> > > strlcpy() reads the entire source buffer first. This read
> > > may exceed the destination size limit. This can be both inefficient
> > > and lead to linear read overflows.
> > > 
> > > The safe replacement to both of these is to use strscpy() instead.
> > > Add a new checkpatch warning which alerts the user on finding usage of
> > > strcpy() or strlcpy().
> > 
> > I do not believe that strscpy is preferred over strcpy.
> > 
> > When the size of the output buffer is known to be larger
> > than the input, strcpy is faster.
> > 
> > There are about 2k uses of strcpy.
> > Is there a use where strcpy use actually matters?
> > I don't know offhand...
> > 
> > But I believe compilers do not optimize away the uses of strscpy
> > to a simple memcpy like they do for strcpy with a const from
> > 
> >         strcpy(foo, "bar");
> > 
> 
> Yes the optimization here definitely helps. So in case the programmer
> knows that the destination buffer is always larger, then strcpy() should be
> preferred? I think the documentation might have been too strict about
> strcpy() uses here:
> 
> Documentation/process/deprecated.rst:
> "strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading to
> all kinds of misbehaviors. While `CONFIG_FORTIFY_SOURCE=y` and various
> compiler flags help reduce the risk of using this function, there is
> no good reason to add new uses of this function. The safe replacement
> is strscpy(),..."

Kees/Jonathan:

Perhaps this text is overly restrictive.

There are ~2k uses of strcpy in the kernel.

About half of these are where the buffer length of foo is known and the
use is 'strcpy(foo, "bar")' so the compiler converts/optimizes away the
strcpy to memcpy and may not even put "bar" into the string table.

I believe strscpy uses do not have this optimization.

Is there a case where the runtime costs actually matters?
I expect so.


