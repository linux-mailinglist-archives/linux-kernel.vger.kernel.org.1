Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3E2F02DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 19:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbhAISX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 13:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbhAISXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 13:23:25 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F3EC061786;
        Sat,  9 Jan 2021 10:22:45 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id j12so13019602ota.7;
        Sat, 09 Jan 2021 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSlEJcVDQ1Is7F8HzL1P4/BpSTCC8IQf3uYHrRHbZMs=;
        b=DmHvlbUnniUweykeBHqKFo922FZWPH+Jtj/z/Bs0sr22H7FX1Y56KZ/tTIwdiGD6po
         KskJOjY+wBew3YDlrWjhoDa41VAqRcI+S0Pec9x0BJr9lAXx7ql9WbHG5jGHUxFCf7sR
         LasgNNZMLl+SArMglAlUdoaTQ6Y0rK2OcOfUcIoIyWN/ZzraR31sALeYa8IwtDzmjEcV
         dXeHuCYVLByaM5sTCbAYdVhsnEIoyxnUFxhbJMgYJh08rzjxmomv3ugGnkQzOg3fJHxt
         a1ne+KysVgYv+QH8ux6LSVRnGpJJEJPOUxlry746XWDELhXo3DeKUxjszY+4zb5RLFWJ
         7B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nSlEJcVDQ1Is7F8HzL1P4/BpSTCC8IQf3uYHrRHbZMs=;
        b=ebesDq2dlbUQUtMPfshrjFvGpz2xgsOOgsgtnhyeWsbBXvAvUGlILNHOru4Ie75Suj
         sFf36UsvqMEZ+O9f1yFTJo6EuhOdye/P+q6IS9CDR++o+YP4cPs3QniuVqKZCw910rx4
         889LboPOjXVUJk+9BXzP2EVRgd3+Uc9DfcPe4MfDQzTfRh8NJ1E45cVAnbcPbc9WMcbD
         PiCV2c4TvUh14tbAnrPt/cP7dx/9dAv9TI1UAgZXUCEM/5rKMEToWzRGpqmCu0qUy62y
         CXeMB5ZlkBQkvBpn8d/84huJKOA4M70cegTG/ZxjQ/So1+bvYnON+DcRybo/a9YwmARw
         WSgA==
X-Gm-Message-State: AOAM531ctY8NLL0Wajb+XmMHO3gblQqeycqR2EqETVaZ9JwV/No00jM8
        L7fMrCBgKntDXcdntY9BSIqMCJYPDMA=
X-Google-Smtp-Source: ABdhPJymgxtCVJEvFFC6LqVxnD0uOQO+24tFJRkTxsLqwrMRK3RsdJSZ/44/CMzaQF3EZ6mAmcSp0A==
X-Received: by 2002:a9d:6ad2:: with SMTP id m18mr6499235otq.3.1610216564481;
        Sat, 09 Jan 2021 10:22:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm2601101otr.81.2021.01.09.10.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jan 2021 10:22:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.11-rc3
Date:   Sat,  9 Jan 2021 10:22:41 -0800
Message-Id: <20210109182241.179998-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.11-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.11-rc3

Thanks,
Guenter
------

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.11-rc3

for you to fetch changes up to 84e261553e6f919bf0b4d65244599ab2b41f1da5:

  hwmon: (amd_energy) fix allocation of hwmon_channel_info config (2021-01-08 07:31:03 -0800)

----------------------------------------------------------------
hwmon fixes for v5.11-rc3

Fix possible KASAN issue in amd_energy driver
Avoid configuration problem in pwm-fan driver
Fix kernel-doc warning in sbtsi_temp documentation

----------------------------------------------------------------
David Arcari (1):
      hwmon: (amd_energy) fix allocation of hwmon_channel_info config

Randy Dunlap (1):
      hwmon: (sbtsi_temp) Fix Documenation kernel-doc warning

Uwe Kleine-König (1):
      hwmon: (pwm-fan) Ensure that calculation doesn't discard big period values

 Documentation/hwmon/sbtsi_temp.rst |  2 +-
 drivers/hwmon/amd_energy.c         |  3 ++-
 drivers/hwmon/pwm-fan.c            | 12 +++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)
