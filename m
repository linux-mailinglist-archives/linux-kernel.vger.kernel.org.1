Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F0303684
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhAZG2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:28:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbhAYNvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:51:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 016D322C9C;
        Mon, 25 Jan 2021 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582505;
        bh=AcaNsyqWS7E9fmbvohuWKvcflFmetUfBx4IeXZnGD3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZqlux7RLukfTj2YfBCZwuMTMbkWSEkLdm7vINoDLSM+CNHicYYw7o28YSyXaMvmj
         Ac5ZCQlFjGsoPB6gD3P5CgFUHh2p+wfe2poSThrdW6DWm5SCk8ZjSzphmPbBBjyeS1
         9RyL0wd8BmVANDKR3UYE0dc34vWOdqMkEe9O9vtpb+kObXem83NGcLr7eFsAqcQ3l7
         TjQRM1cJDiu0+H3K3AEr1scca2ztrBIvwth2f4coeruuhN1Gctm2dNVPZz0BaFZWOn
         +/PQmVmODCdZAT2w33F+a7dwT0sJHsPPXJnwJK5lvDR7HR/3cSEJ713CDpYIELhiXP
         sDycd++19dPKQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42EL-00034X-RZ; Mon, 25 Jan 2021 14:48:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Pho Tran <Pho.Tran@silabs.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/7] USB: serial: cp210x: clean up flow-control debug message
Date:   Mon, 25 Jan 2021 14:48:14 +0100
Message-Id: <20210125134817.11749-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125134817.11749-1-johan@kernel.org>
References: <20210125134817.11749-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the flow-control debug message by abbreviating the field names
and reducing the value width to two characters. The latter improves
readability since all but the least significant byte will almost always
be zero anyway.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index aa874641374a..36ae44818c13 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1191,8 +1191,8 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 	flow_ctl.ulXonLimit = cpu_to_le32(128);
 	flow_ctl.ulXoffLimit = cpu_to_le32(128);
 
-	dev_dbg(&port->dev, "%s - ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
-			__func__, ctl_hs, flow_repl);
+	dev_dbg(&port->dev, "%s - ctrl = 0x%02x, flow = 0x%02x\n", __func__,
+			ctl_hs, flow_repl);
 
 	flow_ctl.ulControlHandshake = cpu_to_le32(ctl_hs);
 	flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
-- 
2.26.2

