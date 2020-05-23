Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B11DF86C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgEWRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 13:09:07 -0400
Received: from foss.arm.com ([217.140.110.172]:52930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387977AbgEWRJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:09:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56901FB;
        Sat, 23 May 2020 10:09:06 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B8823F305;
        Sat, 23 May 2020 10:09:06 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/8] soc: Use custom soc attribute group and DEVICE_ATTR_RO
Date:   Sat, 23 May 2020 18:08:51 +0100
Message-Id: <20200523170859.50003-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While trying to add SMCCC based SOC_ID support, I found the custom soc
attribute group which had no users in the tree and check if it can be
used or can be removed. I realised that it could clean up the custom
attributes that are added using device_create_file today.

Regards,
Sudeep

Sudeep Holla (8):
  soc: realview: Switch to use DEVICE_ATTR_RO()
  soc: realview: Use custom soc attribute group instead of device_create_file
  soc: integrator: Switch to use DEVICE_ATTR_RO()
  soc: integrator: Use custom soc attribute group instead of device_create_file
  soc: ux500: Switch to use DEVICE_ATTR_RO()
  soc: ux500: Use custom soc attribute group instead of device_create_file
  ARM: OMAP2: Switch to use DEVICE_ATTR_RO()
  ARM: OMAP2: Use custom soc attribute group instead of device_create_file

 arch/arm/mach-omap2/id.c               | 20 ++++++-----
 drivers/soc/ux500/ux500-soc-id.c       | 22 ++++++------
 drivers/soc/versatile/soc-integrator.c | 48 ++++++++++++--------------
 drivers/soc/versatile/soc-realview.c   | 48 ++++++++++++--------------
 4 files changed, 69 insertions(+), 69 deletions(-)

--
2.17.1

