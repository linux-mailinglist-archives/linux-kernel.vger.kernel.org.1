Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B02EAC5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbhAENxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbhAENxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:53:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CF0229C4;
        Tue,  5 Jan 2021 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609854781;
        bh=X3pkoKN+qZs+mrVkpCsjBnon/jYeQ9iVsUlzY0JchE0=;
        h=From:To:Cc:Subject:Date:From;
        b=BlZBfPQ4Siw1jwxbe/wPWPiSSEJxUF3SXt84aA5z9inaso4kkuG7OEQDCtYsw7lKm
         1PjfAP5VUvMlBOgXCD9PqOhCCkcmxW9Yg5BHkPYTfWUriyUw5SLXO3Q2CYNNo5LYri
         MBEsKQL2xJPc5EW/Y0J7BADBxZSgHZzyyKnqmP+XN6PdQEgqk4ldNQ9wEc+/bwkg6c
         X6Abz3LCCt+ZcR8JoM7dBOON+j+9skX8beNN6KuGWQ1kXyjXDDQ8LLYJH/v96+hjs6
         d9YMhcuSbSwDQh2Br2pRDOnC4Fe7/DQejWVr2YCffo+7Q53CTFzQlyxdQ8/ecv4z42
         bilBSCE2aKDCw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marcelo Diop-Gonzalez <marcgonzalez@google.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq: fix uninitialized variable copy
Date:   Tue,  5 Jan 2021 14:52:45 +0100
Message-Id: <20210105135256.1810337-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Smatch found a local variable that can get copied to another
local variable without an initializion in the error case:

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1056 vchiq_get_user_ptr() error: uninitialized symbol 'ptr'.

This seems harmless, as the function should normally get inlined, with
the output directly written or not. In any case, the uninitialized data
is never used after get_user() fails.

As Dan mentions, it could still trigger an UBSAN runtime error, and it
is of course a bad idea to copy uninitialized variables, so just
bail out early.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c        | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f500a7043805..63a0045ef9c5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1057,14 +1057,21 @@ static inline int vchiq_get_user_ptr(void __user **buf, void __user *ubuf, int i
 		compat_uptr_t ptr32;
 		compat_uptr_t __user *uptr = ubuf;
 		ret = get_user(ptr32, uptr + index);
+		if (ret)
+			return ret;
+
 		*buf = compat_ptr(ptr32);
 	} else {
 		uintptr_t ptr, __user *uptr = ubuf;
 		ret = get_user(ptr, uptr + index);
+
+		if (ret)
+			return ret;
+
 		*buf = (void __user *)ptr;
 	}
 
-	return ret;
+	return 0;
 }
 
 struct vchiq_completion_data32 {
-- 
2.29.2

