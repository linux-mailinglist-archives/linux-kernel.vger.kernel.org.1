Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499B32A5BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgKDBcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:32:01 -0500
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:36786 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbgKDBcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:32:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id EF1E418225E0A;
        Wed,  4 Nov 2020 01:31:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:1963:2197:2198:2199:2200:2393:2525:2553:2560:2563:2682:2685:2691:2739:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4470:4605:5007:6119:6120:7514:7903:8531:8957:8985:9025:9149:10010:10400:10848:11026:11232:11233:11473:11658:11914:12043:12050:12294:12296:12297:12438:12740:12895:13439:13618:13894:14096:14097:14180:14181:14659:14721:14819:21080:21324:21433:21627:21740:21811:21939:21990:30006:30012:30034:30054:30056:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:390,LUA_SUMMARY:none
X-HE-Tag: bells46_5806729272bd
X-Filterd-Recvd-Size: 4539
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 01:31:57 +0000 (UTC)
Message-ID: <ba3126e1424c578f5040c7a6f04cdd6a334b2db4.camel@perches.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Nov 2020 17:31:56 -0800
In-Reply-To: <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
         <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
         <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 17:08 -0800, Nick Desaulniers wrote:
> On Tue, Nov 3, 2020 at 1:33 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote: 
> > On Tue, Nov 3, 2020 at 7:29 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > Now that the clang minimum supported version is > 10.0, enable the
> > > commented out conditional reformatting key:value lines in the file.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > > 
> > > Hey Miguel.
> > > 
> > > I don't use this, but on its face it seems a reasonable change
> > > if the commented out key:value lines are correct.
> 
> Joe,
> what would it take to get you to use clang-format, or at least try it?
>  Beers?  Bribes? Dirty deeds, done dirt cheap?

Hey Nick.

Paint my house? ;)

I've tried it.  It's OK.  It's not significantly better than
Lindent in some ways, in other ways it's pretty good.

It can make a real hash though of well formatted, human readable
code.  I think that's it's biggest drawback.

I posted an example of it a year or so back.

https://lore.kernel.org/lkml/e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com/

In that thread I wrote:

On Thu, 2019-09-12 at 03:18 -0700, Joe Perches wrote:
> On Thu, 2019-09-12 at 10:24 +0200, Miguel Ojeda wrote:
> > On Thu, Sep 12, 2019 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > Now I come to find that CodingStyle has settled on clang-format (in
> > > the last 15 months) as the new standard which is a much better answer
> > > to me than a manually specified style open to interpretation. I'll
> > > take a look at getting libnvdimm converted over.
> > 
> > Note that clang-format cannot do everything as we want within the
> > kernel just yet, but it is a close enough approximation -- it is near
> > the point where we could simply agree to use it and stop worrying
> > about styling issues. However, that would mean everyone needs to have
> > a recent clang-format available, which I think is the biggest obstacle
> > at the moment.
> 
> I don't think that's close to true yet for clang-format.
> 
> For instance: clang-format does not do anything with
> missing braces, or coalescing multi-part strings,
> or any number of other nominal coding style defects
> like all the for_each macros, aligning or not aligning
> columnar contents appropriately, etc...
> 
> clang-format as yet has no taste.
> 
> I believe it'll take a lot of work to improve it to a point
> where its formatting is acceptable and appropriate.
> 
> An AI rather than a table based system like clang-format is
> more likely to be a real solution, but training that AI
> isn't a thing that I want to do.

and an example very poor conversion from that same thread:

        unsigned int key, newkey;
        int i;
 
-       rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
-                   " %"__stringify(KEY_ID_SIZE)"s"
-                   " %"__stringify(KEY_ID_SIZE)"s",
-                   cmd, keystr, nkeystr);
+       rc = sscanf(
+               buf,
+               "%" __stringify(
+                       SEC_CMD_SIZE) "s"
+                                     " %" __stringify(
+                                             KEY_ID_SIZE) "s"
+                                                          " %" __stringify(
+                                                                  KEY_ID_SIZE) "s",
+               cmd, keystr, nkeystr);


