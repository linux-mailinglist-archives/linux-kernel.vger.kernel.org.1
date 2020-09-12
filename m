Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C22267C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgILUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgILUsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:48:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D76C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so15321671ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGvYdIbO1Ov+L3RkUUTWzo4Ylrv4oEs7SvTI+xMlAh8=;
        b=Vx3D/c9UyXe1c+iwXds6MH7J3jmXytSfOt3gAEeM6d9WNylnFEkCCs/GxAhSp9iOYL
         1bQkgy/BGxdXFupbTXeNjmY3lSzud7b0JkxMV9cvoPqSmyJSjw3hp8qRdpalfuKW4jmC
         7GYrk9nm/Qg+/MZnR0Irby39zHTk9YbMNTjCjntqYWDZagRo7fpI5qCU/q7yb79643r/
         MS89hXL55HSWzkW1MEQwujnnlrlzL5MOrKbKBMQ7mSg2USmBXOgWZMhZqNaPK3mwTxkc
         30zNPj6sLFqoYTj0xAuzw9L+bxREdYGRtUIg4x0VpOGnGuujS6bbwoV30QlS/ykw9L1Q
         ieFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGvYdIbO1Ov+L3RkUUTWzo4Ylrv4oEs7SvTI+xMlAh8=;
        b=NJ70TTcsSXnFrPC5umse8uwjWdnYOrdqcyTpulF+pkV1Nxl1UgMiqWx/g3EMACYdU1
         phg93DWFXVljFCW2uArNCcKrNQvn1GwpmM1t1vG88kkiTJ61ogfHS4PQgzOXlSXMJWg1
         lBygmreEY4hzE4CsjzdXlXl4Lwi9/FFdNFP3qI30OEcfEiihTiEoBBURXAjhvHElzn8S
         5HCQ6LuC2HjqGnO0RJTGH0p87T0h7hc6MGnTyVzDndLtDAsCKOdjIb3sA0OKrK9fmKDb
         Ci4mFBrNIQAn28szbsOLzpEwWO9DExmm1VQhfNMIe/6Z3Jauwz3RVTHq6sYletoXS/04
         ODaQ==
X-Gm-Message-State: AOAM532H9z11qloHbu7dB0O3QY88UkObmGNyp+VLHsuRqIbp9Pk3XQkB
        zFxJChc4lZZx9dlf38W68Kgkkyw4/jM5Uw==
X-Google-Smtp-Source: ABdhPJx233EkFRFFJU3liqcheNFDmyZ5ZA/8O7vZASQP8YGGA89JMXBnYHJrmjX6zYp1fsYrQBitiA==
X-Received: by 2002:a2e:8681:: with SMTP id l1mr2613760lji.108.1599943728485;
        Sat, 12 Sep 2020 13:48:48 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r7sm1729753lfn.84.2020.09.12.13.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 13:48:47 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] drivers/phy/cadence: Constify static structs
Date:   Sat, 12 Sep 2020 22:46:36 +0200
Message-Id: <20200912204639.501669-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static structs that are never changed to allow the
compiler to put them in read-only memory.

Rikard Falkeborn (3):
  phy: cadence: Sierra: Constify static structs
  phy: cadence: salvo: Constify cdns_nxp_sequence_pair
  phy: cadence: torrent: Constify regmap_config structs

 drivers/phy/cadence/phy-cadence-salvo.c   |  6 +++---
 drivers/phy/cadence/phy-cadence-sierra.c  | 24 +++++++++++------------
 drivers/phy/cadence/phy-cadence-torrent.c | 12 ++++++------
 3 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.28.0

