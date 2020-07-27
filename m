Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5960622F7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 20:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgG0S1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 14:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgG0S1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:27:06 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBDC2073E;
        Mon, 27 Jul 2020 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595874425;
        bh=nl3YqSg5yRUKzi1NxGUaTX+dHjct03zN6hSrSzFt7ug=;
        h=Date:From:To:Cc:Subject:From;
        b=mtlb7pQv7oGj0f1ql71mGPzhVZsWpQvQErN5vyWDwwiVpxlyPXkmAJDduRQqMz/vD
         KJWUSxSxTOcDvIt4AP90BQW/pKJjZHkRkFfg8oYTIckexd5i143PLr97jjtcAa9VcX
         KQkgb73uR0zWHithBAj4OVOSHiUi7TZvTP6EXRKU=
Date:   Mon, 27 Jul 2020 13:32:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] greybus: Use fallthrough pseudo-keyword
Message-ID: <20200727183258.GA28571@embeddedor>
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
 drivers/greybus/es2.c       | 2 +-
 drivers/greybus/interface.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 366716f11b1a..1df6ab5d339d 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -759,7 +759,7 @@ static int check_urb_status(struct urb *urb)
 	case -EOVERFLOW:
 		dev_err(dev, "%s: overflow actual length is %d\n",
 			__func__, urb->actual_length);
-		/* fall through */
+		fallthrough;
 	case -ECONNRESET:
 	case -ENOENT:
 	case -ESHUTDOWN:
diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 67dbe6fda9a1..58ea374d8aaa 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -1233,7 +1233,7 @@ int gb_interface_add(struct gb_interface *intf)
 	case GB_INTERFACE_TYPE_GREYBUS:
 		dev_info(&intf->dev, "GMP VID=0x%08x, PID=0x%08x\n",
 			 intf->vendor_id, intf->product_id);
-		/* fall-through */
+		fallthrough;
 	case GB_INTERFACE_TYPE_UNIPRO:
 		dev_info(&intf->dev, "DDBL1 Manufacturer=0x%08x, Product=0x%08x\n",
 			 intf->ddbl1_manufacturer_id,
-- 
2.27.0

