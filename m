Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6562E2850
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 18:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgLXRQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 12:16:43 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:53074 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727081AbgLXRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 12:16:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8589B837F27B;
        Thu, 24 Dec 2020 17:15:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:7652:7903:8957:9036:9592:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12297:12438:12555:12740:12895:13439:13894:13972:14659:14721:21080:21324:21451:21627:21990:30003:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: space81_481839827473
X-Filterd-Recvd-Size: 3587
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Dec 2020 17:15:58 +0000 (UTC)
Message-ID: <62a06f2c17df6ecac4a64a0c0d3af67fc1f54461.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8723bs: clean up brace coding style issues
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Dec 2020 09:15:56 -0800
In-Reply-To: <20201222141707.31972-1-straube.linux@gmail.com>
References: <20201222141707.31972-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-22 at 15:17 +0100, Michael Straube wrote:
> Add missing braces around else arm of if else statement to clear
> style issues reported by checkpatch.
> 
> CHECK: braces {} should be used on all arms of this statement
> CHECK: Unbalanced braces around else statement
[]
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
[]
> @@ -245,8 +245,9 @@ u16 	Address)
>  				break;
>  		}
>  		return rtw_read8(Adapter, EFUSE_CTRL);
> -	} else
> +	} else {
>  		return 0xFF;
> +	}

Instead, when you see a pattern like this it's generally
better to reverse whatever test is above this, return early
and unindent the block above the else.

Here that would be:
---
diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 32ca10f01413..e5c3dba5c8ae 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -222,31 +222,31 @@ u16 	Address)
 
 	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
 
-	if (Address < contentLen) {/* E-fuse 512Byte */
-		/* Write E-fuse Register address bit0~7 */
-		temp = Address & 0xFF;
-		rtw_write8(Adapter, EFUSE_CTRL+1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+2);
-		/* Write E-fuse Register address bit8~9 */
-		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
-		rtw_write8(Adapter, EFUSE_CTRL+2, temp);
-
-		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
-		temp = Bytetemp & 0x7F;
-		rtw_write8(Adapter, EFUSE_CTRL+3, temp);
+	if (Address >= contentLen)	/* E-fuse 512Byte */
+		return 0xFF;
 
-		/* Wait Write-ready (0x30[31]= 1) */
+	/* Write E-fuse Register address bit0~7 */
+	temp = Address & 0xFF;
+	rtw_write8(Adapter, EFUSE_CTRL+1, temp);
+	Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+2);
+	/* Write E-fuse Register address bit8~9 */
+	temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
+	rtw_write8(Adapter, EFUSE_CTRL+2, temp);
+
+	/* Write 0x30[31]= 0 */
+	Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+	temp = Bytetemp & 0x7F;
+	rtw_write8(Adapter, EFUSE_CTRL+3, temp);
+
+	/* Wait Write-ready (0x30[31]= 1) */
+	Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
+	while (!(Bytetemp & 0x80)) {
 		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
-		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL+3);
-			k++;
-			if (k == 1000)
-				break;
-		}
-		return rtw_read8(Adapter, EFUSE_CTRL);
-	} else
-		return 0xFF;
+		k++;
+		if (k == 1000)
+			break;
+	}
+	return rtw_read8(Adapter, EFUSE_CTRL);
 
 } /* EFUSE_Read1Byte */
 

