Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1472C630C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgK0KZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgK0KZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so5038842wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KnpcRHkt95glkiCkXoDV311JoYmIzTmdq90mVMfg1o=;
        b=FXm6FSh2o9ee18ODc/mlUVroTL853sVCi4MHeIqhaHSUkuslFIY4OqiGRwVvbKfBMz
         25oQBUG+F4dKR9gJNtlBU9n2pdayEkxCgxXSCM7dO5ZJGGW+YmNdhamOueZB22q32tKN
         HPaaD+lGOg/FGN8Bh4PgnMKkG214dWCDekwtZyvA/XyfemTxtLPb91Udj3+SJbbeFAv9
         YiGl6nw/kozP+er+WaWFdVYuQpZesATueOJaAmWkW4YWUcaycXtoSMLumzni4UCvk6hy
         Ujq4C0Kl6Z/0HXstu9iFOBMSoxl5AAcbbeaSqXkrH9tN8e4n1UQ7X1Uc9NkiY70Qw/VM
         0bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KnpcRHkt95glkiCkXoDV311JoYmIzTmdq90mVMfg1o=;
        b=jbS8ejYpuP8KiKE/To9y5oLUxMRSI8i9Mi84LhbBRWASL31obG6aTz8NsyBua2NYBr
         J2Y5VZluxn8CM8ls9PG4Mz2h5BbSE8TnyImgWbyGumdtvD1qTb8ULN7VfwNeY0Uw+SdG
         uwpkaOlQSMLLXMfYzTHrCobpP1Qry/wCPmOCL6u07X3d6Llljl0n9nQWQu4KjkdwipDv
         raPopKmAOa+EoIC9rxHX4mPVcayGUpcZW3JZ1XI+27YwfjAtkvynJQpZuc0v6DNKlcpO
         y38YE4Vo3IUQfZ1WhmOX5wJKVX7BVsKAItSHn7pJrUlpVRvFtL1IJNOGnu9IVl3LSByh
         d0Sw==
X-Gm-Message-State: AOAM532JkGElt2FHRWPxRWxUz9WN87J8a55YZNevOLKPbS+TAQM2vXnM
        Y3NknWRFAQCybbTeJcmGc1VQUg==
X-Google-Smtp-Source: ABdhPJzG5Hx+n2Zj5vyEwKfTOF4PSeLLkOjn5Ak7x+wFgvrAfqC0KLLnqLqh29CvAlB82h7d+7ubIQ==
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr9726925wrh.10.1606472715187;
        Fri, 27 Nov 2020 02:25:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/7] slimbus: qcom-ngd-ctrl: Constify static structs
Date:   Fri, 27 Nov 2020 10:24:49 +0000
Message-Id: <20201127102451.17114-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

qcom_slim_qmi_msg_handlers[] and qcom_slim_ngd_qmi_svc_event_ops are
only used as input arguments to qmi_handle_init() which accepts const
pointers to both qmi_ops and qmi_msg_handler. Make them const to allow
the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 943d55a0bc59..172ddcc2a241 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -434,7 +434,7 @@ static int qcom_slim_qmi_send_power_request(struct qcom_slim_ngd_ctrl *ctrl,
 	return 0;
 }
 
-static struct qmi_msg_handler qcom_slim_qmi_msg_handlers[] = {
+static const struct qmi_msg_handler qcom_slim_qmi_msg_handlers[] = {
 	{
 		.type = QMI_RESPONSE,
 		.msg_id = SLIMBUS_QMI_POWER_RESP_V01,
@@ -1309,7 +1309,7 @@ static void qcom_slim_ngd_qmi_del_server(struct qmi_handle *hdl,
 	qmi->svc_info.sq_port = 0;
 }
 
-static struct qmi_ops qcom_slim_ngd_qmi_svc_event_ops = {
+static const struct qmi_ops qcom_slim_ngd_qmi_svc_event_ops = {
 	.new_server = qcom_slim_ngd_qmi_new_server,
 	.del_server = qcom_slim_ngd_qmi_del_server,
 };
-- 
2.21.0

