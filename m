Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF42D8112
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405900AbgLKVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405676AbgLKVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:18:51 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380D1C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:18:11 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id o17so12313773lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1B2BmAzfv/+nC19YLdJ5zk3HLZYNdrAKVr/yfl07Oo=;
        b=D1fVBt9gzDyfxAjttxup7WS+NH7GVFwX9PuUyWqoTm+xnEX1zFfGu8qETIK3Yg0sMa
         NafhOUOIKP6r0gX2J948IIDHhaaRsb0vXvOtDF4ty6NOaKgV9e87iZKDD/PMJfrK4R6E
         9EABGOnACFeyIwk+eTqJ6E48ULOj5vd5AbDObg1XtJ/q5o05OntcLZPPBzhhtpATeyOv
         rrgzwTkzCobi9AvyPDXX4kKx9x6cBinkTp0wyQLkKvYJhNVCt27RtZRu4pCXK5tB153U
         fEtiIlVLZwd2FTPd0RXOIQzm974Vb0fjSUFxxO25YieejAYGhkCQvietblOPDpOGzBy5
         hkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1B2BmAzfv/+nC19YLdJ5zk3HLZYNdrAKVr/yfl07Oo=;
        b=dOKMlEbguAcM39dNGXYcN1PPNuCwJt7apGMLLZBjo8QefyXPWyrqdoV6WbYz4TZwzd
         NeP2I9eFRtnKTS9GrefhuGkh5zh7TyGjRVjOp4MQoRLf+49X3G5a61DypBv/qZQHnHXt
         BdKXFyiSFYav66p+ACa49VSR0DtI0iKa732V8gQ+ZTZNdZdIG3zVU+dt7LFlcSjYco3o
         dsJ0Te5q016XqwEymbuBGqqtF+sc2h+V+11HMSJENxXgrBc6SagIb3R9zFXpktW5f0B3
         FDeh7gl0V7GSAX0fixJQw7ivJK0cTci3fZFnSrGRvNdOp2qGw/KKSXO5bsHHAbtIiMXG
         nqdQ==
X-Gm-Message-State: AOAM532EQw+6N9aU9/5kRovpJ8ek+BW8btp/yFVqeJX8spR60d9SD6M1
        /fWepvyVUvIVc+j8mkwbOsGT0Q==
X-Google-Smtp-Source: ABdhPJwEfQ4EioA3gJ6CuXQKqdDoIm04LODuD7qkXl6bn/7aPx2mvXJPAh7oNmXvdL0Im9W+0+BCxw==
X-Received: by 2002:a19:e003:: with SMTP id x3mr5531319lfg.127.1607721489774;
        Fri, 11 Dec 2020 13:18:09 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id j1sm1004302lfg.225.2020.12.11.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:18:09 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] usb: dwc3: drd: Check graph presence for extcon
Date:   Fri, 11 Dec 2020 23:19:14 +0200
Message-Id: <20201211211916.6259-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3 shows error message on probe if port node wasn't found in PHY
controller node. But that is actually a valid case for the role switch
mode and OTG mode. This patch series makes sure to hide that error
message and also does a bit of refactoring for that code. Similar patch
(for different subsystem) already exists in kernel tree:
commit ea5bc3b15e0f ("drm/of: Make drm_of_find_panel_or_bridge() to
check graph's presence"), and the whole `of_graph_is_present()' function
was implemented exactly for this kind of situation.

In previous submission (v2) it was a single patch. But in offline
discussion with Andy Shevchenko it was decided it's better to split it
into two patches in order to provide the minimal change for further
possible backporting, and do all style related changes on top of it in
second patch.

Sam Protsenko (2):
  usb: dwc3: drd: Avoid error when extcon is missing
  usb: dwc3: drd: Improve dwc3_get_extcon() style

 drivers/usb/dwc3/drd.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.29.2

