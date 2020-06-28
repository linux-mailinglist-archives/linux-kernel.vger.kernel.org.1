Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9620C5E9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 06:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgF1EcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 00:32:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34360 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgF1Ebt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:31:49 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9589929730; Sun, 28 Jun 2020 00:31:45 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <c025aed0b1506399b73ff1d1bfa40ed641fcb3e3.1593318192.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1593318192.git.fthain@telegraphics.com.au>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 9/9] macintosh/via-macii: Clarify definition of macii_init()
Date:   Sun, 28 Jun 2020 14:23:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype correctly specifies the 'static' storage class.
Let the function definition match the declaration for better readability.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 2f9be4ec7d345..060e03f2264bc 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -140,7 +140,7 @@ static int macii_probe(void)
 }
 
 /* Initialize the driver */
-int macii_init(void)
+static int macii_init(void)
 {
 	unsigned long flags;
 	int err;
-- 
2.26.2

