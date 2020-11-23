Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68662C00D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgKWHpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKWHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:45:41 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C9C0613CF;
        Sun, 22 Nov 2020 23:45:41 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s63so3597547pgc.8;
        Sun, 22 Nov 2020 23:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BFitlouLqV5WjAV4yis+SNy1ksEBkbSXVdeVWFMxCgQ=;
        b=FfdFOa/yYakciFlKN4s4XKzdLppr3kFkdihyIqw6pVOmbiIvPV4hnA+HOCX4tMdJ+5
         kwyOZ0IOBV9C7zvY/+LD4FRDDCj2Q9g2o+MammUxnHjQuLzmzl5ebbdUFr/aYZkuQH3C
         IsIOwrPgUGdg0wO9jVME4yIEKj2FWwGFU1itdcjjBAK/EbVOOBSB+05kb2xFoNQvHwRZ
         GHX2T2H9d0UZjf3vKW8fPqcS62E9J1TeIJxPmTSaEdPelUFsnI6tc66YG/bUWZpBwg+P
         4jtC2j1P1NTvwMzGEHgU01iAQ8z5Xqvo0t5lGYPHEfwq/XeubjjrkA8tVy7q9CPlCVDU
         RViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BFitlouLqV5WjAV4yis+SNy1ksEBkbSXVdeVWFMxCgQ=;
        b=C0xR4+hmCZrNS0Fhbc9EEGxlZ1qG2zNPwl47M5/WmpUcCdMDAJkxjS+XysG7cam3X9
         5RmDNvVDK8meg9mwTsqrmrRgD6uTpD0edMcVjXUbCrvzddxIgfGTOqLVVP3AguZP18rL
         MBIMYGK/GWhRl/zJIk+VqHfwCiXyRxuFawycbaGeIh5zThJ8CKKY5t0IhHIF31V9i1N2
         EI8dbFecRpEKYqxlE9yh8p9e/cRdokodr5ulSXln3LAIZQqypIzzlfvUt8z4WfA8uv4v
         c0QRoRDCfDJM18tq6ULfLajzEieLbkmiRa13+QWmuzZOdzKJ5MmASGdXzPbvCJk1s8y/
         j5Yw==
X-Gm-Message-State: AOAM530P0Ie4Mu3yo5VGmiCHSq0pEwhRYvjg/uF7gE4vK35vNcZFNKGN
        93NdPKv80zv89rlerp1SaaQ=
X-Google-Smtp-Source: ABdhPJyXUUqOuVScJwF1uK//p0FtqpPoILzGVsy9yWd3AX1S6EqzWMd6jO710sDbiwjkEihrx4PXIg==
X-Received: by 2002:a65:4c0a:: with SMTP id u10mr527328pgq.294.1606117541329;
        Sun, 22 Nov 2020 23:45:41 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id 12sm13176340pjn.19.2020.11.22.23.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 23:45:40 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com, mikechoi@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 0/2] hwmon: (max127) Add Maxim MAX127 hardware monitoring
Date:   Sun, 22 Nov 2020 23:45:30 -0800
Message-Id: <20201123074532.3730-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds hardware monitoring driver for the Maxim MAX127
chip.

Patch #1 adds the max127 hardware monitoring driver, and patch #2 adds
documentation for the driver.

Tao Ren (2):
  hwmon: (max127) Add Maxim MAX127 hardware monitoring driver
  docs: hwmon: Document max127 driver

 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/max127.rst |  45 +++++
 drivers/hwmon/Kconfig          |   9 +
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/max127.c         | 346 +++++++++++++++++++++++++++++++++
 5 files changed, 402 insertions(+)
 create mode 100644 Documentation/hwmon/max127.rst
 create mode 100644 drivers/hwmon/max127.c

-- 
2.17.1

