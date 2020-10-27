Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614A129AB99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899650AbgJ0MQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:16:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750901AbgJ0MQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:16:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id i26so682054pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pWBtIzMURnNZwf5E6ccAuvdeCFLhHS4uNoSrzuo7TUI=;
        b=xq0/h44NIR8g0JJ9TXGYR727SOWgGvc1tbK6rZs7CpX5BoTd2JY+quQgOEhFjBL1C1
         2ykJGVGT03IKjtWZHlHqSNz3totASLl9NiZYU2dydOdWGCxU879QUAE4xQbkAYN3x0hi
         AflfDsx2MV4GGA8Rn7iyDI9Rh5SIPZjh3x5iaR8Adra24ZHSP7YEM4nMrvyYpKHqQGxE
         /27wHrYHZKbOHBy6M9o/47YhS/eqpWdUtsal/UHODsGpYNNvxfCHW2ab8l7kJzp4fffX
         TKrjzDeoTX0I3nuhxYwdiveTrYIMf5P/p+C7YZvDiQIdWZT8yRilFyxrCraahOeGJ9/l
         pweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWBtIzMURnNZwf5E6ccAuvdeCFLhHS4uNoSrzuo7TUI=;
        b=umAlkUEmN9ucUxLg15256GUimKvRN8oeZYflK+kBSIcpkrds9zTbJIL78pq0mvv2mF
         ZhIVEvoFyngXmMizRuSDDr7NnN52lZyUo2p8OpBfWhycHLTVplEBIRBQruF/FjOW81WJ
         A4MpkrqLHBXn0TwyCnxgNDahn+HcYJdSsDZb1G9jR1V2kVauuW4SUlC30r1MWGgqGn2s
         +YEnR6PoHegEtCIZfKQxZl6WA3Q3/YzZhUrcM5SNDlzhnMKIruN52t0oO3METae2RBvw
         Nw6zPFJkU4W4WP+b1PNT3IDC+3pAGOrp8mLxwz3CFUjV8q97ywgIciGMR83JNlvYRjF3
         cFeg==
X-Gm-Message-State: AOAM532y+m8lf6hnhWFwqtnjEnIMyhbkIuxQqxuLeiRDH0RCm/TTv4i+
        eoWEzysGk4iv4VeghYU0MbZpnQ==
X-Google-Smtp-Source: ABdhPJzn8ICZbnjfRaw2e1HyNEy8kpjZJMmNlFcbjHwcsU8Mor/10oPQmIQYKPFdxNJk9Wec7Fx8xw==
X-Received: by 2002:a63:2c93:: with SMTP id s141mr1675186pgs.169.1603800967192;
        Tue, 27 Oct 2020 05:16:07 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id t12sm1820747pji.26.2020.10.27.05.16.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 05:16:06 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     pizhenwei@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmet-tcp: add keep-alive
Date:   Tue, 27 Oct 2020 20:15:46 +0800
Message-Id: <20201027121546.1776104-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201027121546.1776104-1-pizhenwei@bytedance.com>
References: <20201027121546.1776104-1-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tcp keep-alive to detect dead connections for zero KATO case.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..58800e914e61 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1714,6 +1714,30 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static int nvmet_tcp_keep_alive(struct nvmet_req *req)
+{
+	struct nvmet_tcp_cmd *cmd = container_of(req, struct nvmet_tcp_cmd, req);
+	struct nvmet_tcp_queue *queue = cmd->queue;
+	struct socket *sock = queue->sock;
+	int ret;
+
+	/* TCP Keepalive options, max 5+1*3 = 8s */
+	sock_set_keepalive(sock->sk);
+	ret = tcp_sock_set_keepidle(sock->sk, 5);
+	if (ret)
+		return ret;
+
+	ret = tcp_sock_set_keepintvl(sock->sk, 1);
+	if (ret)
+		return ret;
+
+	ret = tcp_sock_set_keepcnt(sock->sk, 3);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -1724,6 +1748,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.keep_alive		= nvmet_tcp_keep_alive,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.11.0

