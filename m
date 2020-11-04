Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01962A6E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgKDTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbgKDTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E596C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k18so3414983wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9M944/NlU6g0VABGcN95F3i6ZBprqdeylG2meavDxjY=;
        b=m1YJ2vUpj2G4tTit7Re7+/xtvcqXVxQccAg95PkmMFDkZJL2+LUy9aRVj8ulCKh5e8
         8te2XIlrtaJ2eJUr9KtsPNO2lmU1HgneHydPFaBYS3/B74Ec9RgcEEYq5nd6Pv2hEdo8
         WN/0r7O5HBgGH8H88p7tOxiJbJNL/MXCvkU88v43QNilQL8MIwJWuKx8TJDO8VpHL7jo
         NM/0fwfMQ0gvnGVZlogNoZ1bjJJdZIRjXLJtIy8jpp3/mQ6Rh03KiBmWmwfaGFmA65pa
         WAKW64mvP/L5x3eKbztWRuWX7P4PFT4UBgssT5PsJ6sLOSw0eeJVYYYXfEP0i8zLvDJE
         GmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9M944/NlU6g0VABGcN95F3i6ZBprqdeylG2meavDxjY=;
        b=BGmFzfeGxi7rUzP9sdHtjEUHaiBgzcrW/t2J29R6N1LY2mR62NU5iIX5fuW2KapM3s
         djLYdCkFDSNWSpcyrBojtpHyEJG8VX2mDMcdCpxCk22YyhuvcyQzujWviIAeOo8UaXg1
         esnHS0P8JOKPAvV3pu2Hb3Z4AdYrxdgcFylBiMmmCGq0jVNZ0yyzQPpNs06XFlYnHdek
         piqFv/6QYP1revMf0FkUY2YbVfwdXoezjBpscpsdwK7uLNxckHzcVKut2nxPHVpsbO8R
         tJ1kceh9UwjTEXJUZd/urtk01zvpSrY0hJOoVQhyex4MgQWnMOfS/06o/T28223nOHEz
         L5Bg==
X-Gm-Message-State: AOAM533dU801WFIvoVvisj0nn+hEbdbaEIkfyJVlkKmungJJeD+cK6Hk
        Zi4bYChZfvgDi6MS1jld7ZO9fw==
X-Google-Smtp-Source: ABdhPJzfmCwNhtBnMDgqCJ6U9NqZiqz4z8DYCCKlXGTpsMTZBRUH5gIu/2yNzh5n765Q3UnRuLOnlA==
X-Received: by 2002:a1c:103:: with SMTP id 3mr6129820wmb.81.1604518581726;
        Wed, 04 Nov 2020 11:36:21 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>
Subject: [PATCH 16/36] tty: pty: Provide descriptions for the 'file' parameters
Date:   Wed,  4 Nov 2020 19:35:29 +0000
Message-Id: <20201104193549.4026187-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/pty.c:710: warning: Function parameter or member 'file' not described in 'ptm_unix98_lookup'
 drivers/tty/pty.c:726: warning: Function parameter or member 'file' not described in 'pts_unix98_lookup'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/pty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 23368cec7ee84..a59f1e062bc65 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -699,6 +699,7 @@ static long pty_unix98_compat_ioctl(struct tty_struct *tty,
 /**
  *	ptm_unix98_lookup	-	find a pty master
  *	@driver: ptm driver
+ *	@file: unused
  *	@idx: tty index
  *
  *	Look up a pty master device. Called under the tty_mutex for now.
@@ -715,6 +716,7 @@ static struct tty_struct *ptm_unix98_lookup(struct tty_driver *driver,
 /**
  *	pts_unix98_lookup	-	find a pty slave
  *	@driver: pts driver
+ *	@file: file pointer to tty
  *	@idx: tty index
  *
  *	Look up a pty master device. Called under the tty_mutex for now.
-- 
2.25.1

