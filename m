Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18B1F5D81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFJVIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 17:08:25 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:50876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgFJVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:08:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DAFF318029137;
        Wed, 10 Jun 2020 21:08:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:8603:10004:10400:10848:11026:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21740:30054:30069:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: smile40_320491826dce
X-Filterd-Recvd-Size: 1830
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 21:08:22 +0000 (UTC)
Message-ID: <fe98c147136c5625641d14bf70b13ffbfaeb025a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add --max-file-size option
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 14:08:21 -0700
In-Reply-To: <20200610205616.9965-1-scott.branden@broadcom.com>
References: <20200610205616.9965-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 13:56 -0700, Scott Branden wrote:
> Add --max-file-size option (default off) to limit size of files
> that checkpatch processes.  Such an option is useful when checkpatch
> is run automatically during checkins to a source control system and
> someone acccidently or purposely attempt to commit massive size files
> to the system.  If the checkpatch script runs on such files it could take
> a long time to run and limit the server's ability to perform other
> operations.

Does everything need to be in checkpatch or can this facility
be run by a separate script that does the file size validation
before running checkpatch?

Also:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +	if ($max_file_size > 0) {
> +		my $filesize = -s$FILE;

Does this work if the input file is from STDIN?
I'd guess it does not.

I think this might be better using (stat($FILE))[7]
or at least a space between -s and $file.


