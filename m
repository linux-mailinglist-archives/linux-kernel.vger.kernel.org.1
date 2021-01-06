Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526282EBB7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhAFJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:02:22 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:57342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbhAFJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:02:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2625918037C58;
        Wed,  6 Jan 2021 09:01:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4384:4605:5007:7652:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21990:30029:30034:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: duck79_510625a274e0
X-Filterd-Recvd-Size: 1842
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Jan 2021 09:01:39 +0000 (UTC)
Message-ID: <2d5f6ffcf47ec4675cde21ff52fc70a9dd13b023.camel@perches.com>
Subject: Re: [PATCH] thinkpad_acpi: fix: use scnprintf instead of snprintf.
From:   Joe Perches <joe@perches.com>
To:     YANG LI <abaci-bugfix@linux.alibaba.com>, hdegoede@redhat.com
Cc:     mgross@linux.intel.com, ibm-acpi@hmh.eng.br,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Jan 2021 01:01:37 -0800
In-Reply-To: <1609914976-28113-1-git-send-email-abaci-bugfix@linux.alibaba.com>
References: <1609914976-28113-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-06 at 14:36 +0800, YANG LI wrote:
> The snprintf() function returns the number of characters which would
> have been printed if there were enough space, but the scnprintf()
> returns the number of characters which were actually printed. If the
> buffer is not large enough, then using snprintf() would result in a
> read overflow and an information leak. This error was found with the
> help of coccicheck.

In all cases, the buffer _is_ large enough.

tmpi is length 5 and ok.
include/sound/core.h:   char shortname[32];             /* short name of this soundcard */
include/sound/core.h:   char longname[80];              /* name of this soundcard */
include/sound/core.h:   char mixername[80];             /* mixer name */

_show function lengths are OK for all the uses with PAGE_SIZE.
And it's probably better to use sysfs_emit for all the _show functions


