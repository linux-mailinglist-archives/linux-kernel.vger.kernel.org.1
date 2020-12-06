Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81742D0322
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgLFLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 06:04:59 -0500
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:37598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726886AbgLFLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 06:04:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EF590181D337B;
        Sun,  6 Dec 2020 11:04:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:2895:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:6691:7808:7901:7903:9545:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12297:12438:12555:12740:12895:13439:13894:14659:14721:21080:21433:21451:21627:30012:30054:30070:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pigs78_0c0172f273d5
X-Filterd-Recvd-Size: 3318
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Dec 2020 11:04:16 +0000 (UTC)
Message-ID: <ddd2feaa6dd064b20cb7015a2e569a92484dccdd.camel@perches.com>
Subject: Re: [PATCH 1/8] tty: serial: jsm: Fixed file by added more spacing
From:   Joe Perches <joe@perches.com>
To:     Clement Smith <rclemsmith@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 06 Dec 2020 03:04:11 -0800
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-12-06 at 13:09 +0530, Clement Smith wrote:
> Fixed a coding style issue

Don't send 8 identically titled patches that each change a single line.

Send one patch, with an updated title like:

	Subject: [PATCH] jsm_tty: Whitespace neatening

that changes _all_ the whitespace that you believe should be updated.

And ideally, instead of just whitespace changes, the code would be
updated to eliminate the code duplication by using temporaries and a
single line conversion.

> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
[]
> @@ -607,7 +607,7 @@ void jsm_input(struct jsm_channel *ch)
>  				 * Give the Linux ld the flags in the
>  				 * format it likes.
>  				 */
> -				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
> +				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
>  					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
>  				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
>  					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);

Something like:
---
 drivers/tty/serial/jsm/jsm_tty.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 689774c073ca..b48ca17f38d3 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -607,14 +607,20 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
+				u8 error = ch->ch_equeue[tail + i];
+				u8 read = ch->ch_rqueue[tail + i];
+				int type;
+
+				if (error & UART_LSR_BI)
+					type = TTY_BREAK;
+				else if (error & UART_LSR_PE)
+					type = TTY_PARITY;
+				else if (error & UART_LSR_FE)
+					type = TTY_FRAME;
 				else
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
+					type = TTY_NORMAL;
+				tty_insert_flip_char(port, read, type);
+
 			}
 		} else {
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);


