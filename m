Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3E302053
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 03:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhAYCXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 21:23:12 -0500
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:54736 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbhAYB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 20:56:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 71DAF18002DCA;
        Mon, 25 Jan 2021 01:55:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:988:989:1260:1261:1277:1311:1313:1314:1345:1515:1516:1518:1522:1536:1692:1711:1730:1747:1777:1792:2392:2393:2559:2562:3138:3139:3140:3141:3142:3876:3877:5007:6114:6642:7652:10004:10018:10400:11658:11914:12297:12760:13069:13311:13357:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: back90_3e183ed27581
X-Filterd-Recvd-Size: 681
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jan 2021 01:55:07 +0000 (UTC)
Message-ID: <08ee32211e8b40234257a236c842a7be6703144c.camel@perches.com>
Subject: Anyone have ideas for checkpatch improvements ?
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Date:   Sun, 24 Jan 2021 17:55:06 -0800
Content-Type: text/plain
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



