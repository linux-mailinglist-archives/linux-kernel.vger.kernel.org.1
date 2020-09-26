Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68943279CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgIZVcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 17:32:46 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:11972 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIZVcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:42 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzMSm1nTkz18;
        Sat, 26 Sep 2020 23:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601155960; bh=4nuv8XtB2YUIErRfKrjMiu/Ium1RTTq3SbR5a+DzgTE=;
        h=Date:From:Subject:To:Cc:From;
        b=LVdmkTfwEwCfUb1cXr2vpnhkekLIJleOnOIntcWmKMjG08Sevx0tDSwL4/dzZEnJK
         nNTGemIg8VXaI6GvSTCcFbuy2uDQG06Bcv52NElm5lS3CfqH1pUyggZqrFLw7TXgdk
         MUWg+riM14UCtIflaAciLg4jZUtEuJjHNaW/8gFzf+CqhbVXdHpwAWFWuE/KEEf79/
         xOaU0Z+pzOSWsuUeo0grV2Xik3nQRSVyuG+wvD3tcfWvgm/C9lWAL59hpgTAiDNvJV
         cdsPuBaDiQTBinbuvdd/b929itORaH4ESY6KxP7sGksZngvyjCEIugu+uBXDYYr7o/
         w2XZYkn7DtH9w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 23:32:36 +0200
Message-Id: <cover.1601155770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/3] regulator: debugging aids
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three simple patches to aid in debugging regulators.

Michał Mirosław (3):
  regulator: print state at boot
  regulator: print symbolic errors in kernel messages
  regulator: resolve supply after creating regulator

 drivers/regulator/core.c | 124 ++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 55 deletions(-)

-- 
2.20.1

