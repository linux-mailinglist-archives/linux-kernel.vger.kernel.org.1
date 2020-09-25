Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9794278479
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIYJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgIYJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F03C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so2866748wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJ7DSwGsXPHCvYT7/GxkQRuG9Us9EEJKdeB/uPAfkRo=;
        b=qJG6CtA542rNgDpN/dOblgu7tTmxLNeF0AR7lJnP0N+0bs/wekSx94XJ6NhplIJCZH
         C82AgIlevD6h5TU0VYmgsqcQylUZP4VQEQHLmiNOkS+JefQ7WzqxZ/okoxeKQ0fpatHB
         Nlrn/J+TXN+FFykj+Naeb33EvAzRhTKy6TfuYa7qJIxQ08ojzEruyBH5txFo+7UloO77
         0LavacGpFhAP8d45hda5T2tqXSJ0pIxeOxVNlf9wKMz/Is2DKlGSXFWBPUAyIORzgMAr
         fKJFuho4kW/O7/xLwuglRZeER9zdDWFbDehGWbL/Oldi8sb+XgCIodAHcI3lKhQ5R80D
         KLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJ7DSwGsXPHCvYT7/GxkQRuG9Us9EEJKdeB/uPAfkRo=;
        b=qgGPq9GkdZgSWXdxsKE5K4YuVmK+QCYtPHohZYont7fvvcjwFuERLDxhx7uNES+nhI
         lTAE43tLA+yPlERi5pZGqJHL9/OKQoUsksPHq969dHh13GSAIWz5i5GUatkLzCng5iwh
         80VRXmTz0z5eOqj2/sRGNOiZc1W6k/ombFk8YKUO84wOenS9NQa+fuDyubi+ZQzkFlD1
         kRRpjbG6xqWW3MAcQFYBYxXu7k9IQTURe/lOa69OQGul+cjlScfKvYX6aVimTQM4b0TO
         QveXdjPxl5aagG1pp+6Klljkseo46iP090Pn8llqt4kcNC43JUGqj3+gY2vgC5rp0Enz
         6tng==
X-Gm-Message-State: AOAM532rake/QFcyWNgQ8qGGgQgLXI+j/1T+xJAHxLrwsXPEPesGn+2S
        UMLjl3uBY64Tj2zk8YdC+6P38w==
X-Google-Smtp-Source: ABdhPJwnJ5qf0Z3hMgHlPxTdCHp02wYBh10QRU8lVQZnvMd5dbBFtJ6W5K6bg3c2gEau1FYFyhA2LA==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr3436481wrw.379.1601027770597;
        Fri, 25 Sep 2020 02:56:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g14sm2227598wrv.25.2020.09.25.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] slimbus: qcom-ngd-ctrl: disable ngd in qmi server down callback
Date:   Fri, 25 Sep 2020 10:55:20 +0100
Message-Id: <20200925095520.27316-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
References: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In QMI new server notification we enable the NGD however during
delete server notification we do not disable the NGD.

This can lead to multiple instances of NGD being enabled, so make
sure that we disable NGD in delete server callback to fix this issue!

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 743ee7b4e63f..218aefc3531c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1277,9 +1277,13 @@ static void qcom_slim_ngd_qmi_del_server(struct qmi_handle *hdl,
 {
 	struct qcom_slim_ngd_qmi *qmi =
 		container_of(hdl, struct qcom_slim_ngd_qmi, svc_event_hdl);
+	struct qcom_slim_ngd_ctrl *ctrl =
+		container_of(qmi, struct qcom_slim_ngd_ctrl, qmi);
 
 	qmi->svc_info.sq_node = 0;
 	qmi->svc_info.sq_port = 0;
+
+	qcom_slim_ngd_enable(ctrl, false);
 }
 
 static struct qmi_ops qcom_slim_ngd_qmi_svc_event_ops = {
-- 
2.21.0

