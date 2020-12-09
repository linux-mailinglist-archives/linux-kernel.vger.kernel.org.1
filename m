Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310692D3A03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgLIFCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:02:33 -0500
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:45652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbgLIFCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:02:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 676411802926E;
        Wed,  9 Dec 2020 05:01:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3622:3865:3867:3868:4321:4388:5007:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13019:13069:13255:13311:13357:13439:14659:21080:21433:21451:21627:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: gun83_6115dd7273ed
X-Filterd-Recvd-Size: 1687
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Dec 2020 05:01:50 +0000 (UTC)
Message-ID: <13d04c4cc769ebd1dd58470f4d22ada5c9cd28e7.camel@perches.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 08 Dec 2020 21:01:49 -0800
In-Reply-To: <202012081619.6593C87D3@keescook>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
         <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
         <20201203093458.GA16543@unreal>
         <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
         <20201203104047.GD16543@unreal> <X8ku1MmZeeIaMRF4@kroah.com>
         <202012081619.6593C87D3@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-08 at 16:34 -0800, Kees Cook wrote:

> If not "Adjusted-by", what about "Tweaked-by", "Helped-by",
> "Corrected-by"?

Improved-by: / Enhanced-by: / Revisions-by: 

Or simply don't use anything but a link to the conversion thread
like Konstantin suggested.

I still want to know what actual value these things have and to whom.



