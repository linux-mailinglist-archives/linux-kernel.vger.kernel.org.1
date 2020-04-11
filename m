Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155321A52EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDKQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 12:45:47 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:36892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbgDKQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:45:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7B64F182CCCD1;
        Sat, 11 Apr 2020 16:45:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:4362:5007:10004:10400:10848:11658:11914:12043:12297:12663:12760:13069:13311:13357:13439:13868:14659:21080:21212:21627:21987:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: swing79_4f67ea8b28904
X-Filterd-Recvd-Size: 1213
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 16:45:45 +0000 (UTC)
Message-ID: <af4673918a3f6bfba51118d68d554d4a1ff3dad4.camel@perches.com>
Subject: Request to sort MAINTAINERS again just before an -rc1 release
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 11 Apr 2020 09:43:40 -0700
In-Reply-To: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
References: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider running and committing:

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

Immediately before any upcoming -rc1 is released.

Relatively few of any pending patches to MAINTAINERS
in -next would be impacted and there would be better
consistency in the file.

Thanks.

