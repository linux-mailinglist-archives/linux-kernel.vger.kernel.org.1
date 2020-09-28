Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FE527AD17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgI1Loy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:44:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgI1Lox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:44:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2647C31B;
        Mon, 28 Sep 2020 04:44:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A00E3F6CF;
        Mon, 28 Sep 2020 04:44:51 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/4] mailbox: arm_mhu: Add ARM MHU doorbell controller driver
Date:   Mon, 28 Sep 2020 12:44:41 +0100
Message-Id: <20200928114445.19689-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series adds ARM MHU doorbell controller driver based on the
discussion[1]. The DT patches are just repost from Viresh's last posting[2]

Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20200909044618.deyx37pzocxiga7u@vireshk-i7
[2] https://lore.kernel.org/r/3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org


Sudeep Holla (3):
  dt-bindings: mailbox: add doorbell support to ARM MHU
  mailbox: arm_mhu: Match only if compatible is "arm,mhu"
  mailbox: arm_mhu: Add ARM MHU doorbell driver

Viresh Kumar (1):
  dt-bindings: mailbox : arm,mhu: Convert to Json-schema

 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 135 +++++++
 .../devicetree/bindings/mailbox/arm-mhu.txt   |  43 ---
 drivers/mailbox/Makefile                      |   2 +-
 drivers/mailbox/arm_mhu.c                     |   3 +
 drivers/mailbox/arm_mhu_db.c                  | 359 ++++++++++++++++++
 5 files changed, 498 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 drivers/mailbox/arm_mhu_db.c

-- 
2.17.1

