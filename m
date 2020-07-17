Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191EC223692
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGQIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 04:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgGQIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:05:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4059CAFF1;
        Fri, 17 Jul 2020 08:06:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] media: atomisp: do not free kmalloc memory by vfree
Date:   Fri, 17 Jul 2020 10:05:58 +0200
Message-Id: <20200717080558.24829-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <b7636799383bfb85c59d27e140a3c0e56d4af87d.camel@perches.com>
References: <b7636799383bfb85c59d27e140a3c0e56d4af87d.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fw_minibuffer[i].buffer is allocated by kmalloc in sh_css_load_blob_info
and by vmalloc in setup_binary. So use kvfree to decide which of those
allocators to use for freeing.

Also remove the useless cast.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/sh_css_firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_firmware.c b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
index d4ab15b6d1ac..d0011b1d97ed 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_firmware.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_firmware.c
@@ -358,7 +358,7 @@ void sh_css_unload_firmware(void)
 			if (fw_minibuffer[i].name)
 				kfree((void *)fw_minibuffer[i].name);
 			if (fw_minibuffer[i].buffer)
-				vfree((void *)fw_minibuffer[i].buffer);
+				kvfree(fw_minibuffer[i].buffer);
 		}
 		kfree(fw_minibuffer);
 		fw_minibuffer = NULL;
-- 
2.27.0

