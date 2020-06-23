Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325A2206795
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgFWWs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 18:48:59 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:59950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389002AbgFWWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:48:52 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 4A36C809D2DE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 22:33:29 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2ABE622030;
        Tue, 23 Jun 2020 22:33:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3872:3874:4321:4362:5007:9010:10004:10400:10848:11232:11658:11914:12043:12114:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: glass61_5e0187126e3f
X-Filterd-Recvd-Size: 1381
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 22:33:28 +0000 (UTC)
Message-ID: <70e4841dd72c4c667d45e147c03e1227934701e3.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: fix CONST_STRUCT when
 const_structs.checkpatch is missing
From:   Joe Perches <joe@perches.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 23 Jun 2020 15:33:27 -0700
In-Reply-To: <20200623221822.3727-1-quentin@isovalent.com>
References: <20200623221822.3727-1-quentin@isovalent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 23:18 +0100, Quentin Monnet wrote:
> Checkpatch reports warnings when some specific structs are not declared
> as const in the code. The list of structs to consider was initially
> defined in the checkpatch.pl script itself, but it was later moved to an
> external file (scripts/const_structs.checkpatch), in commit bf1fa1dae68e
> ("checkpatch: externalize the structs that should be const"). This
> introduced two minor issues:

Thanks Quentin.

Acked-by: Joe Perches <joe@perches.com>


