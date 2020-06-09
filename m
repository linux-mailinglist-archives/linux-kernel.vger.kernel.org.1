Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873C51F4992
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgFIWup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 18:50:45 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:51698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728108AbgFIWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:50:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6627218029138;
        Tue,  9 Jun 2020 22:50:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:965:966:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3866:3867:3868:3870:4385:4390:4395:5007:6119:10004:10400:10848:11026:11658:11914:12296:12297:12679:12760:13069:13161:13229:13311:13357:13439:14659:14721:21080:21433:21451:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: front10_2d174eb26dc6
X-Filterd-Recvd-Size: 1181
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 22:50:43 +0000 (UTC)
Message-ID: <573b3fbd5927c643920e1364230c296b23e7584d.camel@perches.com>
Subject: RFC: Allow kfree to free all types of allocations ?
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Jun 2020 15:50:42 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of patches trying to match
various [kv].alloc allocations to specific frees.

But are there frees in a fast path?

Why not convert kfree to add a few extra tests
and add #defines for existing uses

Something like:

void kfree(const void *addr)
{
	if (is_kernel_rodata((unsigned long)addr))
		return;

	if (is_vmalloc_addr(addr))
		_vfree(addr);
	else
		_kfree(addr);
}

And add defines like:

#define kvfree		kfree
#define vfree		kfree
#define kfree_const	kfree

Does 4 extra tests really matter?


