Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68458225755
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 08:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgGTGJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 02:09:29 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:41092 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbgGTGJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:09:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1FA1F837F24C;
        Mon, 20 Jul 2020 06:09:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:3874:4321:5007:7903:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21660:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: leg43_5506a4026f22
X-Filterd-Recvd-Size: 1944
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Jul 2020 06:09:26 +0000 (UTC)
Message-ID: <9b0c3eb7088bfa2f64b143d70e5a4fb7947da330.camel@perches.com>
Subject: Re: [PATCH] staging: dpaa2-ethsw: fix switch/case fallthrough
 warning
From:   Joe Perches <joe@perches.com>
To:     Marian Posteuca <posteuca@mutex.one>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date:   Sun, 19 Jul 2020 23:09:25 -0700
In-Reply-To: <20200720053036.10383-1-posteuca@mutex.one>
References: <20200720053036.10383-1-posteuca@mutex.one>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-20 at 08:30 +0300, Marian Posteuca wrote:
> Fix the fallthrough warning that is reported by checkpatch.
> 
> Signed-off-by: Marian Posteuca <posteuca@mutex.one>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> index 2fb75a7c9314..4986591097dc 100644
> --- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> +++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> @@ -1362,7 +1362,8 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
>  		return NOTIFY_DONE;
>  
>  	switch (event) {
> -	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
> +	case SWITCHDEV_PORT_OBJ_ADD:
> +		fallthrough;

This comment is better removed instead of
converted to fallthrough;

It's no different than a multiple case block like:

	switch (val) {
	case FOO:
	case BAR:
		foobar();
		break;
	default:
		return baz;
	}

etc...


