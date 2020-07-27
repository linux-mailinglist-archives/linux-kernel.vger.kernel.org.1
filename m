Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7722F87D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgG0Swu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 14:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0Swu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:52:50 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3764E2078E;
        Mon, 27 Jul 2020 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595875969;
        bh=Rlvvu6EATVZAtEsKdXxHfq96qeAcjz+8DJxFncO7Gn4=;
        h=Date:From:To:Cc:Subject:From;
        b=04M8WY52ld4Y0yJ1B5tNJfQYzXAlzl2IS91jkqY7IlcTcdEs4J53uiaXaS7BGAfI4
         WKcVOOOTf8CIs+MNiz7O6HysvDsnqnFM/YFJDmjzwI8X512uB+zCs6hPZkoS4+zLl9
         Tgd50DFvZa7VQflgBKxCpa31r+AbmmE4ed7V2XSE=
Date:   Mon, 27 Jul 2020 13:58:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: rtl8712: Use fallthrough pseudo-keyword
Message-ID: <20200727185838.GA29595@embeddedor>
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
 drivers/staging/rtl8712/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index 0045da3bb69a..9a04a752af13 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -225,7 +225,7 @@ static void r8712_usb_read_port_complete(struct urb *purb)
 				padapter->driver_stopped = true;
 				break;
 			}
-			/* Fall through. */
+			fallthrough;
 		case -EPROTO:
 			r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
 				  (unsigned char *)precvbuf);
-- 
2.27.0

