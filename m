Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C6A1CDE93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgEKPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 11:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729439AbgEKPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:13:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:13:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l11so5536507wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtFl5WZ/AnekaDuOseiV7nKEmSW+0VpwWZe6MDcoEpY=;
        b=vVqhr64mJKTqh4sfX89mA4741REJbiLtPLaN1zJhb1nJThFXcVWxkEytdo+PdZjnrP
         cBRUrpUXbh87tRQWvggPx9voIu3SWzlfAlyDvG12GAZR+cDpRIBbUNXKE+JujMrGm0Ta
         gAcRG7XlOHr1wpyiV5DlXuaJMH6in+4ffCbAYjZ3A8jBKtltLr9RBecwfnYHhIEQyfbb
         M8n8sN6Tt+713s7vaBCgh5CsDvzEwE/jgfXI1N4zDUNVkC6RrX4U/MvbITBuUHoEUDOR
         HziPKavrDSbUxWueXBD/gNksklT0QWzfztZG3/chamNW6ekYWvvvdTerS4m3GYsYfLCu
         vxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtFl5WZ/AnekaDuOseiV7nKEmSW+0VpwWZe6MDcoEpY=;
        b=uaj+ODGjFpdm4Mi0OAk855NdCYdEi8+yofFgADX5YCBTuX5FpPj0AJjPhyIytqaOAs
         +VHk55Q6AmBUeuccONcpSNVYuCanMq7XillJP1M5+XXCzJlaK3yiGIN6iSXtD2mZ/CNh
         VEZLAcMYhGCOW1adfC8GRnCLgDIpIL+sGGUUFNc9s/uFSAuDASAuvZFPACWi/JBdRkpw
         4o52k18vaTUt276cZxF7g0mkvjAdXrQqqIwBJRK6Yn9RWijg766ZmGZu4w8KN6eXEeBr
         PaFQaurXya58qPgj99mcC3X4TZ1dhCYKxiKO4nxoqul7Dy2R+6ucxyNT/QCrBgZ6c5la
         Gn2A==
X-Gm-Message-State: AGi0PualmDwUpwjt6MkGXtI7L8kffA0202nOuwp0zhDnZY1XeWAeEyGs
        /RVf87/i4tUTDQgI+0KkCKhL5tV1hlE=
X-Google-Smtp-Source: APiQypKr8OPml61W2ltO6RLXhHYSg6nntdTMGDdFP82ZPNFdE1gpP9FfNDSdS220tUgKqZz2HCNGnA==
X-Received: by 2002:adf:fa44:: with SMTP id y4mr6821044wrr.135.1589210020272;
        Mon, 11 May 2020 08:13:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t7sm15462181wrq.39.2020.05.11.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:13:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] slimbus: patches for 5.8
Date:   Mon, 11 May 2020 16:13:32 +0100
Message-Id: <20200511151334.362-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are two slimbus patches for 5.8, Can you please queue them up for 5.8.

Thanks,
srini

Saravana Kannan (2):
  slimbus: core: Set fwnode for a device when setting of_node
  slimbus: core: Fix mismatch in of_node_get/put

 drivers/slimbus/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0

