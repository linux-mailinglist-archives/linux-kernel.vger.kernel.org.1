Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4328763C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgJHOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgJHOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:38:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9FC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:38:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so6595569wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGkjTPMi2V3zZZF0+OMF37VrvjDLPDRxTs3MRGoDMBg=;
        b=Y1bCIMyFDS1UY7hqJ2e5vxCxhQRE6HviXtylOjCWXSrwnTG8W5kyBwnaPSgogGxsyB
         TiGiZsz6UmJNxxqX9M5oQ0eoMd9fu1xxqezD/D8ckX3m/X8RUgatbmsUIUro+ahODEAu
         3ItyuwY/9hLyulO704XHVVFjBz9X2tj6GMqjAPP0nhEiuU0tDGxD3JolzMesOAK1LXR3
         tTSU17Om/DdKiWthuVmfuzjMuGraUTYCnSWQ3TFjX4lTgLUX8U1p21FOA2Avw7KvLM4O
         sI7hhYyuQyFu9SWgTytdbZ8gtyxW5NUwrEo3eUOnVhzQqRDm7cRqq6aOFUk04NI05gfY
         m1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGkjTPMi2V3zZZF0+OMF37VrvjDLPDRxTs3MRGoDMBg=;
        b=qMf6dIsRgMv5fcCQJJxjlE/O3spI0MmUfdFeTWGzqp2GoCsXZblCFSE3Zy5jMTdb5r
         NXC07ND61f0LuAW30aV3iQ5+pFAJV49ZYxvHsvqwsequRciJr1U2g6N1iTXcPpa7XkJ8
         6ntlHh8XUk8yTuELqPo7/M9HA5YkY+oJn6CaDUGw8xqMJw3pogk+XxxvVOkob3OUDzCj
         YK6NwrV2uGHQrnX4vjda8HeNFDwqz5p3zPDUMmrHt+qCQGwL72USBi+tKcW04kVF4Dys
         g0XQp7uQ5uVTyfnkoB3D66EXHudf6bvgR0S5hZepOWRlDBr15lpgbbfqOmf9fhIPzkV/
         IV8Q==
X-Gm-Message-State: AOAM533l+t9CV6NItSeYRyEdx5TbRNd2+BAPwretn66oDKhNYy3mjrJK
        xkPmrAH1TEs36GA6Ib13LhrZcpMi1TEk7uTDtqw=
X-Google-Smtp-Source: ABdhPJyL6s+5OY5gglmH/jnSTgDyh+Lz5CLiCPryYXQ8CPd+l4JpwYWOmvdg592zQOtlwmycxHiX0g==
X-Received: by 2002:a05:6000:1284:: with SMTP id f4mr9686712wrx.210.1602167924118;
        Thu, 08 Oct 2020 07:38:44 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:11c8:908d:6533:9100:d943:8b22])
        by smtp.gmail.com with ESMTPSA id y14sm6926942wma.48.2020.10.08.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:38:43 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] firmware: arm_scmi: smc transport supports multi-message pool
Date:   Thu,  8 Oct 2020 16:37:21 +0200
Message-Id: <20201008143722.21888-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008143722.21888-1-etienne.carriere@linaro.org>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for the smc transport to restrict itself to a 1
message pool. More can be allocated, messages are copied from/to the
shared memory only on SMC exit/entry hence SCMI driver can play with
several messages.

Use value of 20 to mimic mailbox transport implementation. Any high
value could fit. This should be something configurable.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 1a03c3ec0230..82a82a5dc86a 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -149,6 +149,6 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 const struct scmi_desc scmi_smc_desc = {
 	.ops = &scmi_smc_ops,
 	.max_rx_timeout_ms = 30,
-	.max_msg = 1,
+	.max_msg = 20,
 	.max_msg_size = 128,
 };
-- 
2.17.1

