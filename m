Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A1922DBD9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 06:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGZE1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 00:27:11 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:52520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgGZE1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:27:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4EE8F173085C;
        Sun, 26 Jul 2020 04:27:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:617:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2689:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:6119:7903:8957:9025:10004:10400:10848:10967:11232:11658:11914:12043:12295:12297:12555:12740:12895:13095:13149:13157:13161:13184:13228:13229:13230:13894:14180:14181:14659:14721:21080:21433:21451:21611:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trick38_4d04a9326f55
X-Filterd-Recvd-Size: 3124
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 04:27:08 +0000 (UTC)
Message-ID: <6d88f6b08442b064062449c6379aa7d3b9b68ff0.camel@perches.com>
Subject: Re: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Date:   Sat, 25 Jul 2020 21:27:07 -0700
In-Reply-To: <20200725233557.8154-1-sj38.park@gmail.com>
References: <20200725233557.8154-1-sj38.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 01:35 +0200, SeongJae Park wrote:
> On Sat, 25 Jul 2020 10:29:23 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> > > Hello,
> > > 
> > > I see that this patch went into next and is already inciting people to
> > > do wrong things [1]. Can you please fix it to require '--subjective'
> > > switch or otherwise mark it clearly as suggestion-only?
> > > 
> > > The coding-style as in Linus' master says about *NEW* uses of the words
> > > listed (those introductions I expect to be actually rare) and not about
> > > existing use in the code or industry. Making a noise about all uses
> > > found surely will generate a lot more irrelevant patches.
> > > 
> > > [1] https://www.spinics.net/lists/linux-tegra/msg51849.html
> > 
> > And if not reverted, perhaps do not check existing files
> > at all but only check patches and change the message to
> > show only suggestions not from a specification.
> 
> Agreed for this case.  However, excluding existing file check doesn't fully
> avoid this problem.  Also, more terms having different deprecation rules might
> be added in future.  How about allowing file check but show reference in the
> suggestion message as below?

The general problem is that drivers/staging, net/ and drivers/net
all have --strict on by default.

Emitting these deprecated terms messages with -f --file uses for
files in those directories isn't a great idea.

> diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
[]
> @@ -3,8 +3,10 @@
>  # The format of each line is:
>  # deprecated||suggested
>  #
> +# If special rules are applied on the terms, please comment those.

Disagree.  Comments about these existing uses aren't helpful.

> +#
> +# Refer to "4) Naming" section of Documentation/process/coding-style.rst for
> +# below three terms.
>  blacklist||(denylist|blocklist)
> -# For other alternatives of 'slave', Please refer to
> -# Documentation/process/coding-style.rst
>  slave||(secondary|target|...)
>  whitelist||(allowlist|passlist)


