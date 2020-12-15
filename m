Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFC2DA931
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLOIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgLOIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:32:51 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390EFC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:32:11 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w135so12873386pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fe1km3yfxmczncgouQwLa2uCpf9EDAfkHINKI/Vhceg=;
        b=pg0LTRa3ZvcyZMwu51VdorUHI4theOfbNwh9Hw7ALeyxmHoQyminTLmEnX0FrDAbRZ
         WlV+gujM42wj7dIzbmuwatahwhDQW2nLEo8a2+NhZCGM7Z0lBUgqUDoOcZ5lgx20eHz5
         W4dNpeuRH2/EoL6JfOM+MJwwGGIa5kLXAmXV42U8f/Kzhr0yM5C/5mwaKe7nJ6yrbLtl
         NbkiKkX+HFVJvjGyQmRG4ZgYirB/wBiU2pkk2tNP7q+fJrVnZu1IL2mmM0hDAWF+VN7+
         wp+4a30W12k4OqvqtYyytodm33EGLTV1vYN2GdBT+Uedne9B3BG25K+gErJ9LD9G8F3N
         ZkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fe1km3yfxmczncgouQwLa2uCpf9EDAfkHINKI/Vhceg=;
        b=d37KrEULPclbNSonBukRKAHFUjjY2c+ckDcvc97X8PQ25SwBcBiR7Mg6k7zdkPZNJC
         UEtdLLVu2P3JQSOn6qv5rVoLQ+tq2xfBSYBoF01498KbJJqGxEm+8qmUz7oWm6MUeb2i
         FCGCb36P9euo2APbuXK6bJh0DlXAJduWTGjlhfAzhc1r7tjglTnEDvFXo43NU8+G0H06
         lE4ttLKGhvPetJATwSaSoJAKlmLjb8Gt+DgdMyKjPl/BYkIbiyFFSK3F49wpsq+ygBbs
         GPc/C25hVoIaH82kv6ce+HfiAGYfn5ijZ0QZOqe+tGAooxORM0qetZH3KAe367Gzwgar
         ixjQ==
X-Gm-Message-State: AOAM533MIDXN3k3v0nFPqQd3OgW2F/aQCNVDYlkE+rWQ88uzs0AOl7wy
        OidfHpL0x8FZMO3uXFzDERZWYuuKvWNv
X-Google-Smtp-Source: ABdhPJyHFmFx1T+NbiSbfwLZtAeXJfRairfMEb0kbPranBvrnu+mqbSUtYTxVlceam5btLIAyr9WjgGQ0hgN
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:cb8d:: with SMTP id
 a13mr28800707pju.155.1608021129175; Tue, 15 Dec 2020 00:32:09 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:31:56 +0800
Message-Id: <20201215083201.1343692-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 0/5] MSFT offloading support for advertisement monitor
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>


Hi linux-bluetooth,

This series of patches manages the hardware offloading part of MSFT
extension API. The full documentation can be accessed by this link:
https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/microsoft-defined-bluetooth-hci-commands-and-events

Only four of the HCI commands are planned to be implemented:
HCI_VS_MSFT_Read_Supported_Features (implemented in previous patch),
HCI_VS_MSFT_LE_Monitor_Advertisement,
HCI_VS_MSFT_LE_Cancel_Monitor_Advertisement, and
HCI_VS_MSFT_LE_Set_Advertisement_Filter_Enable.
These are the commands which would be used for advertisement monitor
feature. Only if the controller supports the MSFT extension would
these commands be sent. Otherwise, software-based monitoring would be
performed in the user space instead.

Thanks in advance for your feedback!

Archie

Changes in v2:
* Add a new opcode instead of modifying an existing one
* Also implement the new MGMT opcode and merge the functionality with
  the old one.

Archie Pusaka (5):
  Bluetooth: advmon offload MSFT add rssi support
  Bluetooth: advmon offload MSFT add monitor
  Bluetooth: advmon offload MSFT remove monitor
  Bluetooth: advmon offload MSFT handle controller reset
  Bluetooth: advmon offload MSFT handle filter enablement

 include/net/bluetooth/hci_core.h |  34 ++-
 include/net/bluetooth/mgmt.h     |  16 ++
 net/bluetooth/hci_core.c         | 173 +++++++++---
 net/bluetooth/mgmt.c             | 333 ++++++++++++++++------
 net/bluetooth/msft.c             | 456 ++++++++++++++++++++++++++++++-
 net/bluetooth/msft.h             |  27 ++
 6 files changed, 919 insertions(+), 120 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

