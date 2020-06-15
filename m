Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D911F9FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbgFOTH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 15:07:27 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:44316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729354AbgFOTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:07:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4E3B118029126;
        Mon, 15 Jun 2020 19:07:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1461:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3151:3353:3622:3865:3867:3868:3871:4321:5007:7903:8603:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12555:12740:12760:12895:13439:14181:14659:14721:21080:21220:21600:21611:21627:21987:21990:30003:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:6,LUA_SUMMARY:none
X-HE-Tag: actor55_460e15f26df8
X-Filterd-Recvd-Size: 4226
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 19:07:23 +0000 (UTC)
Message-ID: <3d843013419f2946cf991913c76b8d0218930366.camel@perches.com>
Subject: Re: [PATCH] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
From:   Joe Perches <joe@perches.com>
To:     Zhixu Zhao <zhixu001@126.com>, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Jun 2020 12:07:22 -0700
In-Reply-To: <20200614135131.11282-1-zhixu001@126.com>
References: <20200614135131.11282-1-zhixu001@126.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-14 at 21:51 +0800, Zhixu Zhao wrote:
> Fix a coding alignment issue found by checkpatch.pl.

Another option would be to use a temporary for
gasket_dev->bar_data[bar_num]

Something like:
---
 drivers/staging/gasket/gasket_core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 67325fbaf760..73b138f984cf 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -262,6 +262,7 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 		internal_desc->driver_desc;
 	ulong desc_bytes = driver_desc->bar_descriptions[bar_num].size;
 	int ret;
+	struct gasket_bar_data *data;
 
 	if (desc_bytes == 0)
 		return 0;
@@ -270,31 +271,32 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 		/* not PCI: skip this entry */
 		return 0;
 	}
+
+	data = &gasket_dev->bar_data[bar_num];
+
 	/*
 	 * pci_resource_start and pci_resource_len return a "resource_size_t",
 	 * which is safely castable to ulong (which itself is the arg to
 	 * request_mem_region).
 	 */
-	gasket_dev->bar_data[bar_num].phys_base =
+	data->phys_base =
 		(ulong)pci_resource_start(gasket_dev->pci_dev, bar_num);
-	if (!gasket_dev->bar_data[bar_num].phys_base) {
+	if (!data->phys_base) {
 		dev_err(gasket_dev->dev, "Cannot get BAR%u base address\n",
 			bar_num);
 		return -EINVAL;
 	}
 
-	gasket_dev->bar_data[bar_num].length_bytes =
+	data->length_bytes =
 		(ulong)pci_resource_len(gasket_dev->pci_dev, bar_num);
-	if (gasket_dev->bar_data[bar_num].length_bytes < desc_bytes) {
+	if (data->length_bytes < desc_bytes) {
 		dev_err(gasket_dev->dev,
 			"PCI BAR %u space is too small: %lu; expected >= %lu\n",
-			bar_num, gasket_dev->bar_data[bar_num].length_bytes,
-			desc_bytes);
+			bar_num, data->length_bytes, desc_bytes);
 		return -ENOMEM;
 	}
 
-	if (!request_mem_region(gasket_dev->bar_data[bar_num].phys_base,
-				gasket_dev->bar_data[bar_num].length_bytes,
+	if (!request_mem_region(data->phys_base, data->length_bytes,
 				gasket_dev->dev_info.name)) {
 		dev_err(gasket_dev->dev,
 			"Cannot get BAR %d memory region %p\n",
@@ -302,10 +304,8 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 		return -EINVAL;
 	}
 
-	gasket_dev->bar_data[bar_num].virt_base =
-		ioremap(gasket_dev->bar_data[bar_num].phys_base,
-				gasket_dev->bar_data[bar_num].length_bytes);
-	if (!gasket_dev->bar_data[bar_num].virt_base) {
+	data->virt_base = ioremap(data->phys_base, data->length_bytes);
+	if (!data->virt_base) {
 		dev_err(gasket_dev->dev,
 			"Cannot remap BAR %d memory region %p\n",
 			bar_num, &gasket_dev->pci_dev->resource[bar_num]);
@@ -319,9 +319,8 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 	return 0;
 
 fail:
-	iounmap(gasket_dev->bar_data[bar_num].virt_base);
-	release_mem_region(gasket_dev->bar_data[bar_num].phys_base,
-			   gasket_dev->bar_data[bar_num].length_bytes);
+	iounmap(data->virt_base);
+	release_mem_region(data->phys_base, data->length_bytes);
 	return ret;
 }
 

