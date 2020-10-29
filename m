Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE129F20F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgJ2Qqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgJ2QqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:46:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6168AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:46:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w21so2811305pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxc3tUuYRTWw4b5BVOCu7UvURxJdYCm6LaMBc9Xxu+8=;
        b=xKQo+QHydi895wo2Zf7I/tkh+oN6rotiowhKyJ93r4++Kd6URUNE9ctbR5Z27kDV15
         CZew5wK1N3MpwjpE0v1fPG/Iltx3XSG/ZPRat88gq4s964f4OC+hqvegMtpr1xVaN8Aw
         A54YzeIRGDasTXd0lghzdy30L0gSBCOw1C/rQVAkkvofWZMPRx2yzGjtwm4ablgaOpgt
         JRydKNrFqh4TqBbjcqK2CzSkXaq6C8O0ARAT5MCazIIHkAP4J+IEIwQ8dIyADYelP/uQ
         Oh/P9yTRCZlizvYvH/XeFHy2xyIoRDowaDBsCQyqZFcDwluA+uXugBTDct8FXFnoIQI3
         xQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxc3tUuYRTWw4b5BVOCu7UvURxJdYCm6LaMBc9Xxu+8=;
        b=VzK5JmWZium4ldPo5ZeSu5Z/Cgv5Ri1Kmkp1ZRipEIJAtoNTJNPse8dlK5tTDRlo5N
         7AW0cU8Q31xZmssoT0hzIoxVXEp9kriLiq838df20KRgXUD3QQR25wZCHoicBEH0xzLp
         0YOQTpT+uyNMK2qpYTtQAvwGGpkRFO2kqOSW9Fo6rf77TkrdWECzxQer7DcaaFQbPAAk
         dsPihmU3sxyxqIJY6hooIJp+rVVNbmDl/G+1cTzCnIRJCZKFQ59wjEEY56US6ChpXxuN
         R0ETxrR+gZQwGUONxukxjDhA9HF4HjLJtQqbSvX9zkzRDuygk5Tl+H0OrpznuyayaZfa
         ZecQ==
X-Gm-Message-State: AOAM533G2TpY2+F4UPVic5CNAfXLKXB+JYPOzVqphPHRocNY7MxMd1TM
        saozErOjgl9DivGJyz0Qo8cWTA==
X-Google-Smtp-Source: ABdhPJxZTU07gJXnG0wEUanRz4QDwJ94UUrAwAniHfGSA/EdpUSwQS5vQ44SHVI9wGZ78HhrQF0p0w==
X-Received: by 2002:aa7:8f37:0:b029:155:30d4:f8db with SMTP id y23-20020aa78f370000b029015530d4f8dbmr5222497pfr.42.1603989960992;
        Thu, 29 Oct 2020 09:46:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b7sm3625415pfr.171.2020.10.29.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:46:00 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] coresight: Fixes for v5.10-rc2 
Date:   Thu, 29 Oct 2020 10:45:57 -0600
Message-Id: <20201029164559.1268531-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please consider those when collecting fixes for this cycle.

Thanks,
Mathieu

Mike Leach (1):
  coresight: Fix uninitialised pointer bug in etm_setup_aux()

Suzuki K Poulose (1):
  coresight: cti: Initialize dynamic sysfs attributes

 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 7 +++++++
 drivers/hwtracing/coresight/coresight-etm-perf.c  | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1

