Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C002F5C01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbhANIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbhANIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:05:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6795239EB;
        Thu, 14 Jan 2021 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610611500;
        bh=2BuAo0SztALzq+4QXoe4fcw+TV6vLiGyckU2nh9AMTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jjq30fRkKJPCi+ynRJTUV5ICJEQ2ro4nM+gZnV6LVWKCVm7wH0aCG43HpNJLDbTIu
         29CBULsMZt5vJ8WIjm1V02BdSHW9uAVQw7ciAwdXOpyNlf5QeH3pK4EqRGLpvuOu94
         m7hLmGEi56bN7/YrZVae0BaKP6iu5w3kU56E3pCGDTVcUHNQmJ6Jl7X2yejSW5NOWg
         Go+qXcb+m6QzfM7y0NVzDvAUfp5m3thzuhdjRln1CT5UYWXPko379rDTpPqSgNdlWu
         ed6mOYq+HxOGOlMJY2Z+D8pp3Ym+RXCx4L8pcbZme6eRQLAfDM0CmUVrsOXlT2TlNQ
         N5TPgnoF4W9hQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxcn-00EQ6Y-Si; Thu, 14 Jan 2021 09:04:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/16] firmware: stratix10-svc: fix kernel-doc markups
Date:   Thu, 14 Jan 2021 09:04:41 +0100
Message-Id: <02a1eb47767e01e875d8840805b8b2d4f3c6bdee.1610610937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610937.git.mchehab+huawei@kernel.org>
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
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

Acked-by: Richard Gong <richard.gong@linux.intel.com>
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
2.29.2

