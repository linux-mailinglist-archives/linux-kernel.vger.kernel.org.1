Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8162FA95E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436929AbhARSyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407626AbhARSxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:53:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE48C22CA1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610995943;
        bh=GJwqoHFCgKzuo6XqtpQFCAp6J4lo7ISVnGnXRrRIuVs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OGX9+DaWaPUqukMrB34p3lbIRZWt2znui96fWzdv1qJt6DcHqFnkE10xZOtueWZx1
         74PCNsssg/uXh7d2TMNBafg1SmES4LoPmatFdmMHMxQGU6H88NDlcSr1hx5uhGurKe
         XeJtkYEnac05279nktL57I2wMn8ct0+B6m7W6AvDhuXMCCdxwjTdYo+DzvC5WDhzfn
         mvh99N+drkxmeHCZbYRqZEXkjnOep/L0mM3qb47J5kXBGajeD58jxFBCzHTTslye4O
         X57L5eEWgi2OF8VRPxNeSV/ReIPGWx7mBAFTl/qDVP08HnnN8lVMUy/ahlkZ71BAqU
         d4+qntqIgMDgQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] habanalabs: fix backward compatibility of idle check
Date:   Mon, 18 Jan 2021 20:52:16 +0200
Message-Id: <20210118185217.4389-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118185217.4389-1-ogabbay@kernel.org>
References: <20210118185217.4389-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to take the lower 32 bits of the driver's 64-bit idle mask and put
it in the legacy 32-bit variable that the userspace reads to know the
idle mask.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 12efbd9d2e3a..d25892d61ec9 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -133,6 +133,8 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 
 	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev,
 					&hw_idle.busy_engines_mask_ext, NULL);
+	hw_idle.busy_engines_mask =
+			lower_32_bits(hw_idle.busy_engines_mask_ext);
 
 	return copy_to_user(out, &hw_idle,
 		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
-- 
2.25.1

