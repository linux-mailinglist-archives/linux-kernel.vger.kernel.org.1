Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16A27B1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgI1Qf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgI1QfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F19C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so953077pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AMZpD8+Li6GFUtc4Pm9yyOxq3WZ1VdS1uKZ+57gOcGw=;
        b=Nisff/dGaQnt5giFy0+gbCxZOyxIq8yzZHqaf8yvSXI4mK6JOfGqOWRAze74KzmpPk
         PcSgEfg5JCSNReg6GYWHksUb4BbBh22OIiCr8KluSnQdXN8dgxEyzqKuQ/UxGEKVXxl9
         yFnJYIqqn52YqpKtbs36kfgxCJtsS+NtydY33Pbcul3K03mY8ZChWkd3tncRj9oQkipx
         Mcppdf1K2qZ/YqlgvKMZDQsQEowJv8LIqKc6ZeirjG92JCPwq7He63JyoW9aLL1N8Emu
         vlYPIFyJhDj7chEbb6HE83Xbj6xbIQeekj7h1dvd1/zSeQGvqWqXrnaG+T7ALnRGEWs2
         T7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMZpD8+Li6GFUtc4Pm9yyOxq3WZ1VdS1uKZ+57gOcGw=;
        b=dtQXktBGlVbT2nVPVldUyLE3RzBrmQt9V22BRERhVfMhWxBmCzv4FCb0jdJZxtTRu9
         qHlz0JQIjuK5uLZWQkwUaMTrcDenOOdFxQWOvXgEbrxBJdSZDAx7gBtFuj0EmUyUvxpU
         JApd9nuTWqwFnniHdkPWuA4n4UZiGQyjYsd7fm2IcCM1FHyvzma5pPIKQAweflXOG5EM
         mDc5AyDIwgv2u8OmO+6pGgI6uzbfBma/9Pb3hvLWF1J8Hyxe/527Y7itnn9uAPgEK4aA
         7wDh/63v++hMQjSSEAvYlKA0j0jEjdpC7ITy4Dl6cMmORfnWBgM95B8bqUTtA6Tx0FSr
         fSIw==
X-Gm-Message-State: AOAM532twHaFWFvMLUo/VxgGdv4ZoXr273bJWF2vjSCfE22CPhgf6CAq
        5Hiebb8wHtDMSbhAFmpNxdikQg==
X-Google-Smtp-Source: ABdhPJzXVQXWJQf7Y7yqN9X8MV0VrbRhBo+F3jp6j831Kc3brGe3CBtVspQeH1mDshkFY2HeKEcM5w==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr151742pjb.118.1601310916737;
        Mon, 28 Sep 2020 09:35:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:16 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] coresight: cpu_debug: Define MODULE_DEVICE_TABLE
Date:   Mon, 28 Sep 2020 10:34:50 -0600
Message-Id: <20200928163513.70169-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Define a MODULE_DEVICE_TABLE for cpu_debug so module can
be auto loaded on boot.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 7e642fb3ed15..e1d232411d8d 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -665,6 +665,8 @@ static const struct amba_id debug_ids[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(amba, debug_ids);
+
 static struct amba_driver debug_driver = {
 	.drv = {
 		.name   = "coresight-cpu-debug",
-- 
2.25.1

