Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B72FA194
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392149AbhARN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392216AbhARN27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:28:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE0222B49;
        Mon, 18 Jan 2021 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610976499;
        bh=heSPP3aRBgBZFx/Q0SMe/3RDJAAippqxfJey05I92D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5we0A2yuIGJ2VW466I79lgXS2RCOscbS2ZSzRRxT9RPcnPgM1fT4mmQmMuVgcZSY
         PEmAraUZjz6P2mqm9NW8oNELW1QXr5MP3mJJecDy41XexNF+BtCFEcLTh5+pFcyzRN
         Zzh9G2uXrlJ8LVOOp4jwoVDYpqyhkwfhxFUExRKNsoMKhVk1SlWg1E2p7Z7pwlAVV5
         7pOzvv62kSv94lg3/OYkKY0N4P4uWCsZtb5FOSRChMtP2VcMajFt5KJ8HGMQz3jHG1
         MiABKWnyi18HG5J6DoS8NF/UdfVtt7Edu6aVelrGcOsn83Jm6EyNY3btiePXGnKdz7
         dmkRHGq9IfDTQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1UZs-000Vkg-D4; Mon, 18 Jan 2021 14:28:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] staging: hikey9xx: hisi-spmi-controller: clean sparse warnings
Date:   Mon, 18 Jan 2021 14:28:03 +0100
Message-Id: <0a1b05424637b47e5c93c047e436f2ab2b88c5a5.1610975633.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610975633.git.mchehab+huawei@kernel.org>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains about __be32 conversions:

    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:164:24:      warning: cast to restricted __be32
    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:164:24:      warning: cast to restricted __be32
    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:164:24:      warning: cast to restricted __be32
    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:164:24:      warning: cast to restricted __be32
    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:164:24:      warning: cast to restricted __be32
    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:164:24:      warning: cast to restricted __be32
    drivers/spmi/hisi-spmi-controller.c drivers/spmi/hisi-spmi-controller.c:239:17:      warning: cast from restricted __be32

The conversions there are valid ones. So, add __force macro
to disable such warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index f831c43f4783..4be2344ad7b5 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -161,7 +161,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 			     SPMI_SLAVE_OFFSET * slave_id +
 			     SPMI_APB_SPMI_RDATA0_BASE_ADDR +
 			     i * SPMI_PER_DATAREG_BYTE);
-		data = be32_to_cpu((__be32)data);
+		data = be32_to_cpu((__force __be32)data);
 		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
 			memcpy(buf, &data, sizeof(data));
 			buf += sizeof(data);
@@ -236,7 +236,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 			buf += (bc % SPMI_PER_DATAREG_BYTE);
 		}
 
-		writel((u32)cpu_to_be32(data),
+		writel((__force u32)cpu_to_be32(data),
 		       spmi_controller->base + chnl_ofst +
 		       SPMI_APB_SPMI_WDATA0_BASE_ADDR +
 		       SPMI_PER_DATAREG_BYTE * i);
-- 
2.29.2

