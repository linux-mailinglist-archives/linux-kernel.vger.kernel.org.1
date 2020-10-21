Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4EF294649
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 03:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411079AbgJUBXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 21:23:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411051AbgJUBXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 21:23:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C88D4E4F19FE5078B012;
        Wed, 21 Oct 2020 09:23:53 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 09:23:47 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kbuild-all <kbuild-all@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] clocksource: sp804: add static for functions such as sp804_clockevents_init()
Date:   Wed, 21 Oct 2020 09:22:58 +0800
Message-ID: <20201021012259.2067-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
Add warning information into the description of this patch.  And correct
the commit-id of "Fixes:", the old one is come from linux-next, but it's
changed when merged into v5.10-rc1.


Zhen Lei (1):
  clocksource: sp804: add static for functions such as
    sp804_clockevents_init()

 drivers/clocksource/timer-sp804.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.3


