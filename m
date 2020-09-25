Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9185C278F06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgIYQtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:49:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985CFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:49:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so4058911wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAVHadJMWaOUAME/cTANgTaibLVBRhnV+ozPkRyx2uI=;
        b=wlDKkuOTF9Ng5bzaN8zpq9oI6NbkUhCn4VjnowPslZgL3DnzYy/Ow7dhZJ2x6Uez//
         iaTGws471/l4w1oQCG8/M2pOpTJ3BRHIMYAvCD3pqrPsFSag2oWvetn4u9Lsi4tKfYY7
         6bjOcrA48Pw8KvhCS3yWrEKz9759QAT1ARw+r86265A5jr+phUXwGtPcU277iVc0W3+6
         xW09moaoce4DkiJrxNJOgu5MSIdgr6xGR3cJ40beJpHwZGb41swD30z+wobyMYgwCaK2
         OEJQ6bo4XSuOcuyFc1kqvN5u8qbw4HNJ5NE+7M6HqZIhln6CkrGpPfgN8HrjhG3u6ngh
         Ss4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAVHadJMWaOUAME/cTANgTaibLVBRhnV+ozPkRyx2uI=;
        b=poKe9wn9VdokUuszrsJSROtHN3G1Uw5f4Ydeffh1vLhrjMTDV7cO7pwV5EYhLV4etv
         Af5vKI412/SS6n5dOTOmGVv3RmsRXBFvl0/jPLET+A+qpxWcIJBt7VY4ytLeWPNbfKIy
         cbt65K5HnMCXadKt91HC7JHD7lO2WDMIF/KxbdUNrFec+76n36uvNLz28lb4wWsJQ8Es
         ZNROJ3wSssFmDaD/jF7GXj3NdmqCucgWsHgX7YnY3e1CmnxoJ19CUNbSGIAggeJ5oTeq
         yPy9MOIwP2NB3seZZYvukVSFTzmlHoE9vyNDZtlyP09eQ/X1Q68DVAQg8IlBLEPoAhzh
         GYWQ==
X-Gm-Message-State: AOAM533c6jeAmYF3FlW3NBbBef6mO3puC65SdYP0U+bFiMJ0NAbiT6bj
        z8gRp2gUajYG9Ir57sCeZRggAw==
X-Google-Smtp-Source: ABdhPJyF9JnvhthbbiF7ViftBxVVevHX8DkysJ5M8eqxXYmL++NqE7FmpiVX7Z6WGHYZD71ptZ7GIQ==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr4079590wmc.123.1601052545293;
        Fri, 25 Sep 2020 09:49:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a5sm3604247wrp.37.2020.09.25.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:49:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] regmap: add support to regmap_field_bulk_alloc/free
Date:   Fri, 25 Sep 2020 17:48:54 +0100
Message-Id: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of regmap_field_alloc becomes much overhead when number of fields
exceed more than 3. Most of driver seems to totally covered up with these
allocs/free making to very hard to read the code! On such driver is QCOM LPASS
driver has extensively converted to use regmap_fields.

This patchset add this new api and a user of it.

Using new bulk api to allocate fields makes it much more cleaner code to read!

Changes since v1:
	- Fix lot of spelling! No code changes!

Srinivas Kandagatla (2):
  regmap: add support to regmap_field_bulk_alloc/free apis
  ASoC: lpass-platform: use devm_regmap_field_bulk_alloc

 drivers/base/regmap/regmap.c    | 100 ++++++++++++++++++++++++++++++++
 include/linux/regmap.h          |  11 ++++
 sound/soc/qcom/lpass-platform.c |  31 +++-------
 3 files changed, 118 insertions(+), 24 deletions(-)

-- 
2.21.0

