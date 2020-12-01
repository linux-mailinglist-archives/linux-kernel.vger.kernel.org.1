Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF02CA23F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbgLAMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388698AbgLAMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:53 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C70322240;
        Tue,  1 Dec 2020 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824556;
        bh=nxBKhpfeUZi4hUNMKamrg97JKUCVJauTqRgTC15uA18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gFm7wVcCVA+3miFH+4wbpNfJPHe2eiXorN3VAknnUKM4VPiQTg/+eQVDhvAflM0ES
         6GtX1Zao4AJ1lmbaRLQ83TBQoAYk/kOUE5K+XxQZkMX96ubeAYwI0tFQkjc0OIyaHf
         Nl3Hmv/lXOkK7LmtGNkr/xBnJzjWx/iI0/G1lkNQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdA-38; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/16] firmware: stratix10-svc: fix kernel-doc markups
Date:   Tue,  1 Dec 2020 13:09:01 +0100
Message-Id: <782cd7c67056b1085c968b465cdbbdbdc2a5f7d3.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
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
@@ -1,93 +1,93 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2017-2018, Intel Corporation
  */
 
 #ifndef __STRATIX10_SVC_CLIENT_H
 #define __STRATIX10_SVC_CLIENT_H
 
-/**
+/*
  * Service layer driver supports client names
  *
  * fpga: for FPGA configuration
  * rsu: for remote status update
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 
-/**
+/*
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
  * Secure firmware accepts the request issued by one of service clients.
  *
  * SVC_STATUS_BUFFER_SUBMITTED:
  * Service client successfully submits data buffer to secure firmware.
  *
  * SVC_STATUS_BUFFER_DONE:
  * Secure firmware completes data process, ready to accept the
  * next WRITE transaction.
  *
  * SVC_STATUS_COMPLETED:
  * Secure firmware completes service request successfully. In case of
  * FPGA configuration, FPGA should be in user mode.
  *
  * SVC_COMMAND_STATUS_BUSY:
  * Service request is still in process.
  *
  * SVC_COMMAND_STATUS_ERROR:
  * Error encountered during the process of the service request.
  *
  * SVC_STATUS_NO_SUPPORT:
  * Secure firmware doesn't support requested features such as RSU retry
  * or RSU notify.
  */
 #define SVC_STATUS_OK			0
 #define SVC_STATUS_BUFFER_SUBMITTED	1
 #define SVC_STATUS_BUFFER_DONE		2
 #define SVC_STATUS_COMPLETED		3
 #define SVC_STATUS_BUSY			4
 #define SVC_STATUS_ERROR		5
 #define SVC_STATUS_NO_SUPPORT		6
 
-/**
+/*
  * Flag bit for COMMAND_RECONFIG
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
  * Set to FPGA configuration type (full or partial).
  */
 #define COMMAND_RECONFIG_FLAG_PARTIAL	1
 
-/**
+/*
  * Timeout settings for service clients:
  * timeout value used in Stratix10 FPGA manager driver.
  * timeout value used in RSU driver
  */
 #define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
 #define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 
 struct stratix10_svc_chan;
 
 /**
  * enum stratix10_svc_command_code - supported service commands
  *
  * @COMMAND_NOOP: do 'dummy' request for integration/debug/trouble-shooting
  *
  * @COMMAND_RECONFIG: ask for FPGA configuration preparation, return status
  * is SVC_STATUS_OK
  *
  * @COMMAND_RECONFIG_DATA_SUBMIT: submit buffer(s) of bit-stream data for the
  * FPGA configuration, return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
  *
  * @COMMAND_RECONFIG_DATA_CLAIM: check the status of the configuration, return
  * status is SVC_STATUS_COMPLETED, or SVC_STATUS_BUSY, or SVC_STATUS_ERROR
  *
  * @COMMAND_RECONFIG_STATUS: check the status of the configuration, return
  * status is SVC_STATUS_COMPLETED, or SVC_STATUS_BUSY, or SVC_STATUS_ERROR
  *
  * @COMMAND_RSU_STATUS: request remote system update boot log, return status
  * is log data or SVC_STATUS_RSU_ERROR
  *
  * @COMMAND_RSU_UPDATE: set the offset of the bitstream to boot after reboot,
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
@@ -189,42 +189,42 @@ void stratix10_svc_free_channel(struct stratix10_svc_chan *chan);
 /**
  * stratix10_svc_allocate_memory() - allocate the momory
  * @chan: service channel assigned to the client
  * @size: number of bytes client requests
  *
  * Service layer allocates the requested number of bytes from the memory
  * pool for the client.
  *
  * Return: the starting address of allocated memory on success, or
  * ERR_PTR() on error.
  */
 void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 				    size_t size);
 
 /**
  * stratix10_svc_free_memory() - free allocated memory
  * @chan: service channel assigned to the client
  * @kaddr: starting address of memory to be free back to pool
  */
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr);
 
 /**
  * stratix10_svc_send() - send a message to the remote
  * @chan: service channel assigned to the client
  * @msg: message data to be sent, in the format of
  * struct stratix10_svc_client_msg
  *
  * Return: 0 for success, -ENOMEM or -ENOBUFS on error.
  */
 int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg);
 
 /**
- * intel_svc_done() - complete service request
+ * stratix10_svc_done() - complete service request
  * @chan: service channel assigned to the client
  *
  * This function is used by service client to inform service layer that
  * client's service requests are completed, or there is an error in the
  * request process.
  */
 void stratix10_svc_done(struct stratix10_svc_chan *chan);
 #endif
 
-- 
2.28.0

