Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C677A284C74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFNVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:21:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E99F2087E;
        Tue,  6 Oct 2020 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601990514;
        bh=dtA4Q7LXNjn5KiwhX+ZJk8faHWh8s1NtZiwfVEm6iBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOMyZYE8jzlDLNTTwWU4nLZZp4wqkK5Wg7gtRxHtiTUU69lxaaNn3FVtLbohSQH9u
         /mFeoTI5Di3ftBcBOURN46Db/SAyFUhK0kOIU/VZ2EH5bWE+dB7ardfiK0nlzh7z9y
         C1Oq1kXYoeOb6J1FljSoKRe7djvnI5Tl9iq575DY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPmuM-0018Kp-9F; Tue, 06 Oct 2020 15:21:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] firmware_loader: fix a kernel-doc markup
Date:   Tue,  6 Oct 2020 15:21:33 +0200
Message-Id: <23ec441bb9c206f5899b5d64d34e5c9f6add5fd9.1601990386.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601990386.git.mchehab+huawei@kernel.org>
References: <cover.1601990386.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware_fallback_sysfs had some changes at their
parameters. Those ended by dropping a documentation for
such parameter. Re-add it.

Fixes: 89287c169f8f ("firmware: Store opt_flags in fw_priv")
Fixes: c2c076166b58 ("firmware_loader: change enum fw_opt to u32")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/base/firmware_loader/fallback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index ac09aea3d797..4dec4b79ae06 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -623,6 +623,8 @@ static bool fw_run_sysfs_fallback(u32 opt_flags)
  * @fw: pointer to firmware image
  * @name: name of firmware file to look for
  * @device: device for which firmware is being loaded
+ * @opt_flags: options to control firmware loading behaviour, as defined by
+ *	       &enum fw_opt
  * @ret: return value from direct lookup which triggered the fallback mechanism
  *
  * This function is called if direct lookup for the firmware failed, it enables
-- 
2.26.2

