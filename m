Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9055C201A24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392382AbgFSSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbgFSSRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:17:03 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A007C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:17:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C11D1500C95;
        Fri, 19 Jun 2020 20:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592590153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SILFzMVccKrV281bI6jdOhgiu8tPS0OZxkg8dbvwVUg=;
        b=l/ydt1WfPHHQV8saa28Dmt/1x3dfYWQgm+DiaPDrCCpFAGYMXbdpGm2iW2uY7yv1FAofUd
        JHPsO3ZvKKeaTgA1yWnSmlKFSVMVTudHKq/G1GdNPzwN4WUqX2/l2Y91dJSS47Gp9ATTMO
        wXp1R6XDNGuSZ+aRxiNqEL565M1eHPxOIrf4wUPaBC9F2HdqmlcrHSt+bRRFr4gUmW+0Uw
        cm1bPnnhgW7TiDu5Xlgxlof3mpheJe9JxNUTrCTi7iHV3S7HTiRSKTEYnXNE1j8SE73lLM
        DGkc5zaBgM6iLrWdl046+NaxwmCwk7kG0ChJ6LvN/TXHi2vACmcfRuR78KuTSA==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] drivers: cdrom: add missing SPDX license identifier
Date:   Fri, 19 Jun 2020 20:08:34 +0200
Message-Id: <20200619180834.8032-2-devel@superboring.dev>
In-Reply-To: <20200619180834.8032-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's in gdrom.c but missing in cdrom.c

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 8e3df970e4c2..ccf377821822 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* linux/drivers/cdrom/cdrom.c
    Copyright (c) 1996, 1997 David A. van Leeuwen.
    Copyright (c) 1997, 1998 Erik Andersen <andersee@debian.org>
-- 
2.27.0

