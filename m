Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6E82854D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 01:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgJFXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 19:13:08 -0400
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:48658 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgJFXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:13:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C0F1C18224D9C;
        Tue,  6 Oct 2020 23:13:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3870:3872:4250:4605:5007:6117:6119:7903:10004:10400:10848:11658:11914:12043:12114:12297:12555:12760:13069:13311:13357:13439:13548:14659:14721:21080:21433:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wave94_1c0276c271ca
X-Filterd-Recvd-Size: 2049
Received: from XPS-9350 (unknown [172.58.19.215])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 23:13:05 +0000 (UTC)
Message-ID: <307a7581abe24135ac243c3080d4ab9e7c044cbf.camel@perches.com>
Subject: git grep/sed to standardize "/* SPDX-License-Identifier: <license>"
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <trivial@kernel.org>
Date:   Tue, 06 Oct 2020 16:13:03 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all source files in the kernel use a standardized SPDX header
at line 1 with a comment /* initiator and terminator */:

/* SPDX-License-Identifier: <license> */

$ git grep -PHn '^/\* SPDX-License-Identifier:.*\*/\s*$' | \
  wc -l
17847

$ git grep -PHn '^/\* SPDX-License-Identifier:.*\*/\s*$' | \
  grep ":1:" | cut -f1 -d":" | grep -oP '\.\w+$' | \
  sort | uniq -c | sort -rn
  16769 .h
    972 .S
     87 .c
      6 .lds
      3 .l
      2 .y
      2 .py
      2 .dtsi
      1 .sh
      1 .dts
      1 .cpp
      1 .bc

But about 2% of the files do not use a use comment termination at
line 1 and use either:

/* SPDX-License-Identifier: <license>
 * additional comment or blank

or

/* SPDX-License-Identifier: <license>
<blank line>

$ git grep -PHn '^/\* SPDX-License-Identifier:(?!.*\*/\s*$)' | \
  wc -l
407

$ git grep -PHn '^/\* SPDX-License-Identifier:(?!.*\*/\s*$)' | \
  grep '\:1:' | cut -f1 -d':' | grep -oP '\.\w+$' | \
  sort | uniq -c | sort -rn
    357 .h
     34 .S
     16 .c

Here's a trivial script to convert and standardize the
first and second lines of these 407 files to make it easier
to categorize and sort.

$ git grep -PHn '^/\* SPDX-License-Identifier:(?!.*\*/\s*$)' | \
  grep ':1:' | cut -f1 -d":" | \
  xargs sed -i -e '1s@[[:space:]]*$@ */@' -r -e '2s@^( \*|)@/*@'

