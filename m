Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1322257F5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGTGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 02:43:28 -0400
Received: from mail.mutex.one ([62.77.152.124]:35962 "EHLO mail.mutex.one"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:43:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 8ABA8BF40815;
        Mon, 20 Jul 2020 09:43:25 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aUSDTB5AIWjP; Mon, 20 Jul 2020 09:43:12 +0300 (EEST)
Received:  [127.0.0.1] (localhost [127.0.0.1])nknown [109.103.89.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mutex.one (Postfix) with ESMTPSA id 6ABCFBF403B7;
        Mon, 20 Jul 2020 09:43:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1595227392; bh=ab3sxIvVtMy1RpXy10nipXf7bkDHQgf370zh7TMSvNE=;
        h=From:To:Cc:Subject:Date:From;
        b=CpFPhet9j73/ovt+/LAfa/zcl+PZl6teedHLNxHqC9p7BFKqsl+/BZn5lutmWsCim
         E4paD9c/4t+6HT5A5tlWGvUrw6GlCmWe9OBC3stkWDoCkDZF8lJMYm1hDjKD90E7lQ
         bZ/cIRda5hxP2gTyrOFaJzXq9CC0WGVeeNsgzRhs=
From:   Marian Posteuca <posteuca@mutex.one>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     Marian Posteuca <posteuca@mutex.one>
Subject: [PATCH v2] staging: dpaa2-ethsw: fix switch/case fallthrough warning
Date:   Mon, 20 Jul 2020 09:42:05 +0300
Message-Id: <20200720064205.10323-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the fallthrough warning that is reported by checkpatch.

Signed-off-by: Marian Posteuca <posteuca@mutex.one>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 2fb75a7c9314..db10fd18914d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1362,7 +1362,7 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 		return NOTIFY_DONE;
 
 	switch (event) {
-	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
+	case SWITCHDEV_PORT_OBJ_ADD:
 	case SWITCHDEV_PORT_OBJ_DEL:
 		return ethsw_switchdev_port_obj_event(event, dev, ptr);
 	case SWITCHDEV_PORT_ATTR_SET:
-- 
2.26.2

