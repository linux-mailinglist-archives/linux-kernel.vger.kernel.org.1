Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B42EBED9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAFNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAFNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:37:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08681C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:37:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b73so4322895edf.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPEliyiRuzwI93toBkXa4QPlg8YPJqkoRZuOdRubluk=;
        b=yl0HYIR5s9MenDeT4XsNXJ9fEA/1e3mGH9GPClXe8s2vo04U6NlIXSOCBCfOh1cW1W
         KPILVUkOENIhmUci0DdSV25ZVvsVn5DnCMh7VPqGfvSljwjsw2N9dIDkUQlqNH+wG3Cj
         uvrpx7FGpg2RIp5k9hV3iugDKPnMU6NdIwu9Z7H/lOnXkHLuNhIq7loNcr5rz0NGoKTz
         w5y8JAW1bWwx0fsu2V949p6iaGFy3eOwH8egolkKXcxjQA+XvKq3Fvs5Hywu8Z31+QqS
         jDzg5rQSbGW242l4/jerjAtwm86dePEp0XitJltd4Lr+0Kc+6XEVB5QuNu7pUHtHvhu2
         Rx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPEliyiRuzwI93toBkXa4QPlg8YPJqkoRZuOdRubluk=;
        b=iFxr7POvGgsee3xmI1tEQVVsl2AVtUoc7DRlrObbUoQN5PypheLa/a7+m8bQdEAG7f
         Ozanj4HNNUa5CHUP3ppwctYlWw8sfEp8ywHxqFMBo+srLp7mK14KNmXiq+Z9H4G08Y+1
         42uJyJl04pbBwrdz2Y1Z5Tff9x6nYu/V57Uu5DY9TXHheEVpXtzL+EXW7pr/MmRptSLf
         g9yuvcautF3jzUO43frMKbJ69KkoPAdrCatMOV52wQraz0FrymRWy/jvP8NIsIakzfOz
         vW3/erxUX+CGp6WhECjTNqdsz0RgeshmM/mn8HSmO50E3DbewdUl2CAao/I3LTb8+G0X
         lR0w==
X-Gm-Message-State: AOAM533PH71cAW5iwu7F8m2N87Idtx5pp3EYU7ujVD7A+CuLpEQ+6EXQ
        1kDQ2OT5tFUbrEB9KoG8IgfZLQ==
X-Google-Smtp-Source: ABdhPJx/1vvfuOLzmxE15pjnnC4c5wWRe3M9KBn0bmPu64n8eazDenjWMbbMPBHgvZ65ryOHyM5aWA==
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr3987735edb.137.1609940225772;
        Wed, 06 Jan 2021 05:37:05 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n20sm1259275ejo.83.2021.01.06.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:37:05 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] usb: gadget: audio fixes and clean ups
Date:   Wed,  6 Jan 2021 14:36:47 +0100
Message-Id: <20210106133652.512178-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a collection of fixes and clean ups found while
working on the uac2 gadget. Details are provided in each change.

Changes since v1: [1]
 * Jack's patch added to the series (no more deps)
 * Warning [2] on Patch 3 fixed

[1]: https://lore.kernel.org/r/20201221173531.215169-1-jbrunet@baylibre.com
[2]: https://lore.kernel.org/r/202012291638.QiDQi3Gs-lkp@intel.com

Jack Pham (1):
  usb: gadget: u_audio: Free requests only after callback

Jerome Brunet (4):
  usb: gadget: f_uac2: reset wMaxPacketSize
  usb: gadget: u_audio: factorize ssize to alsa fmt conversion
  usb: gadget: u_audio: remove struct uac_req
  usb: gadget: u_audio: clean up locking

 drivers/usb/gadget/function/f_uac2.c  |  69 +++++++++++---
 drivers/usb/gadget/function/u_audio.c | 130 +++++++++++---------------
 2 files changed, 112 insertions(+), 87 deletions(-)

-- 
2.29.2

