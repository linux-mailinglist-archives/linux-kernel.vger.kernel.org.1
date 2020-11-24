Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3EB2C32E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbgKXVaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgKXVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:30:02 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:30:02 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so169029lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ViEReXYc4cLP6JBlVCeDMQdScVPpdwCGKTWCpVtAHL8=;
        b=tRg3T+1z+tvVHLfrhi4PPBE2Z79pfQAOiuYtg5OMrfxZ3WUgH68meBHyLvAhgNFPVp
         wxOHbEe1aOIDxRfXFAmYy7SeL9vPcYVpJQ95QRO4hVr/JMSX4YS8pX/So/RouP0G0xcL
         I0burIzzbNVtfRl9jJAYLfkSSicMUMlLl3fo/jYuESgPvg9X2wCtGZXUmsVIs1RA6cb7
         XH8U3EO3j+xQldEr14dillHaXFM+F97MdWVl0xY2oE5j0CcZdaIttaAifyRxm1UN96sH
         9OhGcRV4TmaCG3MgsfqyfmH83cfJMJUicEdyOnhb8K3XzsvpKl2UpoFHKyFzexCC5Vl1
         8tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ViEReXYc4cLP6JBlVCeDMQdScVPpdwCGKTWCpVtAHL8=;
        b=MderUlTNx4vNeHOQtVaus2VaMmiKlKSnvjV393fzsmyPrnmTlqO+SNMwAuLZdI1q2f
         QVDSE+pirdtFcLD+tCfPii8zDgrhmeUSZtK8pa9LHPuolkga0ggypCSvY/GUCnb9SPeh
         d/54PL4/Lvz1U55bvEhVMtTX9LNT6tMON9xX79osBp81G/7o2i/IjDZYEsbiEfepu5E5
         0GmOZzn6aBhbZwfkGwrlUrvZfG9+YvW2ATX40UfnR64bGYlt7s05CdTqPOL6oYJwIakR
         jzVNN+D56xYInZ12MAhvhlDzWQTw8S45kUrMD7X/C060fAUNuEExzGbUnjbDZXFKZZpM
         isOA==
X-Gm-Message-State: AOAM532aGYMrDy016Xk0bPPRsZdL4Pl5WwHT5Gv1d+HpMv2q2qf92GCe
        tDHHc3hpwmS+KFlE9dGjSt0=
X-Google-Smtp-Source: ABdhPJwc2ZtXOTfjO0eM9EruEeu0V6EKPMZJz3jYc2J9YCgtRuAXbR6y+0zFjN96ByQZvrpL+BJwPg==
X-Received: by 2002:a05:6512:24a:: with SMTP id b10mr43805lfo.434.1606253400827;
        Tue, 24 Nov 2020 13:30:00 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-6.NA.cust.bahnhof.se. [158.174.22.6])
        by smtp.gmail.com with ESMTPSA id l26sm28194ljb.92.2020.11.24.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:29:59 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] samples: qmi: Constify static qmi ops
Date:   Tue, 24 Nov 2020 22:29:54 +0100
Message-Id: <20201124212954.17750-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of qmi_sample_handlers[] and lookup_ops is to pass their
addresses to qmi_handle_init() which accepts const pointers to both
qmi_ops and qmi_msg_handler. Make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 samples/qmi/qmi_sample_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/qmi/qmi_sample_client.c b/samples/qmi/qmi_sample_client.c
index c9e7276c3d83..78fcedbd25e2 100644
--- a/samples/qmi/qmi_sample_client.c
+++ b/samples/qmi/qmi_sample_client.c
@@ -429,7 +429,7 @@ static const struct file_operations data_fops = {
 	.write = data_write,
 };
 
-static struct qmi_msg_handler qmi_sample_handlers[] = {
+static const struct qmi_msg_handler qmi_sample_handlers[] = {
 	{
 		.type = QMI_RESPONSE,
 		.msg_id = TEST_PING_REQ_MSG_ID_V01,
@@ -571,7 +571,7 @@ static void qmi_sample_del_server(struct qmi_handle *qmi,
 
 static struct qmi_handle lookup_client;
 
-static struct qmi_ops lookup_ops = {
+static const struct qmi_ops lookup_ops = {
 	.new_server = qmi_sample_new_server,
 	.del_server = qmi_sample_del_server,
 };
-- 
2.29.2

