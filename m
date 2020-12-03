Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67D12CDF79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgLCUNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgLCUNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:13:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44CC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 12:13:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r4so4182598ybs.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 12:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=btTE2w9BbTs5elBO8g6GQzeY/qiJGlW6YLv984UAgDM=;
        b=L2BxuWWmA8ArI7guPa4vcAIDCmn2evZqAvGdG+VlnzIfw3CStLVSd2QTImdgQtcN0Z
         xONojVkLChQNArAIUKXjKTMa7GzVjvMqhlukkPpivHvkqRzNhLUCK/oz+FFQ/I6gM1FN
         im9hGqQqxGwleVFxv7WdZ+TLFmqqpz2hXgtN/KkrNebGlsZQWvF5btFjD+P9W3JrhA15
         0RvB6M85VVcG283Hw6uLx+4jGgTR/Id3JCJkbrxDqHqmU2P4FO3gpTosrN2Ce0khfxuX
         h4T+lBV9BOeCgXG43qU9Otjwai1YEgEhvw0qZbw+JGBFt3UYWeGVWkVGqbNqh3BC887S
         Deaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=btTE2w9BbTs5elBO8g6GQzeY/qiJGlW6YLv984UAgDM=;
        b=tVt3yxuucd4DzyqP2ZVCzXHWod4sc+pWcYYsZdBjbHuiLmTIydqnI53DBfBl/sBQmj
         5NZDtyUp+ieDp1tv4YeyfbDpt3PfejpPiYC1oqf7VyB+25FqqHpXRpoXNNjulQsOFCoT
         5TH68ySupNjDJH/mhbhjpTL2U8DwOzmljDlbZX4OFnB8mRs15SSS3AmweRZhUpFcn5XZ
         JAz3olunoKzcoImLnriEU339m8w6cQi0T9b5/yz/6zfidqhV0e5UP1DVST0oKIlH3X1R
         wWLu/i/tOpyar11aLtX2rFssTRMXsWuOR98w9W0n+/l/K2GKqnrtoL1aDP2zjSF9Cj09
         EQmg==
X-Gm-Message-State: AOAM530zAeYKJwUx6LHH9kDKgpJCkBAMgzgnJMgOhVgjOO07DR9h7iSt
        DQmH3qaQ45KKBr/FyL4LSOBKeWp1sgo+YsjAjITa
X-Google-Smtp-Source: ABdhPJxtHWfChFKZpuTj/LD66qwvtsotlU6iWdvFg6vaWDrv7Vj8HSMsxdTZP4H+j3VVxrKuvXuBHdDLqYsF0ido49XH
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:a2ce:: with SMTP id
 c14mr1185195ybn.393.1607026385919; Thu, 03 Dec 2020 12:13:05 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:12:47 -0800
Message-Id: <20201203201252.807616-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v7 0/5] Bluetooth: Add new MGMT interface for advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
will be used with extended advertising support. After a call to set
advertising parameters, the selected transmission power will be
propagated in the reponse to alert userspace to the actual power used.

Additionally, to inform userspace of the controller LE Tx power
capabilities for the client's benefit, this series also changes the
security info MGMT command to more flexibly contain other capabilities,
such as LE min and max tx power.

All changes have been tested on hatch (extended advertising) and kukui
(no extended advertising) chromebooks with manual testing verifying
correctness of parameters/data in btmon traces, and our automated test
suite of 25 single- and multi-advertising usage scenarios.

A separate patch series will add support in bluetoothd. Thanks in
advance for your feedback!

Daniel Winkler


Changes in v7:
- Rebase onto bluetooth-next/master

Changes in v6:
- Only populate LE tx power range if controller reports it

Changes in v5:
- Ensure data/scan rsp length is returned for non-ext adv

Changes in v4:
- Add remaining data and scan response length to MGMT params response
- Moving optional params into 'flags' field of MGMT command
- Combine LE tx range into a single EIR field for MGMT capabilities cmd

Changes in v3:
- Adding selected tx power to adv params mgmt response, removing event
- Re-using security info MGMT command to carry controller capabilities

Changes in v2:
- Fixed sparse error in Capabilities MGMT command

Daniel Winkler (5):
  Bluetooth: Add helper to set adv data
  Bluetooth: Break add adv into two mgmt commands
  Bluetooth: Use intervals and tx power from mgmt cmds
  Bluetooth: Query LE tx power on startup
  Bluetooth: Change MGMT security info CMD to be more generic

 include/net/bluetooth/hci.h      |   7 +
 include/net/bluetooth/hci_core.h |  12 +-
 include/net/bluetooth/mgmt.h     |  49 +++-
 net/bluetooth/hci_core.c         |  47 +++-
 net/bluetooth/hci_event.c        |  19 ++
 net/bluetooth/hci_request.c      |  29 ++-
 net/bluetooth/mgmt.c             | 430 +++++++++++++++++++++++++++++--
 7 files changed, 548 insertions(+), 45 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

