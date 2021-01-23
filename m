Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3960A30179A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAWSYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:24:49 -0500
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:59854 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbhAWSYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:24:46 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id AD8488123E2B;
        Sat, 23 Jan 2021 18:24:04 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5404A180A8151;
        Sat, 23 Jan 2021 18:23:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3151:3353:3865:3867:3871:3872:4321:5007:6119:7576:7652:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12438:12555:12740:12895:12986:13439:13894:13972:14093:14097:14181:14659:14721:21080:21433:21451:21600:21627:21990:30046:30054:30076:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rain26_55114d727576
X-Filterd-Recvd-Size: 3920
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Jan 2021 18:23:20 +0000 (UTC)
Message-ID: <f2f9cb12ad9d1bdadec799452f0be08a6967e5f4.camel@perches.com>
Subject: Re: [PATCH] usb: typec: tcpci_maxim: remove redundant assignment
From:   Joe Perches <joe@perches.com>
To:     angkery <angkery@163.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Date:   Sat, 23 Jan 2021 10:23:19 -0800
In-Reply-To: <20210123101410.1354-1-angkery@163.com>
References: <20210123101410.1354-1-angkery@163.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
On Sat, 2021-01-23 at 18:14 +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> PTR_ERR(chip->tcpci) has been used as a return value,
> it is not necessary to assign it to ret, so remove it.
[]
[]
> @@ -461,7 +461,6 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci)) {
>  		dev_err(&client->dev, "TCPCI port registration failed");

could add terminating '\n' to the formats where missed too.

> -		ret = PTR_ERR(chip->tcpci);
>  		return PTR_ERR(chip->tcpci);
>  	}
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
---
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 319266329b42..a51cd1682170 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -158,7 +158,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	 */
 	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, 2);
 	if (ret < 0) {
-		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d", ret);
+		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d\n", ret);
 		return;
 	}
 
@@ -167,13 +167,13 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 
 	if (count == 0 || frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP) {
 		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
-		dev_err(chip->dev, "%s", count ==  0 ? "error: count is 0" :
+		dev_err(chip->dev, "%s\n", count ==  0 ? "error: count is 0" :
 			"error frame_type is not SOP");
 		return;
 	}
 
 	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
-		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d", count);
+		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
 		return;
 	}
 
@@ -184,7 +184,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	count += 1;
 	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, count);
 	if (ret < 0) {
-		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d", ret);
+		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d\n", ret);
 		return;
 	}
 
@@ -317,7 +317,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 			return ret;
 
 		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
-			dev_info(chip->dev, "FRS Signal");
+			dev_info(chip->dev, "FRS Signal\n");
 			tcpm_sink_frs(chip->port);
 		}
 	}
@@ -460,7 +460,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR(chip->tcpci)) {
-		dev_err(&client->dev, "TCPCI port registration failed");
+		dev_err(&client->dev, "TCPCI port registration failed\n");
 		ret = PTR_ERR(chip->tcpci);
 		return PTR_ERR(chip->tcpci);
 	}


