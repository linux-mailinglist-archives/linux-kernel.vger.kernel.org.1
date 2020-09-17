Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9063526DB35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIQMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgIQMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:01:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8B2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:01:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w2so1707222wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqsiLJm8rZryhs+SsCl8JpeQLd5wde3AeDM1WscX2vc=;
        b=WdckR2snfW99iGY4aSs2s4CIrenfAmRy8DqptjREBVZwVf498KixuWhpXgu6P0ju/b
         NqTHV1yoexwpVm4xa/qagJ+QkNUNKzMwmJdVe9tAQZlmsyoqlu2yLjWuX7ovzH/6fGZe
         ImsRAt4+1HjYsbsEqI56HS6nHFQwEYrU/E/09apd1XoLNfcU6xjRW/JrQzjbOJKhZESL
         PejE5e31EvzJelsNKsI4UC2RJGuP0KMwkY6zzrAp5fV+iRaZSQaj34xiyVuZiwfm/nKj
         mmwmpRmeFO88ZTL+VNjbFCr4Z7wj2x5RhIskzrR9XM0ZjuR+AOXx4HjkjJ/VEZhe6nvk
         k3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqsiLJm8rZryhs+SsCl8JpeQLd5wde3AeDM1WscX2vc=;
        b=N0X6/ol37ky+IpYSO5VMAtemJIRwwSh8Ua/Epzm1aowmAfyTQjJ6AIy7w0ecNb7aPi
         et6wGdzHgx+7A9SezbDBYwZZSBQauzaWcGGrAO1hnTeiR9sHh36lXhWpjEYyBWOOpOQC
         OLsKOw+s5y0FKc5Bban4FD3T1E/D0IISRdvMDKadmHr9Ld314FjJeMhbV/3nmMjvv3wc
         qEqudwn8VrEGW9wjHdK/TOZuOX4AoiMEs44/FxIxOcyTJ2bp2XltcSlCYDLGtXeiyLZA
         YHdEkHPQ3y8jkn0QrOx/YFmKv5qU0VDF8PNIEsS2x/pioCr8rWWsjpnORGa6s8dOwBkp
         qG7Q==
X-Gm-Message-State: AOAM533N+UlJYh/ukq1OH4JlMjPdNZqf0Q4D5f2ZsQA7kMztLEkrCFGt
        oKy6dGZtmpXK5F+qFki2OmOZUg==
X-Google-Smtp-Source: ABdhPJxEuV9ibb7bGIMvu83QGUqmmb1vrX7gGy8FAmpg7WRyQort0z4eK5M+oFuFcHxxz5FZkKmCew==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr9592444wmb.101.1600344102349;
        Thu, 17 Sep 2020 05:01:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q18sm37584860wre.78.2020.09.17.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 05:01:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/3] soundwire: qcom: fix IP version v1.5.1 support
Date:   Thu, 17 Sep 2020 13:01:35 +0100
Message-Id: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


Change since v3:
- use u32p_replace_bits instead of u32_replace_bits

Srinivas Kandagatla (3):
  soundwire: qcom: clear BIT FIELDs before value set.
  soundwire: qcom: add support to block packing mode
  soundwire: qcom: get max rows and cols info from compatible

 drivers/soundwire/qcom.c | 70 +++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 19 deletions(-)

-- 
2.21.0

