Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B331210650
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgGAIbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 04:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgGAIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72AC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so22899206wrn.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJS/keN17J0QH5GuMuvB98PgdVtEKXtUDk7tuwa3qBk=;
        b=UoNm1D5TufX8B+t8ssXSDq8eKZlkPzJtDurcv1/Rr3Ye8pXB95M+gpBS/8nBdnAzk+
         /a/3xutZ9yo23C8dyFYoMpvokPD/XiS/fqBv6M6B2t9+TpBgpuICvsZO+9sG5YvzMvmv
         4xMbJPLTy1HTTy9hS95xNDZQxKjy3RQqvijocE4GDAByZOgKuTlpcHPr9ixhdf5f34u8
         tTRPA3tucd1s9Br/pPXSD1IhyMFIkxNT54ybfEs2J8kAkMDKq62w9MbMLCLueGYB5SNG
         RiYJqygKRH7CM2uxGr8CwuS/eHzLiJa9g3eUtU8q1EJ93zGug5y2U2EXJzZ1VT99dskV
         GAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJS/keN17J0QH5GuMuvB98PgdVtEKXtUDk7tuwa3qBk=;
        b=FRqFpBhxB45xVUFUifqz2VM4jWIiXhzCZanezyae0YwOtwtgUiJx5wXC4ky18qIEJ1
         UPVpKzq2SEPDWKjiXBoOzFWuMkXHW+nk8+tBZSN2mAlGSLs/eXaR3zZ0aLld3HYj3AWw
         W1LJ2SO2RFDSLYJcU2kMa6xwuw8A3KMsN8FPVAOCfpnoFlL+TZkjvpLjGgQYxfbpYfEx
         KAWm/XrINMCws3Ki/YTfjigHJoTV7gowi9S4tqG8g/p866SxL5pkvG/hgO4SWE1MymQ7
         ligIyScu6Y6cwcQDM3rmZFjbqaW95vWie9WRi+iPYzEwHdh58ADRvjKe85gpPJLExuez
         DKow==
X-Gm-Message-State: AOAM53203tdGfVOrykkSNVHXcCkp8zTcqEcIuLJehVozk42PDhqPUjn9
        h5OOk6cGMobTEu7k6oiQjWj8xA==
X-Google-Smtp-Source: ABdhPJyXfPWH9EIRAdDMw4b75QwoN0j6lUU72/VPx0euMYQS+BSTnPLWGJjZ7rL/S5wu85HGWfNtaQ==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr27436961wru.182.1593592291305;
        Wed, 01 Jul 2020 01:31:31 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH v2 06/30] misc: ibmasm: command: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:30:54 +0100
Message-Id: <20200701083118.45744-7-lee.jones@linaro.org>
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

 drivers/misc/ibmasm/command.c:106: warning: Function parameter or member 'sp' not described in 'ibmasm_exec_command'
 drivers/misc/ibmasm/command.c:106: warning: Function parameter or member 'cmd' not described in 'ibmasm_exec_command'
 drivers/misc/ibmasm/command.c:149: warning: Function parameter or member 'cmd' not described in 'ibmasm_wait_for_response'
 drivers/misc/ibmasm/command.c:149: warning: Function parameter or member 'timeout' not described in 'ibmasm_wait_for_response'
 drivers/misc/ibmasm/command.c:162: warning: Function parameter or member 'sp' not described in 'ibmasm_receive_command_response'
 drivers/misc/ibmasm/command.c:162: warning: Function parameter or member 'response' not described in 'ibmasm_receive_command_response'
 drivers/misc/ibmasm/command.c:162: warning: Function parameter or member 'size' not described in 'ibmasm_receive_command_response'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmasm/command.c b/drivers/misc/ibmasm/command.c
index 2863657fa2683..733dd30fbaccf 100644
--- a/drivers/misc/ibmasm/command.c
+++ b/drivers/misc/ibmasm/command.c
@@ -94,7 +94,7 @@ static inline void do_exec_command(struct service_processor *sp)
 	}
 }
 
-/**
+/*
  * exec_command
  * send a command to a service processor
  * Commands are executed sequentially. One command (sp->current_command)
@@ -140,7 +140,7 @@ static void exec_next_command(struct service_processor *sp)
 	}
 }
 
-/**
+/*
  * Sleep until a command has failed or a response has been received
  * and the command status been updated by the interrupt handler.
  * (see receive_response).
@@ -153,7 +153,7 @@ void ibmasm_wait_for_response(struct command *cmd, int timeout)
 				timeout * HZ);
 }
 
-/**
+/*
  * receive_command_response
  * called by the interrupt handler when a dot command of type command_response
  * was received.
-- 
2.25.1

