Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C222852F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgJFULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:11:35 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:36980 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgJFULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:11:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DF49F1730844;
        Tue,  6 Oct 2020 20:11:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3870:3872:4250:4321:5007:6119:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bait96_5d0530f271c9
X-Filterd-Recvd-Size: 1284
Received: from XPS-9350 (unknown [172.58.35.183])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 20:11:31 +0000 (UTC)
Message-ID: <4f7c452ff57c30225f4cb3f4f81a4303bb6be33d.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 06 Oct 2020 13:11:29 -0700
In-Reply-To: <cd8fb6742e4776a98412278815fc86b568820b6e.camel@perches.com>
References: <20201006185114.168358-1-dwaipayanray1@gmail.com>
         <8553d6679f97ae9d285a9ffd61198f5e3c11dc35.camel@perches.com>
         <CABJPP5Awe=CDC7riYBBVDf9WRO4aAMXK2QROYdtGyJXNjqB-ew@mail.gmail.com>
         <cd8fb6742e4776a98412278815fc86b568820b6e.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 13:09 -0700, Joe Perches wrote:
> I suggest adding it to this patch.

as a --strict CHK as it's not an actual defect in addressing
just a trivial difference in formatting.


