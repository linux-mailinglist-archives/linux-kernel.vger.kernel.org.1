Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE41C7775
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgEFRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 13:09:15 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:37598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729414AbgEFRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:09:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 57B3B18007091;
        Wed,  6 May 2020 17:09:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2731:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:5007:6119:6238:7514:7875:9010:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:13870:14096:14097:14180:14181:14659:14721:21060:21080:21451:21627:21939:30054:30060:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: ants64_8ab334094600b
X-Filterd-Recvd-Size: 2212
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 May 2020 17:09:13 +0000 (UTC)
Message-ID: <db73e101ef0899149cf297e912cb2cb1e2572067.camel@perches.com>
Subject: Re: MAINTAINERS: Wrong ordering in S390 PCI SUBSYSTEM
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 06 May 2020 10:09:11 -0700
In-Reply-To: <CAHp75VeNiuJ7QXvNO2=W_TjEjjK3xRbg0-Don6HkSOHV5LXRbA@mail.gmail.com>
References: <alpine.DEB.2.21.2005060741520.7719@felia>
         <CAHp75VeNiuJ7QXvNO2=W_TjEjjK3xRbg0-Don6HkSOHV5LXRbA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-06 at 13:51 +0300, Andy Shevchenko wrote:
> On Wed, May 6, 2020 at 8:46 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > Hi Pierre,
> > 
> > with your commit de267a7c71ba ("s390/pci: Documentation for zPCI"),
> > visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS
> > complains:
> > 
> > WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> > #14723: FILE: MAINTAINERS:14723:
> > +F:     drivers/pci/hotplug/s390_pci_hpc.c
> > +F:     Documentation/s390/pci.rst
> > 
> > 
> > This is due to wrong ordering of the entries in your submission. If you
> > would like me to send you a patch fixing that, please just let me know.
> > 
> > It is a recent addition to checkpatch.pl to report ordering problems in
> > MAINTAINERS, so you might have not seen that at submission time.
> 
> Why not to send a patch?
> Same for the rest of similar mails from you.

Frequently an original patch, which has yet to hit Linus' tree,
can be updated before being upstreamed to avoid unnecessary
additional patches.

It's also good form so the author of the original patch can be
aware of possible defects in submission.


