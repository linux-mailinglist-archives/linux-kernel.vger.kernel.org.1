Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD461B0FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDTPX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 11:23:29 -0400
Received: from foss.arm.com ([217.140.110.172]:50882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgDTPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:23:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFE0B31B;
        Mon, 20 Apr 2020 08:23:28 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 109163F73D;
        Mon, 20 Apr 2020 08:23:27 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 0/4] SCMI various fixes to Response handling code
Date:   Mon, 20 Apr 2020 16:23:11 +0100
Message-Id: <20200420152315.21008-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This serie bring a few fixes related to handling of responses in some
corner cases; renaming also .clear_notification() into clear_channel(),
being indeed a method of general utility not strictly related to
notifications. (and needed by these same fixes)

Based on scmi-next 5.7 [1], on top of:

commit a2fe63248225 ("firmware: arm_scmi: Fix return error code in
							smc_send_message")

[1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git


Cristian Marussi (4):
  firmware: arm_scmi: Rename .clear_notification() transport_ops
  firmware: arm_scmi: Clear channel on reception of unexpected responses
  firmware: arm_scmi: Clear channel for delayed responses
  firmware: arm_scmi: Fix handling of unexpected delayed responses

 drivers/firmware/arm_scmi/common.h  |  6 +++---
 drivers/firmware/arm_scmi/driver.c  | 26 ++++++++++++++++++++++----
 drivers/firmware/arm_scmi/mailbox.c |  6 +++---
 drivers/firmware/arm_scmi/shmem.c   |  2 +-
 4 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.17.1

