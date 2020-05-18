Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338D01D7A51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgERNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:48:12 -0400
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:1823 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgERNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:48:12 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 09:48:11 EDT
Received: from SZ11061793 (unknown [58.251.74.226])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id A1A835830E6;
        Mon, 18 May 2020 21:42:43 +0800 (CST)
From:   =?gb2312?B?zfWzzLjV?= <wangchenggang@vivo.com>
To:     "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Will Deacon'" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <kernel@vivo.com>
Subject: [PATCH] arch/arm64: Enlarge arm64 command line length to 4096 bytes
Date:   Mon, 18 May 2020 21:42:43 +0800
Message-ID: <00fc01d62d1a$35445a80$9fcd0f80$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdYtGFURNVMZj7AgREeJ7DTp+HLz+A==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VDSUhCQkJDQ0pMT09IQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Shw*Czg3QjQQNT4wMSIv
        GjlPCx1VSlVKTkNCQ0tCSE1IQkxCVTMWGhIXVQwaFRwYEx4VHBwaFRw7DRINFFUYFBZFWVdZEgtZ
        QVlOQ1VJTkpVTE9VSUlNWVdZCAFZQUpMQ0w3Bg++
X-HM-Tid: 0a722805bb8598b6kuuua1a835830e6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now android use many long command line, and oem need append some command
line to debug boot, so 2048 bytes cannot able to meet the requirement.
Enlarge arm64's command line length to 4096 bytes.

Signed-off-by: Chenggang Wang <wangchenggang@vivo.com>
---
 arch/arm64/include/uapi/asm/setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/setup.h
b/arch/arm64/include/uapi/asm/setup.h
index 5d703888f351..85e34aa784e0 100644
--- a/arch/arm64/include/uapi/asm/setup.h
+++ b/arch/arm64/include/uapi/asm/setup.h
@@ -22,6 +22,6 @@
 
 #include <linux/types.h>
 
-#define COMMAND_LINE_SIZE	2048
+#define COMMAND_LINE_SIZE	4096
 
 #endif
-- 
2.20.1

