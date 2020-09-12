Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E234267BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgILSWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 14:22:21 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:47890 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgILSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 14:22:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2D7D0100E7B40;
        Sat, 12 Sep 2020 18:22:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3872:4321:5007:7514:7904:10004:10400:10848:11026:11232:11657:11658:11914:12043:12114:12297:12438:12555:12740:12760:12895:13439:14181:14659:14721:21080:21451:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: copy82_03013a6270f9
X-Filterd-Recvd-Size: 3020
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Sep 2020 18:22:09 +0000 (UTC)
Message-ID: <f5fdb27843143dfefb1a1a416dab63931fef6d41.camel@perches.com>
Subject: Re: [PATCH 1/5] staging: rtl8723bs: refactor cckrates{only}_included
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Sep 2020 11:22:08 -0700
In-Reply-To: <20200912084520.8383-1-straube.linux@gmail.com>
References: <20200912084520.8383-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-12 at 10:45 +0200, Michael Straube wrote:
> Refactor cckrates_included() and cckratesonly_included() to simplify
> the code and improve readability.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> index a5790a648a5b..4e0d86b2e2e0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> @@ -56,11 +56,12 @@ static u8 rtw_basic_rate_ofdm[3] = {
>  
>  int cckrates_included(unsigned char *rate, int ratelen)
>  {
> -	int	i;
> +	int i;
>  
>  	for (i = 0; i < ratelen; i++) {
> -		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
> -		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
> +		u8 r = rate[i] & 0x7f;
> +
> +		if (r == 2 || r == 4 || r == 11 || r == 22)
>  			return true;
>  	}
>  
> @@ -69,11 +70,12 @@ int cckrates_included(unsigned char *rate, int ratelen)
>  
>  int cckratesonly_included(unsigned char *rate, int ratelen)
>  {
> -	int	i;
> +	int i;
>  
>  	for (i = 0; i < ratelen; i++) {
> -		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
> -		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
> +		u8 r = rate[i] & 0x7f;
> +
> +		if (r != 2 && r != 4 && r != 11 && r != 22)
>  			return false;

It would be simpler to add and use an inline like:

static bool is_cckrate(unsigned char rate)
{
	rate &= 0x7f;
	return rate == 2 || rate == 4 || rate == 11 || rate == 22;
}

so these could be

bool cckrates_included(unsigned char *rate, int ratelen)
{
	int i;

	for (i = 0; i < ratelen; i++) {
		if (is_cckrate(rate[i])
			return true;
	}

	return false;
}

bool cckratesonly_included(unsigned char *rate, int ratelen)
{
	int i;

	if (i <= 0)
		return false;

	for (i = 0; i < ratelen; i++) {
		if (!is_cckrate(rate[i])
			return false;
	}

	return true;
}


