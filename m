Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF93C29EBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgJ2M1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:27:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6927 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2M1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:27:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMPpg4BnQz70Xn;
        Thu, 29 Oct 2020 20:27:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 20:27:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/4] clocksource/drivers/sp804: misc cleanup
Date:   Thu, 29 Oct 2020 20:33:13 +0800
Message-ID: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang (4):
  clocksource/drivers/sp804: Make some symbol static
  clocksource/drivers/sp804: Use clk_prepare_enable and
    clk_disable_unprepare
  clocksource/drivers/sp804: Correct clk_get_rate handle
  clocksource/drivers/sp804: Use pr_fmt

 drivers/clocksource/timer-sp804.c | 41 ++++++++++---------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

-- 
2.26.2

