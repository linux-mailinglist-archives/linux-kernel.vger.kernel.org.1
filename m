Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34645224B68
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGRNRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 09:17:16 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:36496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbgGRNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:17:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 84C0D181D207A;
        Sat, 18 Jul 2020 13:17:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2894:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7264:7903:7904:8957:10004:10400:10471:10848:11026:11473:11657:11658:11914:12043:12048:12295:12296:12297:12438:12555:12663:12683:12740:12760:12895:12986:13018:13019:13255:13439:14096:14097:14659:14721:21080:21324:21451:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: crib79_62139b626f13
X-Filterd-Recvd-Size: 3809
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Jul 2020 13:17:13 +0000 (UTC)
Message-ID: <560eeb7388164e58ac0e47277fe2aec798c45a5c.camel@perches.com>
Subject: Re: [PATCH 4/4] staging: rtl8188eu: include: placed constant on the
 right side of the test in comparisons
From:   Joe Perches <joe@perches.com>
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 18 Jul 2020 06:17:12 -0700
In-Reply-To: <20200718091857.quzs5sqvkjzngd6k@pesu-pes-edu>
References: <20200718091857.quzs5sqvkjzngd6k@pesu-pes-edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-18 at 05:18 -0400, B K Karthik wrote:
> placed constant on the right side of the test
> to fix warnings issued by checkpatch
[]
> diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
[]
> @@ -326,7 +326,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
>  
>  static inline int IsFrameTypeCtrl(unsigned char *pframe)
>  {
> -	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
> +	if (GetFrameType(pframe) == WIFI_CTRL_TYPE)
>  		return true;
>  	else
>  		return false;

Always try to improve code instead of merely shutting
up checkpatch warnings.

This function should likely be written:

static inline bool IsFrameTypeCtrl(unsigned char *pframe)
{
	return GetFrameType(pframe) == WIFI_CTRL_TYPE;
}

and given it's used only once, it might be expanded
in that place and removed altogether.

Something like:

(and the memcmp below could be ether_addr_equal instead
 but I'm too lazy to find out if the addresses are both
 guaranteed to be __aligned(2) which is likely)

---
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c | 8 +++++---
 drivers/staging/rtl8188eu/include/wifi.h        | 7 -------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 7d0135fde795..a2994f9ecbde 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -144,10 +144,12 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 
 	wlanhdr = precvframe->pkt->data;
 
-	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
-		!pattrib->icv_err && !pattrib->crc_err &&
+	pkt_info.bPacketMatchBSSID =
+		GetFrameType(wlanhdr) != WIFI_CTRL_TYPE &&
+		!pattrib->icv_err &&
+		!pattrib->crc_err &&
 		!memcmp(get_hdr_bssid(wlanhdr),
-		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
+			get_bssid(&padapter->mlmepriv), ETH_ALEN);
 
 	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
 				 (!memcmp(get_da(wlanhdr),
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 791f287a546d..3998d5633860 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -324,13 +324,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-static inline int IsFrameTypeCtrl(unsigned char *pframe)
-{
-	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
-		return true;
-	else
-		return false;
-}
 /*-----------------------------------------------------------------------------
 			Below is for the security related definition
 ------------------------------------------------------------------------------*/




