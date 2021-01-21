Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0E2FF843
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAUW6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbhAUW54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:57:56 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6674FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:57:16 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h129so2742014qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=j4rzbjtP6KABLxWwLyYI2aSbVFYm4RTsvKAyzhvznIc=;
        b=Rsyebny0nKwz0BxmlbDuCmRFvFbpVCAB8r+VBNwaR3o4QtxqhBT5CnYLmGtSzCpp/2
         jVE70nElA2UoNrNd7nYpvMcvDD57wQdFrE9DS8z4zOgkop6T7EkVZhJwsEFjwtR85AEY
         iclRzYlf0JmH7L8OMfMDY/TQe1yDVBsTYkC+XdiJVNwJHTu0/twzdV6pRIe5F73SPrqe
         +Ba5X1wYEwyjhbsL2naDaJsCJasA191oxQ2LF2MLMdMBfXDLCIpG/gNic97X/djWjR7u
         DOCkav5lnENLNdnxgm6hywDXeRSU7WeH6yluDfcGbxVBrGwEOFQrNZcjresxLnd9GeLH
         BZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=j4rzbjtP6KABLxWwLyYI2aSbVFYm4RTsvKAyzhvznIc=;
        b=PIiqY4v5xZlrEPj4WClea96x7P3EKmOxGuqpM59LYuy6fc5feyKAA2ojFL/meBtxdW
         QPUTpFj/b3m3XrlZjSyYmjNbKV3Rs5d498HFieYD1EHNnBFAWLqJjnaM/f49SqpSCAhH
         4kHOL+CIKtCy8hadTcxzd13b6/TYbEUhblxyaraAymu2ZAF84+JTdFhiAAg+FSHdrIHH
         VDJCiL/z2rgktF7DbTRv6bzyIEG1upN03sG6G3XGsIBXM4bhdOOxbbnXdq/Y53JrW6ot
         SwEr/CIhNIPJDdfKltvdNjIuurn7o3R9ei245YgmFk4eFAeKVgk25Y9TUzq4MJeAeMSY
         dYmQ==
X-Gm-Message-State: AOAM531daCVKK1jTA9FPaoBN7oJazCJZ5JSuGefcsxy7UNG37yj56ayx
        zbotNmkHYeyWIfHiQd3i9Hq/79enxitASGs=
X-Google-Smtp-Source: ABdhPJx0NBdy8RBsm1t/01e7aGi8ELAAFrlYM7hMKQPVamkU3FpnJK3qauqXtEVArv7o3wfWAPHKhVMTVIHl18o=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:cd01:: with SMTP id
 b1mr1986113qvm.21.1611269835503; Thu, 21 Jan 2021 14:57:15 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:57:10 -0800
Message-Id: <20210121225712.1118239-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 0/2] of: property: Add fw_devlink support for more props
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again because I messed up the To/Cc for the coverletter.

This series combines two patches [1] [2] that'd conflict.

Greg,

Can you please pull this into driver-core-next?

-Saravana

[1] - https://lore.kernel.org/lkml/20210115210159.3090203-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20201218210750.3455872-1-saravanak@google.com/

Individual -> Series:
Patch 1/2: Addressed Geert's gpio-hog problem with gpio[s] property
Patch 2/2: Switched to using of_irq_find_parent()

v1 -> v2:
Patch 1/2: Added the Reviewed-by tags
Patch 2/2: Updated commit text and comments. Added Reviewed-by tags.

Saravana Kannan (2):
  of: property: Add fw_devlink support for "gpio" and "gpios" binding
  of: property: Add fw_devlink support for interrupts

 drivers/of/property.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.30.0.296.g2bfb1c46d8-goog

