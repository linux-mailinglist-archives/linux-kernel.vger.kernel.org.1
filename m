Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1325B28C186
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgJLTeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:34:09 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:57416 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728031AbgJLTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:34:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3D408181D3028;
        Mon, 12 Oct 2020 19:34:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1538:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3867:3868:3870:3871:5007:6119:10004:10400:10848:11658:11914:12297:12555:12760:13019:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: slope07_061768b271fd
X-Filterd-Recvd-Size: 1152
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 19:34:07 +0000 (UTC)
Message-ID: <03974c13efba564224284cf3fe87fe955dbfa27f.camel@perches.com>
Subject: [PATCH] atomics.tbl: Remove executable permission bits
From:   Joe Perches <joe@perches.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Oct 2020 12:34:06 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4d8e5cd233db ("locking/atomics: Fix scripts/atomic/ script permissions")
set all files in this directory executable.

But this file is an input to those scripts and does not need to be executable.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/atomic/atomics.tbl | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/scripts/atomic/atomics.tbl b/scripts/atomic/atomics.tbl
old mode 100755
new mode 100644



