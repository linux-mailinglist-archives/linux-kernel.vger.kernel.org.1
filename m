Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3026C05D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIPJVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:21:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E120C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:21:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x14so6064796wrl.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcLuhNnrX/nQCZhthEE8aR8w/AwdzuMVVfrZbO3TD9g=;
        b=zwpPinI/Rr9H8iwdQqSgkeJmlIy6IG6vrUVdUIT8CJAniqdNZru9Waie7WlTmyyT1S
         Nug/KefJnhLLIoDZ2hqapgVx3xE9lSEoMX3AWOv7ZC+TyZc/6H5pvGPsGuXFv/C0KQT6
         ds804bTLAjuXkMty18ffemSkElCgDebaL6XPpqiNgr+YPSuMW14nwpACjiHu5buFb+u+
         l6cN2v5iIrJfjl077t+XwqGqbO7ZYbdr98esIhyh1G67UtA15RMhbXGjoCn4l7I70fEw
         aFY2KjAQOMlJfO0+6KcsfM5GFVks9TY+KQSRKTlAWzKIVHqtdLiSDZn/f/+E1KXdEZrE
         jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcLuhNnrX/nQCZhthEE8aR8w/AwdzuMVVfrZbO3TD9g=;
        b=DeaqEmcCC6VPZzbBPB2qUKoJziKlbe2wm5ZKj6eTpCxbRfyBHcpeJyeDFO/4Fy/Za8
         Mg6jhvVpKebKKaiQN3mBavNv03UbIIyD+CNjvUG/I7q74A7pkRHajlM3ZqGTv6venlmZ
         +88DFuSZZTushFK43qfTmqg1zCz0S/jrBMb1XSFpQve1W66Y160yNbHa8T+dO3TZ826K
         XUjrK3suK53ZqZvusk6bim02mtD0+15YXbXAmlUWPf9cWGGDk6dxFCbhDgcYr4eERYzd
         xZlmNOVnF2zMpmBCzM5rQv1VchBbQqqoOAj6Q1FP+SVDZYMBBSoyVtX8vWfENAwf7yDK
         36QA==
X-Gm-Message-State: AOAM5339cfYjoVKc5W764fZaTSwql22BjMwcVvqrsH6z7HnSS/rzedO2
        PW6ELQN0+NACioqiFcyKoLP2KSa4IRsM0g==
X-Google-Smtp-Source: ABdhPJy5m+mdqlv4OG5JdIdq8YqyOLfF8S9OUft4LXq72Toaw/0mXAlfmewTtZX/SaRKGmW8bN6d1Q==
X-Received: by 2002:adf:e449:: with SMTP id t9mr26130245wrm.154.1600248108935;
        Wed, 16 Sep 2020 02:21:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f6sm32181670wro.5.2020.09.16.02.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 02:21:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] soundwire: qcom: fix IP version v1.5.1 support
Date:   Wed, 16 Sep 2020 10:21:22 +0100
Message-Id: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing Qualcomm soundwire controller version 1.5.1, found two issue,
Firstly the frame shape information configured vs the bus parameters
are out of sync. secondly some ports on this ip version require
block packing mode support.

With this patchset I was able to test 2 WSA speakers!

Also I found a regression due to move to REG_FIELD, which patch 1 fixes it!

thanks,
srini

Changes since v1:
 - rebased on top of REG_FILED patch or soundwire-next branch
 - udated qcom_swrm_data to use u32 instead of int as suggested by VKoul

Srinivas Kandagatla (3):
  soundwire: qcom: clear BIT FIELDs before value set.
  soundwire: qcom: add support to block packing mode
  soundwire: qcom: get max rows and cols info from compatible

 drivers/soundwire/qcom.c | 76 ++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 18 deletions(-)

-- 
2.21.0

