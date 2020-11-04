Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655862A6E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgKDTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgKDTgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:11 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C86C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so3498811wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIlPaNy8+6SVoJoO4ZVb88BpkxEebVHAZHuNRUrqyUw=;
        b=Jhqqa2LzDSukPj9LW74QxWz9s/ZxSkic1kQDmHtf6J+/wT+EvuKE5GiM3/FUZYYUA/
         B65Rk9z8HCY0qALSkuFJzBx2GSF7z74YaxsiqN0D4Dvj5FHotOO0LXuVS/9/CSHmfstg
         PMp5Lx1ZxhgrTWfwjmsHVTdXjfo32kajvGnUiKMbig7IayIE3pJjy+Hjds0R+SmCypDV
         FvmwIXgDuGYMAFuzB81DjZPXz5CPVbv9fa2ZbMG/tD+Sy0gTW/m9vA/xQJAW/SjkX5Dz
         cpws0LFWeqdjEKCOkPUzG1frh+eO7hCt1grT5OIq+72untM9vozIaij5jFKrzbF1L2tH
         T60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIlPaNy8+6SVoJoO4ZVb88BpkxEebVHAZHuNRUrqyUw=;
        b=Du2hd5Clv7l2AzwSV8mB4g9gL4GUVZ2cVwu/WGU8vsge7twrhuNTR+A6YOI2Ep1Fum
         lbwFvSCXk4Zd3xMFbGazHVc64IfuNJKQU+RQM+fuhfFENg2x1IjIfY3FidwQZkfcTIlm
         O0IoCtYPCY1Rx3L3FKDkdakhqV9y9rdlChkVzaJ2h0SxmRGkdZl/PP8b2zXAmGGoC15s
         NERyUKpBFHDuTFGKj7RQCju3N1MxNfGfYKsbB5eDkvlDfghXq+LUTawcsIkqr6R14DAa
         rsDtHTvrRNzLmjLcCT8WTBLlLve8+d814Y1mBO+0EzTEcCB1bYw+I0Ur9aTNkglGgNbf
         zBkA==
X-Gm-Message-State: AOAM532T7J/s8UwwYrqKEtlFzQVGBEGnL/Fob/Yf6QmffCcEPSy1kyyj
        sy3JN2Tz30GDB7Zvys9vcZVwsg==
X-Google-Smtp-Source: ABdhPJwpY/hfw7mfgA6zAbuTaa1w+/DKNnEbH9/YUlYajtlgI1G1zJsIYHUdpgYlYnVqKIkqG1z/hg==
X-Received: by 2002:a1c:6043:: with SMTP id u64mr6069151wmb.166.1604518569469;
        Wed, 04 Nov 2020 11:36:09 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 07/36] tty: tty_jobctrl: Add missing function parameter descriptions
Date:   Wed,  4 Nov 2020 19:35:20 +0000
Message-Id: <20201104193549.4026187-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_jobctrl.c:32: warning: Function parameter or member 'sig' not described in '__tty_check_change'
 drivers/tty/tty_jobctrl.c:95: warning: Function parameter or member 'tty' not described in '__proc_set_tty'
 drivers/tty/tty_jobctrl.c:344: warning: Function parameter or member 'file' not described in 'tiocsctty'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_jobctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 28a23a0fef21c..2054e4164c660 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -21,6 +21,7 @@ static int is_ignored(int sig)
 /**
  *	tty_check_change	-	check for POSIX terminal changes
  *	@tty: tty to check
+ *	@sig: signal to send
  *
  *	If we try to write to, or set the state of, a terminal and we're
  *	not in the foreground, send a SIGTTOU.  If the signal is blocked or
@@ -83,6 +84,7 @@ void proc_clear_tty(struct task_struct *p)
 
 /**
  * proc_set_tty -  set the controlling terminal
+ *	@tty: tty structure
  *
  * Only callable by the session leader and only if it does not already have
  * a controlling terminal.
@@ -330,6 +332,7 @@ void no_tty(void)
 /**
  *	tiocsctty	-	set controlling tty
  *	@tty: tty structure
+ *	@file: file structure used to check permissions
  *	@arg: user argument
  *
  *	This ioctl is used to manage job control. It permits a session
-- 
2.25.1

