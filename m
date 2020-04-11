Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3769B1A538F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgDKTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 15:43:34 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:41654 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgDKTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:43:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 70B222C9D;
        Sat, 11 Apr 2020 19:43:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2915:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3873:4321:5007:7576:7903:8957:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13069:13095:13311:13357:13439:14181:14659:14721:19904:19999:21080:21433:21451:21627:30029:30054:30069:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: owl05_1ed6d11cbc207
X-Filterd-Recvd-Size: 1962
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 19:43:31 +0000 (UTC)
Message-ID: <8d097283a4676f7e1050c9d6664d89d710e21bcf.camel@perches.com>
Subject: Re: [PATCH] taging: android: ashmem: Declared const key
From:   Joe Perches <joe@perches.com>
To:     MugilRaj <dmugil2000@gmail.com>
Cc:     mugil2301 <110117057@nitt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 Apr 2020 12:41:26 -0700
In-Reply-To: <1586633396-24237-1-git-send-email-dmugil2000@gmail.com>
References: <1586633396-24237-1-git-send-email-dmugil2000@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-04-12 at 00:59 +0530, MugilRaj wrote:
> From: mugil2301 <110117057@nitt.edu>

You need to verify the patch subject.
You need a change log message too.

> Signed-off-by: mugil2301 <110117057@nitt.edu>

You need to put your legal name here

> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
[]
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const  struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;

(this won't compile)

checkpatch is not always right.

Do please compile the files changed by your patch
and verify change correctness before sending any
proposed patch.


