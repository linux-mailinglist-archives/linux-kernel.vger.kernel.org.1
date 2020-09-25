Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460FD27847A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgIYJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgIYJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFCAC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v12so2590813wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XX1ieNlClYzjBgfq7/9KYbHeLNLgD4LlaxGQnuBGD84=;
        b=Oj07BZ3Fnf4Wk7Y13SU4KQ4pP4T7VqjxIBRUuxODR5nZzY4lykgOme8J0BV/wM0dUb
         k/v+cFCPn3/gndGgI16mXdLFvSl45r1DSOdoy23bZ4xTftFbsuQvkGrXH/3oxwzkqug0
         Alng1NmkRlCavisrQD4Ip/EFqXLPk9ELt6Hxfor1uvl4RZNozgp+xf95dt0hfYid3405
         O1xxs7cuv9ZyGHWRSsshysxsvtmfIoPDYWFPVnpyFBG8RJ2y3zQ+XwAw6dHgxDXAlcOo
         39b3QNwevXOId6Z4HtDnhpbmTz00TZjlhOMQWSeNA2/kft+qc2B+RaQBM5BIUS2ipw9Z
         lS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XX1ieNlClYzjBgfq7/9KYbHeLNLgD4LlaxGQnuBGD84=;
        b=nJ7IULJ0d0X5nK52kXAj79ufIP7GjSn2ruuRem8gdzqp1Dwe0K+fZHyv1bZc0Cq2Y4
         U333oLFf5C3rehycJJ8WhwKRZBgwhZ58LNYpfBg88g3+OltbNt+GpWORTopZhfiux+WY
         8/m6TqM5ejZk+OgqgHhJ3A0qWyROW7nvKo9LFdEHvyNYkmig71+wZCzdW52x5gIQoWw/
         08LgUXj4Eqft9VIJfXOry4mlCCYdQozrPBZlPFv6Tlh++vm2Q6gEpEsGO0PbelptQ6N/
         hwIUZ/AjH1wEBKFoYB9x72DH+qcL9UjkNAySosBQd7i6fkVta/nb/f+va9qbLTT26WVu
         TJQQ==
X-Gm-Message-State: AOAM530cVHIGNs+qj9uTzp6Wsu/pednWOTHPKWxi7VRhXQxjAuOiV2Eu
        zNrAZXvshGjG3BtymwthHCWQ3Q==
X-Google-Smtp-Source: ABdhPJyu7pTtFKk8bzcEJgcxX5vvt3nwXB9Cj195rfScX6gsWGFP4ZEfyEAhNl9ibUwo/dhiz/nLBA==
X-Received: by 2002:a1c:610b:: with SMTP id v11mr2301340wmb.181.1601027769283;
        Fri, 25 Sep 2020 02:56:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g14sm2227598wrv.25.2020.09.25.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] slimbus: core: do not enter to clock pause mode in core
Date:   Fri, 25 Sep 2020 10:55:19 +0100
Message-Id: <20200925095520.27316-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
References: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the controller logic decide when to enter into clock pause mode!
Entering in to pause mode during unregistration does not really make
sense as the controller is totally going down at that point in time.

Fixes: 4b14e62ad3c9e ("slimbus: Add support for 'clock-pause' feature")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 58b63ae0e75a..1d2bc181da05 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -301,8 +301,6 @@ int slim_unregister_controller(struct slim_controller *ctrl)
 {
 	/* Remove all clients */
 	device_for_each_child(ctrl->dev, NULL, slim_ctrl_remove_device);
-	/* Enter Clock Pause */
-	slim_ctrl_clk_pause(ctrl, false, 0);
 	ida_simple_remove(&ctrl_ida, ctrl->id);
 
 	return 0;
-- 
2.21.0

