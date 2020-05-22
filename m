Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C329D1DE721
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgEVMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 08:50:01 -0400
Received: from foss.arm.com ([217.140.110.172]:34882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgEVMuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:50:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D92A555D;
        Fri, 22 May 2020 05:50:00 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99A583F68F;
        Fri, 22 May 2020 05:49:59 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] base: soc: Add JEP106 manufacturer's identification code
Date:   Fri, 22 May 2020 13:49:49 +0100
Message-Id: <20200522124951.35776-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While attempting to add custom sysfs attributes for SMCCC ARCH_SOC_ID
Arnd suggested to make it generic. Here is my first attempt.

The original thread/discussion can be found here[1]

Regards,
Sudeep

[1] https://lore.kernel.org/r/CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com/

Sudeep Holla (2):
  base: soc: Add JEDEC JEP106 manufacturer's identification code attribute
  firmware: smccc: Add ARCH_SOC_ID support

 Documentation/ABI/testing/sysfs-devices-soc |  31 ++++++
 drivers/base/soc.c                          |  12 +++
 drivers/firmware/smccc/Kconfig              |   9 ++
 drivers/firmware/smccc/Makefile             |   1 +
 drivers/firmware/smccc/soc_id.c             | 113 ++++++++++++++++++++
 include/linux/arm-smccc.h                   |   5 +
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 172 insertions(+)
 create mode 100644 drivers/firmware/smccc/soc_id.c

-- 
2.17.1

