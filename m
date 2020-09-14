Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B86B26848A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgINGK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:10:59 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59461 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgINGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:08:21 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with SMTP; 14 Sep 2020 09:08:16 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (dev-l-vrt-135.mtl.labs.mlnx [10.234.135.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 08E68FJZ020950;
        Mon, 14 Sep 2020 09:08:15 +0300
Received: from dev-l-vrt-135.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Debian-10) with ESMTP id 08E68FV3017391;
        Mon, 14 Sep 2020 09:08:15 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-135.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 08E68FN7017390;
        Mon, 14 Sep 2020 09:08:15 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next RFC v4 06/15] net/mlx5: Set cap for pci sync for fw update event
Date:   Mon, 14 Sep 2020 09:07:53 +0300
Message-Id: <1600063682-17313-7-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set capability to notify the firmware that this host driver is capable
of handling pci sync for firmware update events.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index ce43e3feccd9..871d28b09f8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -548,6 +548,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 	if (MLX5_CAP_GEN_MAX(dev, dct))
 		MLX5_SET(cmd_hca_cap, set_hca_cap, dct, 1);
 
+	if (MLX5_CAP_GEN_MAX(dev, pci_sync_for_fw_update_event))
+		MLX5_SET(cmd_hca_cap, set_hca_cap, pci_sync_for_fw_update_event, 1);
+
 	if (MLX5_CAP_GEN_MAX(dev, num_vhca_ports))
 		MLX5_SET(cmd_hca_cap,
 			 set_hca_cap,
-- 
2.17.1

