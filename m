Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBC22F8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgG0TEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 15:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgG0TEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:04:14 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353F72074F;
        Mon, 27 Jul 2020 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595876653;
        bh=lwunSgBdP0QP08cmjm8SVF811nFggBFZyE9513O5AFU=;
        h=Date:From:To:Cc:Subject:From;
        b=HA1b4Q5WTZfBweqH8pgrLcFkORB4/jQMyucR+NA2CofvHx/9zL++cmFhqp4clWBP6
         ey5PPrztksg76Up3Bib78EUimHuKzgs1zLoUXLShp/ZPLIPSxYMwDj6oGgXwQsDv/3
         mwjAIhuLhb+cvIk38H/PDg5B6d4IvxX0hMfK6W4I=
Date:   Mon, 27 Jul 2020 14:10:06 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: rtl8192e: Use fallthrough pseudo-keyword
Message-ID: <20200727191006.GA30474@embeddedor>
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
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 7e7df50164fb..aa26b2fd2774 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -680,7 +680,7 @@ int rtllib_wx_set_mlme(struct rtllib_device *ieee,
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 		deauth = true;
-		/* fall through */
+		fallthrough;
 	case IW_MLME_DISASSOC:
 		if (deauth)
 			netdev_info(ieee->dev, "disauth packet !\n");
-- 
2.27.0

