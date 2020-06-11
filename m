Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4211F6D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 20:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgFKSWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 14:22:45 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:40186 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbgFKSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:22:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4AEF718111E54;
        Thu, 11 Jun 2020 18:22:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3870:3871:3872:3874:4321:5007:6119:7576:10004:10400:10848:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bell15_120039f26dd5
X-Filterd-Recvd-Size: 1313
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 18:22:42 +0000 (UTC)
Message-ID: <fcd6d2c34c082ee3dd21a1c3bfd558306e566261.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: perform commit ID check from external to
 git folder
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Matteo Croce <mcroce@redhat.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jun 2020 11:22:41 -0700
In-Reply-To: <20200611125957.1993741-1-leon@kernel.org>
References: <20200611125957.1993741-1-leon@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 15:59 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The execution of scripts/checkpatch.pl in folder outside of git produces
> complains about invalid commit ID, despite having valid one.

There is already a slightly different test for this in -next
It also uses a environment test for GIT_DIR.

Try that one.  


