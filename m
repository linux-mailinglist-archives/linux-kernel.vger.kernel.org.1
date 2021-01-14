Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189092F6375
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbhANOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhANOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:51:46 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A68C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:51:05 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w135so3495086pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7kvb6SONHWlWJj0uvlf5mKCiFCFFS7yUKPi3x7vpoHg=;
        b=WMxGQG4KUm26LkHOmsdz+QN5JZugw1rTz0r2kxwWcuT9rBvfwOf8X0o3XXeWB2Aq9x
         eDyyU228NDk9+wMT+2TZXn5sWhxd2XAYGsR8E2eYU2jaG8PdNZICZaJr6bdRTSwAuX4p
         q1M5tfETC6/FnGYd7u5vM27I84VoO1xPX24hvrCSwaMGqyIX7AmySPiPV1koq2iApDQv
         uyHurOzhl9oRYo70SyaspR1eMKeVF1TSNr+SP4AZlcT0rFCzk2bSxSN/gBFU9jJJZYyg
         mvqlSTzKkK5Ht+1lSC3oTX8CK00s3GuKooXI+GiFQ6ADT119Vhn/MgzQ88sbzwTTJ2zr
         Dr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7kvb6SONHWlWJj0uvlf5mKCiFCFFS7yUKPi3x7vpoHg=;
        b=XXoBuIMPeispJtLybJUDdzi/e9eRrgnf9qAfr8T0lPiZy0OmmNxallqmrtqgLfPMFx
         GiEUt1rsC3my07I/rznWXD+n5JqIccYFeKZ+r8WFmcMIxRP5gDGzYj/E6nV/pbPGtJLj
         kDjFOOln1jAavf6zl+usRnV9l+tmyl75CzoIRxnie1T+24mmqrZM2N+CRtIuOMiBgICK
         CpaUUANOPZoacPquLYWNgVUgdJFgbYCjiMFqg5Fg+rwqaNywS/bj7LWowhuwjCEfK/N0
         PQVpwRVx9+LO1IQi/+Q4Zud+WEHkL/VggxIyAwKAyr1qLlOv/patQSlhO7sQqKyLAio3
         4VUA==
X-Gm-Message-State: AOAM533qC2Ob/8mu6FHXWDbGzxfQEL3yy2xpii/a6UBVn4N2/oUUW7vb
        HoT6a+1JG5jqMpn4kdoKx1+uFOO5dGVN
X-Google-Smtp-Source: ABdhPJzCskz4Kp5ieZDTzHicrrsh6DAQIAhhmclUFnJqDDfaXKz9SPAFZz8ZCz8ktWv4H8hNUx2k0Sk/wcal
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:3e52:82ff:fe5b:30db])
 (user=kyletso job=sendgmr) by 2002:a62:84ca:0:b029:19e:6f95:11b1 with SMTP id
 k193-20020a6284ca0000b029019e6f9511b1mr7753364pfd.68.1610635864657; Thu, 14
 Jan 2021 06:51:04 -0800 (PST)
Date:   Thu, 14 Jan 2021 22:50:50 +0800
Message-Id: <20210114145053.1952756-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v6 0/3] AMS, Collision Avoidance, and Protocol Error
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 https://lore.kernel.org/r/20210105163927.1376770-1-kyletso@google.com

"usb: typec: tcpm: AMS and Collision Avoidance"
 - removed the signed-off
 - modified the coding style suggested from Heikki
 - added FR_SWAP AMS handling

"usb: typec: tcpm: Protocol Error handling"
 - removed the signed-off
 - modified the coding style suggested from Heikki
 - modified more coding style problems (line wrapping limit)

"usb: typec: tcpm: Respond Wait if VDM state machine is running"
 - no change

-------------------------------------------------------------------

Kyle Tso (3):
  usb: typec: tcpm: AMS and Collision Avoidance
  usb: typec: tcpm: Protocol Error handling
  usb: typec: tcpm: Respond Wait if VDM state machine is running

 drivers/usb/typec/tcpm/tcpm.c | 1001 +++++++++++++++++++++++++++------
 include/linux/usb/pd.h        |    2 +
 include/linux/usb/tcpm.h      |    4 +
 3 files changed, 829 insertions(+), 178 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

