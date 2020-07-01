Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FE2114CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 23:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGAVNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:13:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1CC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 14:13:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k127so22967998ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1693jLPCRTZKv04e3tT1L2R/SD/azULEZvoSLa7Hf7o=;
        b=X4N13e+9sePnsNX3KaC3ifEpq8r8prYY7zHclzCR5upKpuH+zMAIp0a3v81FRPNLSQ
         G/oEf3GoGKzfnImMohbfzdfak484FP/LerO7QfZnV6oiJy5RkPeJ4JGyaWW4d/KoT+og
         xaCTxxyLWdrK4Iy5oj1E4JZQLNCwWwFK+QmJ/rHwp8YgFpakYgrdyJcDKvQ7Hhutimdk
         veAa42QeTkaDOUzn9UlIWlC4KV+uT51zeVpLjn2F2l8a/oToAXzSKFN4laYPXVsvB7KO
         IWeEQJElTFTPPbn1R8LGZw8Vc3cSYrMYEomRY+SMbjXzjp+LawK0qruJeF/TCA8JmuqR
         92mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1693jLPCRTZKv04e3tT1L2R/SD/azULEZvoSLa7Hf7o=;
        b=VK1PIQHEDvIQaxvomxDexBUM04+DiZo2aN0CVDF6XZrnJofhj04/Df+XdkhtZxl5FR
         a757I8pRdl6NFm71Pz/pxWCnk9h5gM8Al8NirinV5mNuOeE7eZ30g2ohZBLD0QqNm8+E
         zPNIA3RujCUhLJh9Np2YJlyYBQpdA4GBj6NUFvsbuTPH4Stt+Sn1nB499b800tFRNtwh
         xP0NJPODW5yAkR6Z+QfhdC5nHEdXmIWPAGETC55MR5u7yrBtvfVNbHnjXzlk1lVn2mMm
         oivbifaJ/l0IAcrEzy30j5rnccVX0MW6mQObw+PGUTA2ZJBu2WmKNRiAsmO9Wcu9QWXa
         gEow==
X-Gm-Message-State: AOAM530yMCAX75p1GF9zJLknHTUEzOuhgzTAX/hO6cBrHaI+xNV3e7Ye
        AXVLCg7zvOM856Ik2V9IYuwEK6ddwnwR/rIpyG67
X-Google-Smtp-Source: ABdhPJz8wsHLEwNJYlVtw6qZZkh7AGzr6LYq5q8mwTBXuA/WiMwNXf+RKMjvBio06uTM33Rt9QsVW8X11w5NfovFi+WJ
X-Received: by 2002:a25:c7d3:: with SMTP id w202mr29331301ybe.84.1593638022312;
 Wed, 01 Jul 2020 14:13:42 -0700 (PDT)
Date:   Wed,  1 Jul 2020 14:13:36 -0700
Message-Id: <20200701211337.3027448-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/1] Revert "serial: 8250: Fix max baud limit in generic
 8250 port"
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        stable@vger.kernel.org, abhishekpandit@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This change regresses the QCA6174A-3 bluetooth chip, preventing
firmware from being properly loaded. Without this change, the
chip works as intended.

The device is the Kukui Chromebook using the Mediatek chipset
and the 8250_mtk uart. Initial controller baudrate is 115200
and operating speed is 3000000. Our entire suite of bluetooth
tests now fail on this platform due to an apparent failure to
sync its firmware on initialization.

The driver is in the cros tree at drivers/bluetooth/hci_qca.c
and uses the serdev interface. Specifically, this is the
QCA_ROME chipset.


Daniel Winkler (1):
  Revert "serial: 8250: Fix max baud limit in generic 8250 port"

 drivers/tty/serial/8250/8250_port.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

