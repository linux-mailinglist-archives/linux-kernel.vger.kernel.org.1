Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB42E0D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgLVQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgLVQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:23:28 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B6C0613D3;
        Tue, 22 Dec 2020 08:22:47 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x13so12366220oto.8;
        Tue, 22 Dec 2020 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6ew9qbzNLraaN+foW5JE4dmX208tLCsl+zWQ19IzhC8=;
        b=SSEat8yfatElTLyK8rphkk2sBsjNcDGLNkbpArUyqZYqUb5A3n18fP6aZ32ADNLT+X
         k2MNiDQSXhb9+OnbdizF9hdqczTHXVNUPY+n1OS5bj1yVvfKBiyF2asA8CrjLUc4G0AE
         GZtRv8yWOZzX5kEPhjdq4QBtHFc530CXenbZEcee1NJ1biLwAtX8uYhJdedVKy6deWt7
         tk/QvCPIxwwYHhq5YS73jh7bgGsNSriLBDjuAWQc35HLSeUF38JXX/gp1Q2EPukSlB8z
         UlOb9iQk9Cre6rdXvwTum3ejh/17VVGLP4dvqzzEjPtso2/8+HTK6B3czNKTI+88uyHD
         1uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6ew9qbzNLraaN+foW5JE4dmX208tLCsl+zWQ19IzhC8=;
        b=kluPWB2b9QWEsnNly1gOM5DxXQJUwi0XOcgBQM5tpFRrrbP5iZzgjZmkCO7mpSY5Du
         7RACnv4FnfdVh0jDmi7nxKK5QDb0H9ycpwVtdZDR98wpqOF09K8E4UkD9GTo5NLL+mG2
         IuCH071KyJDmyFa8Tl+7h3bBRX5wMxH5xm4GAE5sxef8a4dZhRx/UggvjmFdyGjjrvVC
         6/j/5ZybVliIoCBQ5r1iAAojD7CvKYONDdU++MylyZvb1rtLcRHijrqW8gUp29zjAGEw
         XFdXUWrjaFrELjf5qzrgdJPBooj2euAyXNqA33sDqqbs5ksEjCrBsrmqpCh2dExhXzrK
         Z0Yg==
X-Gm-Message-State: AOAM531OIOMHadJxGt2GHU5O68MDXir98xv8REhaMzZOBmDAO0HygkNn
        PMEOgRr6SiM745gjwZ9AO7v9/Co3xkk=
X-Google-Smtp-Source: ABdhPJzmDTduxE7D9jkLlR27P4g2ni135Hbif6RNC692cOVpKggTitoPAggzbO4vKbFJ/6/eDs1OnQ==
X-Received: by 2002:a05:6830:188:: with SMTP id q8mr16411290ota.96.1608654166302;
        Tue, 22 Dec 2020 08:22:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13sm4561465otk.58.2020.12.22.08.22.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Dec 2020 08:22:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.11-take2
Date:   Tue, 22 Dec 2020 08:22:44 -0800
Message-Id: <20201222162244.181444-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.11-take2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.11-take2

Thanks,
Guenter
------

The following changes since commit 8653b778e454a7708847aeafe689bce07aeeb94e:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2020-12-21 10:39:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.11-take2

for you to fetch changes up to 0a4e668b5d52eed8026f5d717196b02b55fb2dc6:

  hwmon: (k10temp) Remove support for displaying voltage and current on Zen CPUs (2020-12-22 08:18:36 -0800)

----------------------------------------------------------------
hwmon patches for v5.11 (take 2)

The only patch in this series is removal of voltage and current reporting
for AMD Zen CPUs. Turns out that was not worth the trouble.

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (k10temp) Remove support for displaying voltage and current on Zen CPUs

 drivers/hwmon/k10temp.c | 98 -------------------------------------------------
 1 file changed, 98 deletions(-)
