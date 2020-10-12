Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07F28BBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgJLPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:23:41 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:52218 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388984AbgJLPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:23:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 634A5180A7FCF;
        Mon, 12 Oct 2020 15:23:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6120:10004:10400:11232:11658:11914:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: twist43_3b049cd271fb
X-Filterd-Recvd-Size: 2477
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 15:23:36 +0000 (UTC)
Message-ID: <a9ced92c25f45931fd4a387e2cf1a39a36a11c27.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: add shebang check to EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 08:23:35 -0700
In-Reply-To: <alpine.DEB.2.21.2010121612150.6487@felia>
References: <20201012054943.1196031-1-ujjwalkumar0501@gmail.com>
         <63053585d41ff81cdaad6cb727eb83d81207041a.camel@perches.com>
         <5a3fc45f-e5d7-da3d-4b4b-2a23512ff8de@gmail.com>
         <alpine.DEB.2.21.2010121612150.6487@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-12 at 16:16 +0200, Lukas Bulwahn wrote:
> On Mon, 12 Oct 2020, Ujjwal Kumar wrote:
> > On 12/10/20 11:47 am, Joe Perches wrote:
> > > On Mon, 2020-10-12 at 11:19 +0530, Ujjwal Kumar wrote:
> > > > checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
> > > > files. The script leverages filename extensions and its path in
> > > > the repository to decide whether to allow execute permissions on
> > > > the file or not.
> > > > 
> > > > Based on current check conditions, a perl script file having
> > > > execute permissions, without '.pl' extension in its filename
> > > > and not belonging to 'scripts/' directory is reported as ERROR
> > > > which is a false-positive.
> > > > 
> > > > Adding a shebang check along with current conditions will make
> > > > the check more generalised and improve checkpatch reports.
> > > > To do so, without breaking the core design decision of checkpatch,
> > > > we can fetch the first line from the patch itself and match it for
> > > > a shebang pattern.
> > > > 
> > > > There can be cases where the first line is not part of the patch.
> > > 
> > > For instance: a patch that only changes permissions
> > > without changing any of the file content.
[]
> > Should these new changes go as a separate patch or can they be
> > included in the next iteration of this patch?
[]
The commit log should be updated with the example shown.
Please send a clean V2.


