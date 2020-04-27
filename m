Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E091BB0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD0Vqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:46:34 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:52642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgD0Vqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:46:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DEC1752AD;
        Mon, 27 Apr 2020 21:46:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2538:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3874:4250:4321:5007:6117:6119:6120:7875:10004:10400:11232:11657:11658:11914:12043:12291:12297:12679:12683:12740:12760:12895:13019:13069:13076:13311:13357:13439:14181:14659:14721:21080:21451:21627:21939:30054:30060:30067:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: anger90_903895eead545
X-Filterd-Recvd-Size: 2218
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 21:46:30 +0000 (UTC)
Message-ID: <e9f534ef6c90d98d9cae0cbf133c8d83ecdce790.camel@perches.com>
Subject: Re: [PATCH v3.1] docs: filesystems: convert configfs.txt to ReST
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-usb@vger.kernel.org
Date:   Mon, 27 Apr 2020 14:46:29 -0700
In-Reply-To: <5f005c5a846b3fd4382a24166a1ba736ff697b86.1588022310.git.mchehab+huawei@kernel.org>
References: <c2424ec2ad4d735751434ff7f52144c44aa02d5a.1588021877.git.mchehab+huawei@kernel.org>
         <5f005c5a846b3fd4382a24166a1ba736ff697b86.1588022310.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 23:43 +0200, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document and section titles;
> - Use copyright symbol;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to filesystems/index.rst.
> 
> Also, as this file is alone on its own dir, and it doesn't
> seem too likely that other documents will follow it, let's
> move it to the filesystems/ root documentation dir.
[]
> diff --git a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs.rst
[]
> +++ b/Documentation/filesystems/configfs.rst
> @@ -1,5 +1,6 @@
> -
> -configfs - Userspace-driven kernel object configuration.
> +=======================================================
> +Configfs - Userspace-driven Kernel Object Configuration

trivia: likely this "Configfs" shouldn't be capitalized.



