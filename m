Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077026A0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgIOI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgIOI1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:27:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621BA2078D;
        Tue, 15 Sep 2020 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600158471;
        bh=QuyE2bhdMaQ4rW86qA5W1wOxRCYDYC+8qflZ0n4yGEc=;
        h=From:To:Cc:Subject:Date:From;
        b=YS1isnXIWYqZVCFJa6Bi8fqt8FQwx+E+D3Fj7tGpl1bcVQ1OQtFZ4BHXEI2dfNwIJ
         H2CzYNtuqzrjcOm5U0wU0H7g+u12poYyu2DzOvYhgKMc0g4s5gJN+vtAjLgfmaacgB
         LE3EHBiKynuEAnzWX6MvK0gFIKQl+EX7SIu+CybM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Shravan Kumar Ramani <shravankr@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Fix Max's and Shravan's emails
Date:   Tue, 15 Sep 2020 11:27:41 +0300
Message-Id: <20200915082741.394361-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Max's and Shravan's usernames were changed while @mellanox.com emails
were transferred to be @nvidia.com.

Fixes: f6da70d99c96 ("MAINTAINERS: Update Mellanox and Cumulus Network addresses to new domain")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987..4cacca1d1bdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6162,7 +6162,7 @@ F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 F:	drivers/edac/aspeed_edac.c

 EDAC-BLUEFIELD
-M:	Shravan Kumar Ramani <sramani@nvidia.com>
+M:	Shravan Kumar Ramani <shravankr@nvidia.com>
 S:	Supported
 F:	drivers/edac/bluefield_edac.c

@@ -9227,7 +9227,7 @@ F:	drivers/firmware/iscsi_ibft*

 ISCSI EXTENSIONS FOR RDMA (ISER) INITIATOR
 M:	Sagi Grimberg <sagi@grimberg.me>
-M:	Max Gurtovoy <maxg@nvidia.com>
+M:	Max Gurtovoy <mgurtovoy@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.openfabrics.org
--
2.26.2

