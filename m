Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD9290FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436800AbgJQF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:58:14 -0400
Received: from z5.mailgun.us ([104.130.96.5]:19564 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436763AbgJQF6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:58:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602914294; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=O39GHa5Zc7YYi6xk0MgUGMyJ7D1ZYO+P8ngBtf0mzWU=; b=LPaxnwnW+8p7cau0WW5/01YfetRb5f2berm9wtC5Ip73KmJJ4fuDh7fOj7yyigInGvui6Sad
 4KeVeOvEtYyRAYqp6nvU0JBlXc24LpcaRdVl9sPl9tDiLTWNJJKQBgxUzfmVkSilC9y4tHaR
 YIwGNql69VWeTuql6qi5662PEiY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f8a50c44f8cc67c31616dbc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Oct 2020 02:02:44
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6ADEEC433CB; Sat, 17 Oct 2020 02:02:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-014.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6313C433C9;
        Sat, 17 Oct 2020 02:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6313C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sudaraja@codeaurora.org
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Subject: [PATCH 0/2] mm/memory_hotplug, arm64: allow certain bootmem sections to be offlinable
Date:   Fri, 16 Oct 2020 19:02:22 -0700
Message-Id: <cover.1602899443.git.sudaraja@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch that enables memory hot-remove (commit bbd6ec605c0f ("arm64/mm: Enable memory hot remove")) for arm64, there’s a notifier put in place that prevents boot memory from being offlined and removed. The commit text mentions that boot memory on arm64 cannot be removed. But x86 and other archs doesn’t seem to do this prevention.

The current logic is that only “new” memory blocks which are hot-added can later be offlined and removed. The memory that system booted up with cannot be offlined and removed. But there could be many usercases such as inter-VM memory sharing where a primary VM could offline and hot-remove a block/section of memory and lend it to secondary VM where it could hot-add it. And after usecase is done, the reverse happens where secondary VM hot-removes and gives it back to primary which can hot-add it back. In such cases, the present logic for arm64 doesn’t allow this hot-remove in primary to happen.

Also, on systems with movable zone that sort of guarantees pages to be migrated and isolated so that blocks can be offlined, this logic also defeats the purpose of having a movable zone which system can rely on memory hot-plugging, which say virt-io mem also relies on for fully plugged memory blocks.

This patch tries to solve by introducing a new section mem map sit 'SECTION_MARK_HOTPLUGGABLE' which allows the concerned module drivers be able
to mark requried sections as "hotpluggable" by setting this bit. Also this marking is only allowed for sections which are in movable zone and have unmovable pages. The arm64 mmu code on receiving the MEM_GOING_OFFLINE notification, we disallow offlining of any boot memory by checking if section_early or not. With the introduction of SECTION_MARK_HOTPLUGGABLE, we allow boot mem sections that are marked as hotpluggable with this bit set to be offlined and removed. Thereby allowing required bootmem sections to be offlinable.

Sudarshan Rajagopalan (2):
  mm/memory_hotplug: allow marking of memory sections as hotpluggable
  arm64: allow hotpluggable sections to be offlined

 arch/arm64/mm/mmu.c            |  2 +-
 include/linux/memory_hotplug.h |  1 +
 include/linux/mmzone.h         |  9 ++++++++-
 mm/memory_hotplug.c            | 20 ++++++++++++++++++++
 mm/sparse.c                    | 31 +++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 2 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

