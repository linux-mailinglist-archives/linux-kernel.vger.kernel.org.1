Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D3210653
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgGAIdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgGAIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD7C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so17704277wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekub7s2tFsF3z7X9QKVOCDCBJvabEEOsb/caCUw91kQ=;
        b=I0+IsO52C/4NJYpfl8m/IBntVLbzAdmj3gkP5P5PJXB8/Saim87T6+YcBiC3vmRs57
         1wJzypc+icTMsZ+cM/Pp/3Fo1ctjfenxQy35Lc3eKjyZ5k4ui5Orx3oiNaQDqT1eSkYF
         wUpFaW9UH4j1lex2Y3aEHksXeFXBUxLQezUgiP674fzRTAsbcIiqB2qHgJNVAs5hHyAA
         4XZ/3JpRqHpXDFfKobyRd0CRegvepwRHm2gaUBbPcZbbsd6kSiXia800NJQn2dS6RGqL
         U5GnQzUvmdDX1m8MG3g9J7LxOvCe0++EVEvFLo1XzrIdpuy5zzkKyV/ORrGBTjGUICJZ
         lFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekub7s2tFsF3z7X9QKVOCDCBJvabEEOsb/caCUw91kQ=;
        b=gtRNRjOQzP+1bSKWck8b5aWjE+1okbnkHg04HPtHL1x3wKVejuPAVgUV2jBlx3Y5bW
         6xCGBqHzrdTWY+AC/an9OZ96SwVd52+kkwzz2zRYz+gEyHDevJ7gjqmkYNJByWVto2kd
         acyrOcXUacpHMlZ7cg1WYYYSCLC2oFcf2bjwkbEMvxuv07jDvoMYvzJgDarto++RR214
         bu/DLtAIn1MgJvhArx1+1BRlqfOypRK8YW+v8jtESwp7Lx4a+GlOxsNQ+gDQtrUYMhQ2
         FZD/6M6fGfdhxoRbWQ4tXBrtZJIDphXWRMKRdUEyDSmOp6nwaSQBd05CAtRYdlaEWUkU
         wrsA==
X-Gm-Message-State: AOAM530UZC012jhMz9Xxkd+ezCa8up44yM76LyGMj6DWJZbDUII+U8pN
        aNjQ15mbt6nzuph9zaLghc6FCA==
X-Google-Smtp-Source: ABdhPJxUfoJakEtvhmQ9MHxNkIDKqTQOWI8yjexeDr4WEy6us1/17Hj2srTxVjVz8cVJSxbvekeycQ==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr14228207wmc.117.1593592295900;
        Wed, 01 Jul 2020 01:31:35 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH v2 10/30] misc: ibmasm: dot_command: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:30:58 +0100
Message-Id: <20200701083118.45744-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/ibmasm/dot_command.c:18: warning: Function parameter or member 'sp' not described in 'ibmasm_receive_message'
 drivers/misc/ibmasm/dot_command.c:18: warning: Function parameter or member 'message' not described in 'ibmasm_receive_message'
 drivers/misc/ibmasm/dot_command.c:18: warning: Function parameter or member 'message_size' not described in 'ibmasm_receive_message'
 drivers/misc/ibmasm/dot_command.c:55: warning: Function parameter or member 'sp' not described in 'ibmasm_send_driver_vpd'
 drivers/misc/ibmasm/dot_command.c:111: warning: Function parameter or member 'sp' not described in 'ibmasm_send_os_state'
 drivers/misc/ibmasm/dot_command.c:111: warning: Function parameter or member 'os_state' not described in 'ibmasm_send_os_state'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/dot_command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmasm/dot_command.c b/drivers/misc/ibmasm/dot_command.c
index 70273a4cb3527..df389bd4c9df7 100644
--- a/drivers/misc/ibmasm/dot_command.c
+++ b/drivers/misc/ibmasm/dot_command.c
@@ -10,7 +10,7 @@
 #include "ibmasm.h"
 #include "dot_command.h"
 
-/**
+/*
  * Dispatch an incoming message to the specific handler for the message.
  * Called from interrupt context.
  */
@@ -48,7 +48,7 @@ void ibmasm_receive_message(struct service_processor *sp, void *message, int mes
 #define INIT_BUFFER_SIZE 32
 
 
-/**
+/*
  * send the 4.3.5.10 dot command (driver VPD) to the service processor
  */
 int ibmasm_send_driver_vpd(struct service_processor *sp)
@@ -99,7 +99,7 @@ struct os_state_command {
 	unsigned char			data;
 };
 
-/**
+/*
  * send the 4.3.6 dot command (os state) to the service processor
  * During driver init this function is called with os state "up".
  * This causes the service processor to start sending heartbeats the
-- 
2.25.1

