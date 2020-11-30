Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1922C8456
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgK3MuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgK3MuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:50:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06FC0613D2;
        Mon, 30 Nov 2020 04:49:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so16053552wrc.8;
        Mon, 30 Nov 2020 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XgjnfGL7fhRwAvNQvTlzfgUXxKtKFm+93Zmvk2qerpQ=;
        b=O9JXaJ1jDppA2obNDIfK25wfvYo3KGPkTt0LZTy6DcZU3ryV3Lxa4PbeyvrpFUpJk1
         OOrlg575a6kEMInbh3kIDz0gyGve5ZTsGP/gnvZsbHGGxInfxyuWoBrLzqRyYgDu2IyI
         +OjRYRxZInnaIN8pIJQXsU0ExcGAgVuvjAwzrKbS7oWq63AdOXu7luK46KcucfSeG6uM
         rnFwzQ0EqtTBltqC9S8KrSSF1+LRFGti8J0ZDxaBMARp6XjlVjLg92etMPbOf+GpfnTW
         WaVMCapmssyLBTc7Cm+HYdBj3BGLBjeE/Fz3gG7BSCCrCanQceTIFE0bs0K9H8+ReGvn
         +qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XgjnfGL7fhRwAvNQvTlzfgUXxKtKFm+93Zmvk2qerpQ=;
        b=C39Ccbbu3rFLGmT9rVfk3lPwZ8pjgtJE4JfrwoOlsBpp0YNvoM68F06/pn5kQGKdZB
         R3FckB2VDhlbIvrsXix/qAUqIrHLUiBCXjmhbv118C2AttBtCXaIUNIpSypJ6GCEV4bM
         sb7bIF7oP3hNZ2u0+LH6rP96H2Mjc17cz+XDMUbI0yW7sbBE73vN+OlIWg1+cB3gqqCm
         7IWqXAiTksW2MRQ2ut8rtlkd1LsTRB4d5DgXV+L3qa4iLF3ZPbfcJSi/Aema21XFlEOV
         5NDr6oaDsg6EyObh7M56tZ08acnbZyPeJD1oAap7wPPJrbzYVmXe3nas6zftKhveLzZ3
         BC7A==
X-Gm-Message-State: AOAM532fQQKOYuIdD3CjxqwC6mtC4fiKZ5AEU4eDASwQhu1ddQpWyN7J
        Utl2tmLHdtKNemK8X1FBfCo=
X-Google-Smtp-Source: ABdhPJxM4TlVkMpABcEDR1NbWu/p2BJ3zySpGa1lfl1C+p3MsU9fPZtsCLlJcirx2aXVoCo5MQk4/g==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr27218012wrq.416.1606740567358;
        Mon, 30 Nov 2020 04:49:27 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4c:d300:8813:e95a:c6db:aa09])
        by smtp.gmail.com with ESMTPSA id n4sm24474781wmc.30.2020.11.30.04.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:49:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] printk: remove obsolete dead assignment
Date:   Mon, 30 Nov 2020 13:49:15 +0100
Message-Id: <20201130124915.7573-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 849f3127bb46 ("switch /dev/kmsg to ->write_iter()") refactored
devkmsg_write() and left over a dead assignment on the variable 'len'.

Hence, make clang-analyzer warns:

  kernel/printk/printk.c:744:4: warning: Value stored to 'len' is never read
    [clang-analyzer-deadcode.DeadStores]
                          len -= endp - line;
                          ^

Simply remove this obsolete dead assignment here.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201130

Petr, please pick this minor non-urgent clean-up patch.

 kernel/printk/printk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f279d4fbd9dd..6e4e38b7cd91 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -741,7 +741,6 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 			if (LOG_FACILITY(u) != 0)
 				facility = LOG_FACILITY(u);
 			endp++;
-			len -= endp - line;
 			line = endp;
 		}
 	}
-- 
2.17.1

