Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4771DA124
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgESTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:42:39 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:40970 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgESTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:42:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B0520182CF666;
        Tue, 19 May 2020 19:42:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1537:1561:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3866:3868:4605:5007:6120:6261:10004:10848:11658:11914:12043:12291:12297:12679:12683:12895:13069:13311:13357:13894:14110:14384:14721:21080:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ants16_4315b1e26d0f
X-Filterd-Recvd-Size: 1276
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:42:37 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 0/2] printk/init: multi-line kernel command line logging
Date:   Tue, 19 May 2020 12:42:33 -0700
Message-Id: <cover.1589916689.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
References: <79e649a5a73b2137bc576a75271854dc4024ae24.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches (2):
  printk: Move and rename maximum printk output line length defines
  init: Allow multi-line output of kernel command line

 include/linux/printk.h | 18 ++++++++++++++++++
 init/main.c            | 31 ++++++++++++++++++++++++++++++-
 kernel/printk/printk.c | 28 ++++++++++------------------
 3 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.25.1

