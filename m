Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9C23F52F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 01:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHGXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHGXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:21:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB2C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 16:21:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q4so2357975edv.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocGdQwQZCS+OZ+g3LlgW4+FcTq3igPBBhWnG18S3aSc=;
        b=QZlrQtG9XeVvKg/Qs43Csm6H542k+qm5oOQpo6ncqAmxZGGnEq+QxWkKypr866pRoE
         myMbHUwUS+Z35BWVhxqjyQebu1ubv/NpIGlebHNtNIuWfcWanN1grX2VRwQlj0HZH0+y
         o8JUpUXuSHgt77UflMuSrddsF2uYqm7wLtphgPd+aSkyeCrZtNh/kVLYYIKuThxKPUzj
         g8n0uA3oTra+aodyPZMjVAjEJbmdUtHvONgFhTWQU4TxoImUdGhuM+g3xCyg4CCdOAr6
         /SU9sLyQ56CwZfWiVHQNhIikC+bqSsOQLaBcO22AZkd7IBY22w7b20XpWHxb2uqWCBp0
         wYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocGdQwQZCS+OZ+g3LlgW4+FcTq3igPBBhWnG18S3aSc=;
        b=DQWXaMvIu2kqZP8QiVjTV8o8mQiin3zoKJ7uAP7JF6Vdhh2LRiypIH0lr1abmO100x
         fYmGsfmXo9t9qvR08o0ceVLjqhVBDwChVArBauMdgv1iHPPtwpe3MjEWwKcKskeQ1w9c
         hbnOc3TOlFriPWwejL9i7D5nzAydDcKmnRpP/nvfseSbcTW2VKb/rK0aIeEciV7pEdF/
         WG8GmAOQleUW4+zMgnMbXh4Sul+Gr3lyDBrprbMx/IzWufCV0e4uSoUJGDJOEviNfNGl
         muQHpvJVRWPjFlreprlP+egLYIz4YkXSZFb2pf4vExFVsBH0Gt7YknH/CwjtLosOOXUq
         bgSg==
X-Gm-Message-State: AOAM530ZcZdlguvuCz5qfG0Pl9a7PAz51W4mwIydNFCX6urftwRCfWD/
        n/ge+izPy4rBa4B50RZzHhnPIA==
X-Google-Smtp-Source: ABdhPJy9kues6cMNBvBepS3jHrAAgTiJUAC00r9EwRxY6I8EUFn4cM5pyHMG0lY3sFGB4AP7wcr7FA==
X-Received: by 2002:a05:6402:1a54:: with SMTP id bf20mr11187045edb.217.1596842508132;
        Fri, 07 Aug 2020 16:21:48 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id y9sm6305574edt.34.2020.08.07.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:21:47 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 0/2] iio: temperature: mlx90632: Add extended calibration calculations
Date:   Sat,  8 Aug 2020 01:21:02 +0200
Message-Id: <20200807232104.1256119-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the second patch is dependent on the first and was still not
merged, I have decided to send them together. First patch just makes
second one more readable as it splits out the repeated calculation and
that enables the second patch to tweak the variable to the new
condition.

Crt Mori (2):
  iio:temperature:mlx90632: Reduce number of equal calulcations
  iio:temperature:mlx90632: Adding extended calibration option

 drivers/iio/temperature/mlx90632.c | 233 +++++++++++++++++++++++++++--
 1 file changed, 223 insertions(+), 10 deletions(-)

-- 
2.25.1

