Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7755F1D6CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgEQUtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 16:49:53 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:48656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbgEQUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4A25D18225E0F;
        Sun, 17 May 2020 20:49:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:4321:5007:6120:7875:8957:10004:10400:10848:11026:11232:11657:11658:11914:12043:12048:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21990:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bean20_5608517ad065c
X-Filterd-Recvd-Size: 1980
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 17 May 2020 20:49:51 +0000 (UTC)
Message-ID: <ec2fa70939ab20dc7c454897b0b8ed08570dca80.camel@perches.com>
Subject: Re: [RFC PATCH] staging: rtl8192u: indicate_packets() can be static
From:   Joe Perches <joe@perches.com>
To:     kbuild test robot <lkp@intel.com>,
        Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Date:   Sun, 17 May 2020 13:49:50 -0700
In-Reply-To: <20200517202216.GA24634@8c544063f25c>
References: <20200517165819.136715-1-pterjan@google.com>
         <20200517202216.GA24634@8c544063f25c>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-18 at 04:22 +0800, kbuild test robot wrote:
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---

This doesn't apply on Linus' tree or -next so perhaps the
robot should put what tree and branch patches like these
are meant to be applied on after the --- line

>  ieee80211_rx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> index 3309f64be4c94..bceff1ba3d7d4 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
> @@ -520,7 +520,7 @@ static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_entry *p
>  	return true;
>  }
>  
> -void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
> +static void indicate_packets(struct ieee80211_device *ieee, struct ieee80211_rxb *rxb)
>  {
>  	struct net_device_stats *stats = &ieee->stats;
>  	struct net_device *dev = ieee->dev;

