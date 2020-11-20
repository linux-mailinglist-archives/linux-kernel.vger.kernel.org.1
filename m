Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863462BBA44
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgKTXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:41:21 -0500
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:36208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgKTXlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:41:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CAC311DE0;
        Fri, 20 Nov 2020 23:41:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2919:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:10004:10400:11232:11658:11914:12297:12679:12740:12760:12895:13069:13160:13161:13229:13311:13357:13439:14659:21080:21222:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: light89_501494f2734f
X-Filterd-Recvd-Size: 1739
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Nov 2020 23:41:18 +0000 (UTC)
Message-ID: <97e87baf1dae54e56655d1034886f19bba06d13f.camel@perches.com>
Subject: Re: [PATCH 001/141] afs: Fix fall-through warnings for Clang
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date:   Fri, 20 Nov 2020 15:41:17 -0800
In-Reply-To: <83d2d50c-1708-f4a7-0e2f-c3c5a6b9e736@embeddedor.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org>
         <5e9c1d953c6b6254a3288f1e797064666e82a79d.camel@perches.com>
         <83d2d50c-1708-f4a7-0e2f-c3c5a6b9e736@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-20 at 17:28 -0600, Gustavo A. R. Silva wrote:
> On 11/20/20 17:18, Joe Perches wrote:
> 
> > My preference would be to change these to break and not fallthrough;
> 
> And my preference is fallthrough.

If so, that's an unusual choice here as it seems most or all of
the other patches you submitted use break in the same situation
where the next case is a single line break;

see: patches 2, 3, 4, 8, 9, etc...

> Joe, please, let the maintainer share their opinion on this first.

Why?
My preferences are my preferences and I don't mind announcing them.

