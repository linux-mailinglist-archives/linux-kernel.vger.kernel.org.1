Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1E2EB057
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbhAEQkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbhAEQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:40:40 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C8C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 08:40:00 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p19so16505plr.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 08:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7yaUY+fT2h6mjlE+twZW/BVnXmuD8QXlKCB+chmPYA0=;
        b=CBQEJX4R75tkPVINcEEqUCZ14l9KgBBPCQCKkdaBY6GtMpeueA6gxHfgVRHjKyvliW
         TbQMf5+N2fiztx9Zty/bLoRJWXgJk9BtWtNmLHob0H4I6zs89oQx5/iPA0/LE73tZDOd
         XmA32zsmIhU6BOL5taah/rIh4P2nBO+jfLZ8N6rVAYvgw91LwIuHYWaQk2GhrW72mi4X
         LozMH++FLT9VaQ1+6R5dY2AiWmXoH3Vj628EVwTWe5bDK9kN9blen0AZZrugoqu7yNfN
         rDQ4nElXWQW40ms0LJPqJTUnz3NYkXiiUupKySRtCTWfXZLpB1hquwFg8UNN1BWHsiqW
         4Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7yaUY+fT2h6mjlE+twZW/BVnXmuD8QXlKCB+chmPYA0=;
        b=tVjGrW6k4CKKyyIFNvChW645XfkoXHrYIIjVJAeSTmoJQO+tSWIkdRkwvcLUuPx0ty
         f3jK1ENmkrRAF8LsDu88Lm2CzSgsAb57S6w1X03yXN+B5991j5l2blvkVHQVD7tGTxsq
         V/TEjyYTFU/keeAuU4lNpI24Yznmjw0b8VJUJvBb6+JCE1jYC7FqIBwLOwj5GMLYKij0
         Z46WT4OLQtYNX/Pb7sCE7fDL4yCvXOcVBu4lCEEN3hsDvxk4fvMKtgyKDhNziWSazREU
         G4GoSAuwBmIJxm6TFceLog9F/OaUGyQK+rzSAJSO4nhcW+/KHcgMQt4AgQ6wbWHProTz
         kgZA==
X-Gm-Message-State: AOAM532dgFBEv0U4T0fUgzKJKlYGhHVjtvjy8XPvw5K3RzNJ+T9uzwUH
        S5erF1rI45osn+A6HM+6hlx3V/2hqFi8
X-Google-Smtp-Source: ABdhPJzpO+y903fp1AqT/70A8Eld/UOHe4aLQEvcCAxOZdk+q495vMVUrlXo9BCvHvYDbr2M/PRBRNuxWP2y
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:3e52:82ff:fe5b:30db])
 (user=kyletso job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr483885pjn.1.1609864799630; Tue, 05 Jan 2021 08:39:59 -0800 (PST)
Date:   Wed,  6 Jan 2021 00:39:24 +0800
Message-Id: <20210105163927.1376770-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series include previous patch "[v4] AMS and Collision Avoidance"
https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
and two more patches "Protocol Error handling" and "Respond Wait if...".

The patch "AMS and Collision Avoidance" in [v5] is the same as the one
in [v4] (only rebased to ToT).

The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
wrong handling.

The patch "Respond Wait if..." is to fix a conflict when 
DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.

Kyle Tso (3):
  usb: typec: tcpm: AMS and Collision Avoidance
  usb: typec: tcpm: Protocol Error handling
  usb: typec: tcpm: Respond Wait if VDM state machine is running

 drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
 include/linux/usb/pd.h        |   2 +
 include/linux/usb/tcpm.h      |   4 +
 3 files changed, 792 insertions(+), 139 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

