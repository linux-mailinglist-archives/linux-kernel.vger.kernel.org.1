Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654562D0CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgLGJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:16:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44332 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgLGJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:16:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id d20so16971574lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yzz+c1dc80yrOAWf82TOTxEmTIR++Gp2BWbJshPob+Y=;
        b=abZsZhOOWgUKLq2feYv5EIrq/PlBr8y99S8fycomGL3j02nE0zhkF+QvWtxmPnQySd
         70ohIQEoem5sabqSLxc7W5eTOzuADjBDqzWCpPmyzUFoMxUFD0LWgFPnR3V5yl+jFV1T
         lYhmAqQFnItRsDGyrpCzuWbRFYqy57NfypXDDhL7JKRyoih9rCZb1MVK3QjV2Y5xtp0g
         Hq4lOVtr7csodHd3zXNNCEP4gUDi/qu6Nb83vKggWC7R5C5+E0bp71B8x1c+JqX5M03I
         /xjmHgpi+TbzxmXbBzKlmZ5HMvYI9OV9c5+q/X6xd+/t8pwCNRJzhOeObl2mjouYUWQd
         fa9A==
X-Gm-Message-State: AOAM533wOS/xvVZUqUFne281LcqjnK5fDz66qaJJ1XPi3SBlPNLPGPlk
        DKEnT1d0VAsP4LjnI8+83HoE4+8rdGyxiw==
X-Google-Smtp-Source: ABdhPJyOnJ/tdMMsl+2nS3b/Zu02lBeZgZ3sj5KilWZtPH01g0hKProuC3gup+lEkbsub5MaRBCH0Q==
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr7650760lff.174.1607332547225;
        Mon, 07 Dec 2020 01:15:47 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i9sm3009516lja.56.2020.12.07.01.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:15:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kmCd3-0001Md-LR; Mon, 07 Dec 2020 10:16:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] earlycon: drop semicolon from earlycon macro
Date:   Mon,  7 Dec 2020 10:16:01 +0100
Message-Id: <20201207091601.5202-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the trailing semicolon from the OF_EARLYCON_DECLARE() macro
definition which was left when removing the array-of-pointer
indirection.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3e32b788c28d..e1b684e33841 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -372,7 +372,7 @@ extern const struct earlycon_id __earlycon_table_end[];
 		__aligned(__alignof__(struct earlycon_id))		\
 		= { .name = __stringify(_name),				\
 		    .compatible = compat,				\
-		    .setup = fn };
+		    .setup = fn }
 
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
-- 
2.26.2

