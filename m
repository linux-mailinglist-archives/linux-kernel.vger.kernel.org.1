Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E96209889
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 04:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgFYCfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 22:35:52 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:50070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389174AbgFYCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:35:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D4C6F181D337B;
        Thu, 25 Jun 2020 02:35:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:582:967:973:988:989:1152:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1533:1536:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3690:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:5007:6261:6642:9025:10004:10400:10848:11658:11914:12043:12196:12297:12555:12760:12806:13069:13311:13357:14181:14659:14685:14721:14746:21080:21627:21740:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: swing04_4e0bd0626e49
X-Filterd-Recvd-Size: 879
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 02:35:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Jun 2020 19:35:50 -0700
From:   joe@perches.com
To:     Julia lawall <julia.lawall@lip6.fr>
Cc:     Kris Borer <kborer@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cocci script from 2016 - assignment in if ?
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <3af82c36a9e7477566bf3c2e6ce013cd@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [47.151.133.149]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/patchwork/patch/649705/

Any particular reason this wasn't applied?

I ask because I added something similar recently to checkpatch.
