Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A82F1315
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbhAKNDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbhAKNDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:03:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A8F225AC;
        Mon, 11 Jan 2021 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610370135;
        bh=8lGXfChzd96VRmdI3XiedLSbfp9gS012jJfWzenkTac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnGeiSY8/vDt6QljF0c8O2ADBdTNy8jcaR9+sKsy3CnZ9brwWvKhWtoX6bPRPHKyi
         M/TFE25jPAJI0dvDxzyKCkmzbw1U7+pfMYs+slpbjPCNi3YGjZS7TNJXNDdTcmyX4Z
         5SSLusyXE7MOjXoNZ7SBvAJzOyy0dnFY2T683BdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 32/38] USB: serial: keyspan_pda: remove unused variable
Date:   Mon, 11 Jan 2021 14:01:04 +0100
Message-Id: <20210111130034.004813791@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111130032.469630231@linuxfoundation.org>
References: <20210111130032.469630231@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

Remove an unused variable which was mistakingly left by commit
37faf5061541 ("USB: serial: keyspan_pda: fix write-wakeup
use-after-free") and only removed by a later change.

This is needed to suppress a W=1 warning about the unused variable in
the stable trees that the build bots triggers.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/keyspan_pda.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -559,10 +559,8 @@ exit:
 static void keyspan_pda_write_bulk_callback(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
-	struct keyspan_pda_private *priv;
 
 	set_bit(0, &port->write_urbs_free);
-	priv = usb_get_serial_port_data(port);
 
 	/* queue up a wakeup at scheduler time */
 	usb_serial_port_softint(port);


