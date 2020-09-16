Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9342A26CAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgIPUU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgIPUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:16:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3648BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:16:10 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id v14so5439853qvq.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=MdhjrW4vcBDFIsP592gsDVtZRkvVNqCEWObBUfpScyE=;
        b=S/LoxaBxieC8lVQIkT05JmeKWV2q00m0KOl6lbdUZjttEi6gPmAODOXo+OXyxqrhp5
         jxPED41CrMMYGGYzgcLlvcapQJkQdfTUu9i2QXM7GJj+w4SlufZvPPq7CGx+WtQs5XXo
         I7YllF7a+UdR+tYaO2wRl5ZyHZ08LTfmccXArvii4SlsuqhTQSdMvOeJoNCanj/J/7Wq
         Vk8TR0Obzm/HN+IlfEHsaQMXotor2YyiQBI+pjYMRM8fXogZlhgu+SnJz3gWWC4Fqk3b
         iMPaxRdAqigrr2GENqry48MO3EbiyvN+S1Mii7DlJQe0FygQPQ4B5YRNsIT0vZcGSpL4
         sXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=MdhjrW4vcBDFIsP592gsDVtZRkvVNqCEWObBUfpScyE=;
        b=Bh4t41Ls3LkRlXhtEbBqtEpCNqzG9uRMq5/uI5zU/PWmDlSOd3kMjsY0vAIvs3lGoW
         4hKBc14Z2VjSZk06Q0dOi5+TXnXhrJdTPYmy4sY4xVH2AHjfucImfUj6kTGBSQ7idKBt
         332WXOryPLDwuJn2B/JmnA8MMe7QwR0EbhNaWnRLz7J1KrI5WXy9ep4egfoX2rgtYW0Z
         vmRoGWSvILCbav/YZMhGERjoB/mfjOwT5Yw+0xaYjX3aSoGUCMEqPmhH2K0KzL0bd99L
         HHYefe6BABVRklwHkFEX35gfFlr4tSKLtLfRT2xcEGgpVnBesAKBYecWF3cQs7bMkNo2
         S2Mw==
X-Gm-Message-State: AOAM531ZxBv5o4isybIzt9IH0Jm6QpL35Pf98q7elZbR032abOID390a
        /+P3kRAvboNwbDqTTBAswTrmmjiLsQalgOfJWf4k
X-Google-Smtp-Source: ABdhPJywYsxto73uCa5oqtF8W1GKrdTZFnMdhJn+ZM5F44wJqwc0/cZMV6OE3nz415keyKpfasZRfYqZsOwq7WwwtBWA
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:57a7:: with SMTP id
 g7mr25361605qvx.10.1600287369377; Wed, 16 Sep 2020 13:16:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:15:56 -0700
Message-Id: <20200916201602.1223002-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH 0/6] Bluetooth: Add new MGMT interface for advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

This patch series defines the new two-call MGMT interface for adding
new advertising instances. Similarly to the hci advertising commands, a
mgmt call to set parameters is expected to be first, followed by a mgmt
call to set advertising data/scan response. The members of the
parameters request are optional; the caller defines a "params" bitfield
in the structure that indicates which parameters were intentionally set,
and others are set to defaults.

The main feature here is the introduction of min/max parameters and tx
power that can be requested by the client. Min/max parameters will be
used both with and without extended advertising support, and tx power
will be used with extended advertising support. After a call for hci
advertising parameters, a new TX_POWER_SELECTED event will be emitted to
alert userspace to the actual chosen tx power.

Additionally, to inform userspace of the controller LE Tx power
capabilities for the client's benefit, this series also adds an MGMT
command to query controller capabilities, which returns a flexible TLV
format for future flexibility.

All changes have been tested on hatch (extended advertising) and kukui
(no extended advertising) chromebooks with manual testing verifying
correctness of parameters/data in btmon traces, and our automated test
suite of 25 single- and multi-advertising usage scenarios.

A separate patch series will add support in bluetoothd. Thanks in
advance for your feedback!

Daniel Winkler



Daniel Winkler (6):
  Bluetooth: Add helper to set adv data
  Bluetooth: Break add adv into two mgmt commands
  Bluetooth: Use intervals and tx power from mgmt cmds
  Bluetooth: Emit tx power chosen on ext adv params completion
  Bluetooth: Query LE tx power on startup
  Bluetooth: Add MGMT command for controller capabilities

 include/net/bluetooth/hci.h      |   7 +
 include/net/bluetooth/hci_core.h |  14 +-
 include/net/bluetooth/mgmt.h     |  48 ++++
 net/bluetooth/hci_core.c         |  47 +++-
 net/bluetooth/hci_event.c        |  22 ++
 net/bluetooth/hci_request.c      |  29 ++-
 net/bluetooth/mgmt.c             | 420 ++++++++++++++++++++++++++++++-
 7 files changed, 561 insertions(+), 26 deletions(-)

-- 
2.28.0.618.gf4bc123cb7-goog

