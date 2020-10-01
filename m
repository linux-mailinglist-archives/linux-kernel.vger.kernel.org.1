Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10909280057
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732150AbgJANmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:42:37 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:34314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731993AbgJANmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:42:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 30C70100E7B49;
        Thu,  1 Oct 2020 13:42:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:2901:3138:3139:3140:3141:3142:3355:3622:3653:3865:3867:3868:3870:3871:3872:3873:4184:4321:4605:5007:6119:7903:9010:9149:10004:10400:11026:11232:11233:11473:11658:11914:12043:12297:12438:12740:12760:12895:13095:13141:13180:13229:13230:13439:14180:14181:14659:14721:21060:21080:21433:21451:21627:21990:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: power08_61089732719b
X-Filterd-Recvd-Size: 4147
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 13:42:34 +0000 (UTC)
Message-ID: <f3dadda8af7eef6613d7a4105170058f2759507d.camel@perches.com>
Subject: Re: [PATCH RFC] checkpatch: fix multi-statement macro checks
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 01 Oct 2020 06:42:32 -0700
In-Reply-To: <CABJPP5CFE3KXzMzuvVxtJt5tOg8Ye6y1V7-mqT5pqazHjVWvJw@mail.gmail.com>
References: <20201001103314.136645-1-dwaipayanray1@gmail.com>
         <8e110121c89414ab1601071868dbcf410195a209.camel@perches.com>
         <CABJPP5CFE3KXzMzuvVxtJt5tOg8Ye6y1V7-mqT5pqazHjVWvJw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-01 at 18:57 +0530, Dwaipayan Ray wrote:
> On Thu, Oct 1, 2020 at 6:47 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2020-10-01 at 16:03 +0530, Dwaipayan Ray wrote:
> > > Checkpatch.pl doesn't have a check for excluding while (...) {...}
> > > blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.
> > > 
> > > For example, running checkpatch.pl on the file mm/access.c in the
> > > kernel generates the following error:
> > > 
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)        \
> > > +     while (len >= sizeof(type)) {                                   \
> > > +             __get_kernel_nofault(dst, src, type, err_label);        \
> > > +             dst += sizeof(type);                                    \
> > > +             src += sizeof(type);                                    \
> > > +             len -= sizeof(type);                                    \
> > > +     }
> > > 
> > > The error is misleading for this case. Enclosing it in parantheses
> > > doesn't make any sense.
> > 
> > OK
> > 
> > > Checkpatch already has an exception list for such common macro types.
> > > Added a new exception for while (...) {...} style blocks to the same.
> > > This effectively fixed the wrong error message.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -5342,6 +5342,7 @@ sub process {
> > >                           $dstat !~ /^\.$Ident\s*=/ &&                                # .foo =
> > >                           $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&          # stringification #foo
> > >                           $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&       # do {...} while (...); // do {...} while (...)
> > > +                         $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&           # while (...) {...}

Note the \s*
                                                              ^

> > Did you try to output $dstat for some matching cases?
> > What was the $dstat value for the cases you tried?
> > 
> > 
> Hi,
> I did check $dstat values.
> 
> For example on file mm/maccess.c, there were two such macros:
> 
> Case 1:
> 
> $ctx:
> +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) \
> + while (len >= sizeof(type)) { \
> + __get_kernel_nofault(dst, src, type, err_label); \
> + dst += sizeof(type); \
> + src += sizeof(type); \
> + len -= sizeof(type); \
> + }
> 
> $dstat:
> while 1 1

And perhaps this test should use \s+ instead.
What is $dstat with a #define like:

#define foo(bar,baz)while(bar){bar--;baz++;}

(no spaces anywhere bot the required one after define
	
> Case 2:
> 
> $ctx:
> +#define copy_to_kernel_nofault_loop(dst, src, len, type, err_label) \
> + while (len >= sizeof(type)) { \
> + __put_kernel_nofault(dst, src, type, err_label); \
> + dst += sizeof(type); \
> + src += sizeof(type); \
> + len -= sizeof(type); \
> + }
> 
> $dstat:
> while 1 1
> 
> 
> Thanks,
> Dwaipayan.

