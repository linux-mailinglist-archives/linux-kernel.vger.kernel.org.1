Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583C42DF69F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgLTTNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 14:13:33 -0500
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:32852 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgLTTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 14:13:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 79EF9100E7B45;
        Sun, 20 Dec 2020 19:12:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2908:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3872:3874:4321:4605:5007:10004:10400:10848:11232:11658:11914:12043:12297:12740:12895:13069:13141:13230:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dog98_1f031b327451
X-Filterd-Recvd-Size: 2189
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Dec 2020 19:12:50 +0000 (UTC)
Message-ID: <5e7eae6b12df8fefc900930ffc12f80a9bfd643c.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: kconfig: add missing types to regex
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Sun, 20 Dec 2020 11:12:49 -0800
In-Reply-To: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
References: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-14 at 11:24 +0100, Nicolai Fischer wrote:
> Kconfig parsing does not recognise all type attributes.
> This adds the missing 'int', 'sting' and 'hex' types.
> 
> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3321,7 +3321,7 @@ sub process {
>  				next if ($f =~ /^-/);
>  				last if (!$file && $f =~ /^\@\@/);
>  
> 
> -				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
> +				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*["']/) {

int and hex uses are not required to be followed either a " or '
For that matter, it's not required for tristate, bool or string

Likely this should be ["'$]

$ git grep -P -oh '^\s*(?:bool|tristate|int|hex|string|prompt)\b\s*\S?' -- '*/Kconfig*' | \
  sed -r -e 's/^\s+//' -e 's/\s+/ /g' | \
  sort | uniq -c | sort -rn
   8558 tristate "
   6314 bool "
   2082 bool
    843 tristate
    308 prompt "
    286 int "
    106 tristate '
     93 int
     84 hex "
     66 string "
     25 hex
     21 bool '
     18 string
      5 hex '
      3 string p
      2 string (
      1 string '
      1 int.
      1 bool #
      1 bool 


