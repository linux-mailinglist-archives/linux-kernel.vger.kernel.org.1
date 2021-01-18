Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD02FA9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393854AbhARTPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390499AbhARLiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:38:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E30132222A;
        Mon, 18 Jan 2021 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610969910;
        bh=kWhOzAdkTXy+9UCZnMpRganGk8nlq9W5/xwqYfTXAKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcUbie/vg2ZJucPECDAMRxfcYVUx/e1L7pWOEmkqLbIYU993gyelutdviwTrhnlcO
         IV6ZbphUsbIh7C/yMq6ucngYQjXoYJno/7I60l9tAlkEQN7Q4h6QGeslVDVfGI0uju
         yCbsRN3ssaNSNop0pMmZuLCZcm1sdk/BxoyXWYlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 34/76] habanalabs: Fix memleak in hl_device_reset
Date:   Mon, 18 Jan 2021 12:34:34 +0100
Message-Id: <20210118113342.611938292@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210118113340.984217512@linuxfoundation.org>
References: <20210118113340.984217512@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit b000700d6db50c933ce8b661154e26cf4ad06dba ]

When kzalloc() fails, we should execute hl_mmu_fini()
to release the MMU module. It's the same when
hl_ctx_init() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 3eeb1920ddb43..3486bf33474d9 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -959,6 +959,7 @@ again:
 						GFP_KERNEL);
 		if (!hdev->kernel_ctx) {
 			rc = -ENOMEM;
+			hl_mmu_fini(hdev);
 			goto out_err;
 		}
 
@@ -970,6 +971,7 @@ again:
 				"failed to init kernel ctx in hard reset\n");
 			kfree(hdev->kernel_ctx);
 			hdev->kernel_ctx = NULL;
+			hl_mmu_fini(hdev);
 			goto out_err;
 		}
 	}
-- 
2.27.0



