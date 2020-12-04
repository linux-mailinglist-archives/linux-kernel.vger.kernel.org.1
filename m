Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD52CF160
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgLDQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:00:14 -0500
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:39898 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727125AbgLDQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:00:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4D897180A8CB5;
        Fri,  4 Dec 2020 15:59:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:6117:7514:7903:9010:10004:10400:10848:11026:11232:11473:11658:11914:12109:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shape73_2e0539a273c5
X-Filterd-Recvd-Size: 1695
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri,  4 Dec 2020 15:59:32 +0000 (UTC)
Message-ID: <b8d2d60beda905d1215333cd22b09ca672de1b26.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add fix for non-standard signature -
 co-authored-by
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Fri, 04 Dec 2020 07:59:31 -0800
In-Reply-To: <20201204144000.21734-1-yashsri421@gmail.com>
References: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
         <20201204144000.21734-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-04 at 20:10 +0530, Aditya Srivastava wrote:
> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> non-standard signatures.
> 
> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> tag, which may seem correct, but is not standard.
> 
> The standard signature equivalent for 'Co-authored-by' is
> 'Co-developed-by'.
> 
> Provide a fix by suggesting users with this signature alternative and
> replacing.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

lkml is a very active dumping ground and most people do not scan
through each patch sent to it.

If you want specific people to see this and potentially ack this
you should add them to the cc list.


