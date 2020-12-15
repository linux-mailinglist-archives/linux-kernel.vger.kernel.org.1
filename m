Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5142DB528
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgLOUbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgLOUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:22:26 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458CC06179C;
        Tue, 15 Dec 2020 12:21:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 23so42734268lfg.10;
        Tue, 15 Dec 2020 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MazWmRH0RBhpM5nyt8u1lPJS49rqRNCrHfemkU4WKcE=;
        b=RgdkIsgZHTa6lyAzAcJ19sU+Wxb44VlsrjznHVWljCtqySjZF1kwlyTCABVqFjXqBX
         mdz02bdTgQIUpKQbHFuFuDfalFOizwCdKano1GH4gWx1pWeucW45Nhg+mgvc85RyLMSA
         Z1oKC1gefElynYb6fm0VUHCATiohvj4aJFMUApgBwFn1c/5luODgJdDtWoLbZnYUTpAY
         BpRhkskhpZgwBtxt7gr+zUDr2isK9jTAM9cdrxRVOtd7Ju5BseDQ9JLlRwJlvqu0fUuW
         +LGpYlbIMSSkcXDM5uxrNP2V/rTpI9P26ylMqqHl+UyzDjVLzXxR2A83UikRbG2egZSN
         AsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MazWmRH0RBhpM5nyt8u1lPJS49rqRNCrHfemkU4WKcE=;
        b=uRK3MCduVtjUz8hQTVFgX7Gfyq3g62ktp9JuerFpztR4/eN2r4RmJ5ZI9tQCEQ+7K2
         oUNSecWxo39Bx18gP8yDyBL68sf5/iAXZPvwIbagw7pAwS5qdON5ZT6CASmJgJhI/HyS
         RYQx9vzmLhy9DImfXVJO9eeM8V3EpykdEBfq+E8qL0FaNFXfnOIYt/ACPIJtv7jzUQRd
         ICWOLHXaPccjgvQigwgrZ41aMKWWIu2yh1AVG1G9dwunDPWBthcIFCc1BsJG1QstRf4c
         +mwK3uLO+zO3n1VzFzLxQKJLSCZpfVOA+x5M1q/QevGphgsQAer2blK4gUp0j75VV+Fz
         SFQA==
X-Gm-Message-State: AOAM532GvqdvLyWThrbCIkhSqQHlGhf9Bn8tVGqWQ8QUZaPZZzNSXvlz
        EozlFBwjpeSBsf8nI+id6aVgV0FSFcg=
X-Google-Smtp-Source: ABdhPJxS2NaeXz7sDiu37rL+KyWdCQjarNtgSXsPfY0tHJ9nICGZBZJXEluP/zWGJEzOh8g5sLIZsQ==
X-Received: by 2002:a2e:712:: with SMTP id 18mr7318969ljh.165.1608063704756;
        Tue, 15 Dec 2020 12:21:44 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f3sm2873711ljp.114.2020.12.15.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:21:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] Support Runtime PM and host mode by Tegra ChipIdea USB driver
Date:   Tue, 15 Dec 2020 23:21:05 +0300
Message-Id: <20201215202113.30394-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements Runtime PM support for the Tegra ChipIdea USB driver.
It also squashes the older ehci-tegra driver into the ChipIdea driver, hence
the RPM is supported by both UDC and host controllers, secondly this opens
opportunity for implementing OTG support in the future.

Patchset was tested on various Tegra20, Tegra30 and Tegra124 devices.
Thanks to Peter Geis, Matt Merhar and Nicolas Chauvet for helping with
the extensive and productive testing!

Dmitry Osipenko (7):
  usb: phy: tegra: Add delay after power up
  usb: phy: tegra: Support waking up from a low power mode
  usb: chipidea: tegra: Remove MODULE_ALIAS
  usb: chipidea: tegra: Rename UDC to USB
  usb: chipidea: tegra: Support runtime PM
  usb: host: ehci-tegra: Remove the driver
  ARM: tegra_defconfig: Enable USB_CHIPIDEA and remove USB_EHCI_TEGRA

Peter Geis (1):
  usb: chipidea: tegra: Support host mode

 arch/arm/configs/tegra_defconfig     |   3 +-
 drivers/usb/chipidea/Kconfig         |   3 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c | 327 +++++++++++++--
 drivers/usb/chipidea/core.c          |  10 +-
 drivers/usb/chipidea/host.c          | 103 ++++-
 drivers/usb/host/Kconfig             |   9 -
 drivers/usb/host/Makefile            |   1 -
 drivers/usb/host/ehci-tegra.c        | 604 ---------------------------
 drivers/usb/phy/phy-tegra-usb.c      |  82 +++-
 include/linux/usb/chipidea.h         |   6 +
 include/linux/usb/tegra_usb_phy.h    |   2 +
 11 files changed, 481 insertions(+), 669 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-tegra.c

-- 
2.29.2

