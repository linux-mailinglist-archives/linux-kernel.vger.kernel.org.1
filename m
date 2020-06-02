Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5F1EB76B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFBIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 04:32:02 -0400
Received: from mailomta17-re.btinternet.com ([213.120.69.110]:39552 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgFBIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:32:02 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200602083159.THRB11381.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 2 Jun 2020 09:31:59 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [81.152.95.229]
X-OWM-Source-IP: 81.152.95.229 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffosedttdertdertddtnecuhfhrohhmpeflohhhnhcuqfhlughmrghnuceojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqeenucggtffrrghtthgvrhhnpeegfedthfefueeihffgkeefteehuddttdefudetveelveefvdefhfejieejhffggfenucfkphepkedurdduhedvrdelhedrvddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehhvghnrhihrdhhohhmvgdpihhnvghtpeekuddrudehvddrleehrddvvdelpdhmrghilhhfrhhomhepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoeguvghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrgheqpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (81.152.95.229) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5E3A195F13ABC0DB; Tue, 2 Jun 2020 09:31:59 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] staging: rtl8192e: Using comparison to false is error prone
Date:   Tue,  2 Jun 2020 09:31:27 +0100
Message-Id: <20200602083127.25271-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear below issues reported by checkpatch.pl:

CHECK: Using comparison to false is error prone

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index d83d72594312..8abc921ecb3e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -371,7 +371,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 	if ((ieee->iw_mode == IW_MODE_ADHOC) ||
 	    (ieee->iw_mode == IW_MODE_MASTER)) {
 		pHTInfoEle->ControlChl	= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset = ((pHT->bRegBW40MHz == false) ?
+		pHTInfoEle->ExtChlOffset = ((!pHT->bRegBW40MHz) ?
 					    HT_EXTCHNL_OFFSET_NO_EXT :
 					    (ieee->current_network.channel <= 6)
 					    ? HT_EXTCHNL_OFFSET_UPPER :
@@ -526,7 +526,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	static u8 EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
 	static u8 EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};
 
-	if (pHTInfo->bCurrentHTSupport == false) {
+	if (!pHTInfo->bCurrentHTSupport) {
 		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);
 		return;
 	}
@@ -873,7 +873,7 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 
-	if (pHTInfo->bRegBW40MHz == false)
+	if (!pHTInfo->bRegBW40MHz)
 		return;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-- 
2.17.1

