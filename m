Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EDA297478
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbgJWQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63BC7246B7;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=cAV8X3oa0XUZKfbLmepFYYM7Z9KJI8I1jdNzSxjcxEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Slrz+HybebCdFghNwDfZudtZHninKj5JJfVzYitTuVw/rvldBw5VKvTsYdhfrY2bF
         VsIrjGt0uwuY4/Dm/hmFS9HnlrJhAVHsk+NWRBMfUTh31BCeJN9i02aSO0mxlDLmex
         qBSoeBMBJ76JjUSARCCcudUCqEan9yqHEKjV61bk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxB-CF; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 40/56] firmware: stratix10-svc: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:27 +0200
Message-Id: <f417f0605346b2d72b1a7f5b3989c9aca29729df.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some common comments marked, instead, with kernel-doc
notation, which won't work.

While here, rename an identifier, in order to match the
function prototype below kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/firmware/intel/stratix10-svc-client.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index a93d85932eb9..ebc295647581 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -6,7 +6,7 @@
 #ifndef __STRATIX10_SVC_CLIENT_H
 #define __STRATIX10_SVC_CLIENT_H
 
-/**
+/*
  * Service layer driver supports client names
  *
  * fpga: for FPGA configuration
@@ -15,7 +15,7 @@
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 
-/**
+/*
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
@@ -50,7 +50,7 @@
 #define SVC_STATUS_ERROR		5
 #define SVC_STATUS_NO_SUPPORT		6
 
-/**
+/*
  * Flag bit for COMMAND_RECONFIG
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
@@ -58,7 +58,7 @@
  */
 #define COMMAND_RECONFIG_FLAG_PARTIAL	1
 
-/**
+/*
  * Timeout settings for service clients:
  * timeout value used in Stratix10 FPGA manager driver.
  * timeout value used in RSU driver
@@ -218,7 +218,7 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr);
 int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg);
 
 /**
- * intel_svc_done() - complete service request
+ * stratix10_svc_done() - complete service request
  * @chan: service channel assigned to the client
  *
  * This function is used by service client to inform service layer that
-- 
2.26.2

