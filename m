Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADF2B2ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 03:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgKNCQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 21:16:04 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:34598 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKNCQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 21:16:03 -0500
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 21:16:03 EST
Received: from CMGW (unknown [10.9.0.13])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 74146215D9A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 18:51:13 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id dkiekipKri1lMdkifkjRLj; Fri, 13 Nov 2020 18:51:13 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=RKzDJ8q+ c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=nNwsprhYR40A:10 a=evQFzbml-YQA:10
 a=VwQbUJbxAAAA:8 a=wBqY6jgYEW0BGQsa698A:9 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZgDKlMPjpd9wyV6iWCzRhHgPc4WOdicWTvdhxomrLcs=; b=Hp7NfLlQ4aBt807E1OVJTriJrn
        pkqtvAwvauw8VOg7x9L3FLPPMTOBlhbOUjE1H+ng/8t5Ujez/ABwvvMpWI3EECz7sTB6LGvSpQnRX
        95qVWt9naySUC3UIKztu4olOJdFwsCfqNVjdF0ayQqUYD7sLnRA8K+CfIJI36lpymPMkPUTydrgB1
        8/+ZuOLN3DMODuNy6iwI631ysRDrjWOHYU5+YzZiFAhuD2t/YUiUpKEbGb9IJPU5WA91tjyvaQNs6
        B4Gxisk/IbgP19H0SVbV4aKp3StTMyKV5ZtYGlnTNSUp53iK+kbRu1o3pN3U0WYpHLvan9xQ3hYW8
        TebVuquQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55376 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kdkie-0032Zd-GW; Sat, 14 Nov 2020 01:51:12 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.10-rc4
Date:   Fri, 13 Nov 2020 17:51:11 -0800
Message-Id: <20201114015111.55792-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kdkie-0032Zd-GW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:55376
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.10-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.10-rc4

Thanks,
Guenter
------

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.10-rc4

for you to fetch changes up to 60268b0e8258fdea9a3c9f4b51e161c123571db3:

  hwmon: (amd_energy) modify the visibility of the counters (2020-11-13 06:46:20 -0800)

----------------------------------------------------------------
hwmon fixes for v5.10-rc4

Fix potential bufer overflow in pmbus/max20730 driver
Fix locking issue in pmbus core
Fix regression causing timeouts in applesmc driver
Fix RPM calculation in pwm-fan driver
Restrict counter visibility in amd_energy driver

----------------------------------------------------------------
Brad Campbell (1):
      hwmon: (applesmc) Re-work SMC comms

Dan Carpenter (1):
      hwmon: (pmbus/max20730) use scnprintf() instead of snprintf()

Naveen Krishna Chatradhi (1):
      hwmon: (amd_energy) modify the visibility of the counters

Paul Barker (1):
      hwmon: (pwm-fan) Fix RPM calculation

Robert Hancock (1):
      hwmon: (pmbus) Add mutex locking for sysfs reads

 drivers/hwmon/amd_energy.c       |   2 +-
 drivers/hwmon/applesmc.c         | 130 ++++++++++++++++++++++++---------------
 drivers/hwmon/pmbus/max20730.c   |  26 ++++----
 drivers/hwmon/pmbus/pmbus_core.c |  13 +++-
 drivers/hwmon/pwm-fan.c          |  16 ++---
 5 files changed, 115 insertions(+), 72 deletions(-)
