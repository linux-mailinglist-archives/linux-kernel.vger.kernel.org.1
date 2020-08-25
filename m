Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1618225242F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHYXcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHYXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:32:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69407C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:32:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o8so320829ybg.16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mTR23obn3++N19RG/EtHRUQ3yC7sF+wMDpRoTOlZX0k=;
        b=ILiabPYE0me1HApwqMZ2+3BMmFww6n1ALOpdSBbDFbzKlr8HpfRhnjA+ISbcuuCAQR
         9T01Gt5pqwAn+LaofE7+YcT/A8YfaoOaSm1n03/ZcmKrAq4bY8iQ3M5U1xY70qywVrOD
         /cvdd25kfRWSFfgRbHhF4e+h85P2hLdeSwto5EXMHXa8Fqk3Hkwai09/435nJcz7/Wxz
         9oO+z1NaMwqw3BEs1OEnxEY05fEMo4zXU6l/2iQLtpIr1W0KYbfx7WWk8sLHtkoJF6mx
         Lyn4XwjPSRbR2cL2swtxooPGCKUbsCemeyS7KjzH8jazjYlc/M/euZDEP39GlCSuEHAu
         Si3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mTR23obn3++N19RG/EtHRUQ3yC7sF+wMDpRoTOlZX0k=;
        b=m1mVZsYObNT3rZIW9mFZj0j0nfHcb8HnMQn7Afma9B1HmYCi24ZKGYJhD2VPUJ9pu4
         WMPQWuiIZXS9ZXtusTTxbToEaZ69PgL5gZLFxWTW2L/lvPNcfqschFt0Qm3uJXAz0fR6
         z++vSV4W2xlf41g+PcCiwQkLvKUn//AfbpdD1JBwLrNkhCHt7EWXjDRaEg2dxQ6jK1B+
         3kdUmrySW8UFwctAEwXXXWVhnD8/Lt58Ee8m5ufp7+ULIyyFFIWC1VPOeRjIjDTLj5vC
         viIP0sIFTy/0td64oK34oa+V1zmRfTp4KDH0mjjTh9YLoMZ9HzlmEACe55XK0apbpCzQ
         Ls7Q==
X-Gm-Message-State: AOAM5320sE5G6QxbjgPBatnzvdFN3rPdMoHftj4PTyB6+WhUQXFEt8Y1
        ocTJdP/LDCUTXJw3d3xChdU22FvURb1qQ3tsvnpN
X-Google-Smtp-Source: ABdhPJwwLjoeH289Grt/z9y7LeTjH6etNBMtETY13Iy6KtTX8eH2Poc0k3x27Uzj1hmt6b9xngXhpGRYYx+hu4S5cLCO
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c68b:: with SMTP id
 k133mr18907196ybf.491.1598398320460; Tue, 25 Aug 2020 16:32:00 -0700 (PDT)
Date:   Tue, 25 Aug 2020 16:31:49 -0700
Message-Id: <20200825233151.1580920-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 0/2] Bluetooth: Report extended adv capabilities to userspace
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Maintainers,

This series improves the kernel/controller support that is reported
to userspace for the following extended advertising features:

1. If extended advertising is available, the number of hardware slots
is used and reported, rather than the fixed default of 5. If no hardware
support is available, default is used as before for software rotation.

2. New flags indicating general hardware offloading and ability to
set tx power level. These are kept as two separate flags because in
the future vendor commands may allow tx power to be set without
hardware offloading support.


Daniel Winkler (2):
  bluetooth: Report num supported adv instances for hw offloading
  bluetooth: Add MGMT capability flags for tx power and ext advertising

 include/net/bluetooth/mgmt.h | 2 ++
 net/bluetooth/hci_core.c     | 2 +-
 net/bluetooth/mgmt.c         | 8 +++++---
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

