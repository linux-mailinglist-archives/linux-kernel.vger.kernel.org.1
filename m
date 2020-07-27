Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3922F88E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgG0S6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 14:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgG0S6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:58:25 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F64D2074F;
        Mon, 27 Jul 2020 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595876304;
        bh=7TL0k8xwIrZ4RrOx7UaFF8YBs/3kDad7f/2jg+nD6mY=;
        h=Date:From:To:Cc:Subject:From;
        b=VpH41A1pvYiptbEaHUTAkLoprpLXEC2sXpAwMDlVZXUPvsD4H2fjmYMsC4ZKUIxcV
         WdhzZ3auc9SwkSQk/r+lOMeEjhiiEFhj7jib+nOW0ryCYRm/oyGI+ZVmj44E0ENEu1
         COUkU81uY7+BleTQYiUKJ8+auEtena+N8bnezdyk=
Date:   Mon, 27 Jul 2020 14:04:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: ks7010: Use fallthrough pseudo-keyword
Message-ID: <20200727190417.GA29944@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 334ae1ded684..dc09cc6e1c47 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -426,16 +426,16 @@ static int ks_wlan_set_rate(struct net_device *dev,
 					priv->reg.rate_set.body[3] =
 					    TX_RATE_11M;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 5500000:
 					priv->reg.rate_set.body[2] = TX_RATE_5M;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 2000000:
 					priv->reg.rate_set.body[1] =
 					    TX_RATE_2M | BASIC_RATE;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 1000000:
 					priv->reg.rate_set.body[0] =
 					    TX_RATE_1M | BASIC_RATE;
@@ -491,17 +491,17 @@ static int ks_wlan_set_rate(struct net_device *dev,
 					priv->reg.rate_set.body[11] =
 					    TX_RATE_54M;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 48000000:
 					priv->reg.rate_set.body[10] =
 					    TX_RATE_48M;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 36000000:
 					priv->reg.rate_set.body[9] =
 					    TX_RATE_36M;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 24000000:
 				case 18000000:
 				case 12000000:
@@ -578,17 +578,17 @@ static int ks_wlan_set_rate(struct net_device *dev,
 						    TX_RATE_6M | BASIC_RATE;
 						i++;
 					}
-					/* fall through */
+					fallthrough;
 				case 5500000:
 					priv->reg.rate_set.body[2] =
 					    TX_RATE_5M | BASIC_RATE;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 2000000:
 					priv->reg.rate_set.body[1] =
 					    TX_RATE_2M | BASIC_RATE;
 					i++;
-					/* fall through */
+					fallthrough;
 				case 1000000:
 					priv->reg.rate_set.body[0] =
 					    TX_RATE_1M | BASIC_RATE;
-- 
2.27.0

