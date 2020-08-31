Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE39257F29
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgHaQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 12:59:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:57784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgHaQ7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:59:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F07EAFB1;
        Mon, 31 Aug 2020 16:59:19 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Amit Shah <amit@kernel.org>,
        virtualization@lists.linux-foundation.org
Cc:     Michal Suchanek <msuchanek@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] char: virtio: Select VIRTIO from VIRTIO_CONSOLE.
Date:   Mon, 31 Aug 2020 18:58:50 +0200
Message-Id: <20200831165850.26163-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible to have virtio console built-in when
other virtio drivers are modular.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/char/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 3a144c000a38..9bd9917ca9af 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -93,8 +93,9 @@ config PPDEV
 
 config VIRTIO_CONSOLE
 	tristate "Virtio console"
-	depends on VIRTIO && TTY
+	depends on TTY
 	select HVC_DRIVER
+	select VIRTIO
 	help
 	  Virtio console for use with hypervisors.
 
-- 
2.28.0

