Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB091F3923
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgFILLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 07:11:19 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:10166 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728891AbgFILLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:11:13 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jun 2020 04:11:04 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 09 Jun 2020 04:11:02 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id A9CE021810; Tue,  9 Jun 2020 16:41:00 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        peter.ujfalusi@ti.com, sivaprak@codeaurora.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] Fix issues related to register access in IPQ NAND
Date:   Tue,  9 Jun 2020 16:40:54 +0530
Message-Id: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1: avoids register write to unavailable SFLASHC_BURST_CFG register
Patch 2: set BAM mode only if not set by bootloader

[V2]
 * As per review comments from Miquèl split the original patch into two
   addressing independent issues.  

Sivaprakash Murugesan (2):
  mtd: rawnand: qcom: remove write to unavailable register
  mtd: rawnand: qcom: set BAM mode only if not set already

 drivers/mtd/nand/raw/qcom_nandc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.7.4

