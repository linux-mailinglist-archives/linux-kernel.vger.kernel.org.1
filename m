Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68514287C35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgJHTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:15:00 -0400
Received: from foss.arm.com ([217.140.110.172]:45306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgJHTPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:15:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845751063;
        Thu,  8 Oct 2020 12:14:59 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F167A3F70D;
        Thu,  8 Oct 2020 12:14:57 -0700 (PDT)
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
Subject: [PATCH v2 0/4] mailbox: arm_mhu: Add ARM MHU doorbell controller driver
Date:   Thu,  8 Oct 2020 20:14:48 +0100
Message-Id: <20201008191452.38672-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series adds ARM MHU doorbell controller driver based on the
discussion[1]. The DT patches are just repost from Viresh's last posting[2]

Regards,
Sudeep

v1[3]->v2:
	- No updates to binding patches(1-2)
	- Fixed memory leak and improved logic to find free channel reusing
	  mhu_db_mbox_to_channel as suggested by Jassi

[1] https://lore.kernel.org/r/20200909044618.deyx37pzocxiga7u@vireshk-i7
[2] https://lore.kernel.org/r/3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org
[3] https://lore.kernel.org/r/20200928114445.19689-1-sudeep.holla@arm.com

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
 drivers/mailbox/arm_mhu_db.c                  | 354 ++++++++++++++++++
 5 files changed, 493 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 drivers/mailbox/arm_mhu_db.c

-- 
2.17.1

