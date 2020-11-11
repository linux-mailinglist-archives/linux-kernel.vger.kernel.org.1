Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052662AF575
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKKPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:50:48 -0500
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:39698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbgKKPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:50:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 97580100E7B49;
        Wed, 11 Nov 2020 15:50:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7514:7903:10004:10400:10848:11026:11232:11658:11914:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21063:21080:21433:21451:21627:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: back47_1a07090272fe
X-Filterd-Recvd-Size: 2673
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Nov 2020 15:50:45 +0000 (UTC)
Message-ID: <f21acc492ab37acc42390abffb61aed370a22118.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add fix option for MISSING_SIGN_OFF
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Nov 2020 07:50:44 -0800
In-Reply-To: <2b640e8b-69dc-2ade-3b9f-fae14eed1b17@gmail.com>
References: <20201111090143.9230-1-yashsri421@gmail.com>
         <CAKXUXMzg6Wg310s-N8hWOEiXFkg1ZAga+NkFQkFQ5_bS16TLnA@mail.gmail.com>
         <2b640e8b-69dc-2ade-3b9f-fae14eed1b17@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-11 at 16:39 +0530, Aditya wrote:
> On 11/11/20 4:00 pm, Lukas Bulwahn wrote:
> > On Wed, Nov 11, 2020 at 10:01 AM Aditya Srivastava <yashsri421@gmail.com> wrote:
> > > 
> > > Currently checkpatch warns us if there is no 'Signed-off-by' line
> > > for the patch.
> > > 
> > > E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
> > > Completely remove --version flag") reports this error:
> > > 
> > > ERROR: Missing Signed-off-by: line(s)
> > > 
> > > Provide a fix by adding a Signed-off-by line corresponding to the author
> > > of the patch before the patch separator line. Also avoid this error for
> > > the commits where some typo is present in the sign off.
[]
> > I think it should still warn about a Missing Signed-off-by: even when
> > we know there is a $non_standard_signature. So, checkpatch simply
> > emits two warnings; that is okay in that case.
> > 
> > It is just that our evaluation shows that the provided fix option
> > should not be suggested when there is a $non_standard_signature
> > because we actually would predict that there is typo in the intended
> > Signed-off-by tag and the fix that checkpatch would suggest would not
> > be adequate.
> > 
> > Joe, what is your opinion?
> > 
> > Aditya, it should not be too difficult to implement the rule that way, right?
> > 
> 
> No, I'd probably just have to add the check with $fix, instead of with
> $signoff

I think it does not matter much which is chosen.

The bad signed-off-by: line would still need to be corrected one
way or another and the added signed-off-line is also possibly
incorrect so it could need to be modified or deleted.


