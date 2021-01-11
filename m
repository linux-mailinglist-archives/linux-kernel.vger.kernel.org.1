Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD42F1404
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbhAKNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732890AbhAKNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:18:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BD0A22AAF;
        Mon, 11 Jan 2021 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610371076;
        bh=F8dE9/9hHyEea8bIJ3qT11lMXYxPPGa+Knv6c+WlJK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4Wf0isXua93p/fGB/7dT1L4hwGx0kVKQYTmMyAcu+NhgVqk2fBSCG0xiUUHRV2yd
         0j6h3+4KOgI6ds9e9rAHN9iH1moQJdCDCyzq2jx9thDwT/MTb2KgdwlFVUvFV9meOi
         pNINLZR7MQYpmc1B8EICnbX8a7ksvn3wyIN42fds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: [PATCH 5.10 101/145] usb: gadget: function: printer: Fix a memory leak for interface descriptor
Date:   Mon, 11 Jan 2021 14:02:05 +0100
Message-Id: <20210111130053.383423116@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111130048.499958175@linuxfoundation.org>
References: <20210111130048.499958175@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

commit 2cc332e4ee4febcbb685e2962ad323fe4b3b750a upstream.

When printer driver is loaded, the printer_func_bind function is called, in
this function, the interface descriptor be allocated memory, if after that,
the error occurred, the interface descriptor memory need to be free.

Reviewed-by: Peter Chen <peter.chen@nxp.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Link: https://lore.kernel.org/r/20201210020148.6691-1-qiang.zhang@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_printer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1162,6 +1162,7 @@ fail_tx_reqs:
 		printer_req_free(dev->in_ep, req);
 	}
 
+	usb_free_all_descriptors(f);
 	return ret;
 
 }


