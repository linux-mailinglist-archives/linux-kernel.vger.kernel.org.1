Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390D3289CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgJJAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:25:33 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:42454 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728861AbgJJAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:20:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 07130182CED34;
        Sat, 10 Oct 2020 00:20:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:3873:3874:4321:5007:7514:7809:7875:7901:7903:9010:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:13891:14096:14097:14181:14659:14721:21080:21451:21627:30054:30062:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: trip73_200acbd271e4
X-Filterd-Recvd-Size: 2158
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Oct 2020 00:20:42 +0000 (UTC)
Message-ID: <a3b81f8a3b4e30c57de8528b6674fac0e57e5e4a.camel@perches.com>
Subject: Re: [PATCH] Fixed coding style issues raised by checkpatch.
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tabot Kevin <tabot.kevin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 09 Oct 2020 17:20:41 -0700
In-Reply-To: <20201009081840.GB401030@kroah.com>
References: <20201009080038.GA1439@tabot>
         <20201009081840.GB401030@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-09 at 10:18 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 09, 2020 at 09:00:38AM +0100, Tabot Kevin wrote:
> > This patch fixes the following:
> > - Made sure alignment matched open parenthesis.
> > 
> > Signed-off-by: Tabot Kevin <tabot.kevin@gmail.com>
> > ---
> >  drivers/staging/greybus/audio_module.c | 8 ++++----
> 
> As my bot asked you to, please use scripts/get_maintainer.pl to
> determine who, and what mailing lists, to send patches to.

fyi Tabot, he means you to use:

$ ./scripts/get_maintainer.pl -f drivers/staging/greybus/audio_module.c
Vaibhav Agarwal <vaibhav.sr@gmail.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
Mark Greer <mgreer@animalcreek.com> (maintainer:GREYBUS AUDIO PROTOCOLS DRIVERS)
Johan Hovold <johan@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
Alex Elder <elder@kernel.org> (maintainer:GREYBUS SUBSYSTEM)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:GREYBUS SUBSYSTEM)
greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM)
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

> Also, I think this patch has been rejected many times in the past,
> please check the archives first before sending it again.

Doubtful about that as almost the entire file uses
alignment to open parenthesis.


