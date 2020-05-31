Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87BD1E98C6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgEaQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 12:16:01 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:40564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgEaQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 12:16:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2D08B513;
        Sun, 31 May 2020 16:16:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:4321:5007:6119:6742:10004:10400:11026:11232:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sand35_0d17f8e26d76
X-Filterd-Recvd-Size: 2058
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 31 May 2020 16:15:57 +0000 (UTC)
Message-ID: <7bf8612d3708b811e026daec5c7a1486c5954905.camel@perches.com>
Subject: Re: [PATCH] staging:r8723bs: remove wrappers around skb_clone()
From:   Joe Perches <joe@perches.com>
To:     Ivan Safonov <insafonov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lukasz Szczesny <luk@wybcz.pl>, R Veera Kumar <vkor@vkten.in>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 31 May 2020 09:15:56 -0700
In-Reply-To: <20200531160843.39120-1-insafonov@gmail.com>
References: <20200531160843.39120-1-insafonov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-31 at 19:08 +0300, Ivan Safonov wrote:
> Wrappers around skb_clone() do not simplify the driver code.
[]
> -inline struct sk_buff *_rtw_skb_clone(struct sk_buff *skb)
> -{
> -	return skb_clone(skb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
> -}
> -
[]
> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
[]
> @@ -110,7 +110,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
>  			if (memcmp(pattrib->dst, myid(&padapter->eeprompriv), ETH_ALEN)) {
>  				if (bmcast) {
>  					psta = rtw_get_bcmc_stainfo(padapter);
> -					pskb2 = rtw_skb_clone(pkt);
> +					pskb2 = skb_clone(pkt, GFP_ATOMIC);

Why make every clone allocation GFP_ATOMIC ?


