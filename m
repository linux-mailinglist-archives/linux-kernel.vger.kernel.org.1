Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04353036CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbhAZGr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbhAYOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:49:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8EFC061574;
        Mon, 25 Jan 2021 06:48:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y187so11308633wmd.3;
        Mon, 25 Jan 2021 06:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QKVPfv6NioAKXL2jIZ8ignJiUMCaI8h+exsQiu5IPPA=;
        b=E0JEArhPC9PVqQSnyWc+a/zbPCrY7aFgkE83tMzyQlsm43jR/vImtUY2iYWfm8Y2J6
         ncpXDMCTpG8UKHD0ttjoVG5ZH9IEDSpCqj1a1ZNsVGFx9aFepGwIRhpJVkoWKHP6NbOu
         uBNZfso9/uu8TGJdn9BmccBh5qnJfbkCM6OPwbqRTJp7G62dN/axrDg/WXcnbXVXpXCi
         jpEmF0bSSbb5B6BlE9x1k1Um3V1eKHc5oKvGV4FDBHJ5/dBPe3XKvUxU092Kgg3BTsnb
         Eh779Yo+ymlSdAzgk/h0gmrfLk+PEYmNQAbCJ9MQdS2ZCmwgOJiGKSBmm5O3J0XYypI0
         j86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QKVPfv6NioAKXL2jIZ8ignJiUMCaI8h+exsQiu5IPPA=;
        b=iWZU4YFOHZiKu6Hqo8KIVcNnv2dYYZ7ELw9uS9aPjlv1NWHDyxajjRwkM2MGJcMDUn
         qGJ6lHrMohO9XmBsTjPB1A7IYopmwb94CC1aL6Hv/DygUd8KIR6j7vgXZrV4xYw3mA/L
         FT7pX/KKEgxXVAbjhon97/M/NlYqjpSun0V0TY8bu0FJgPBRw9h6qtLyeDx+ESg1viyu
         tjghkaV7eXflwQdQT2pvoYN/gjSvFxeBBK8AognAB7WSeKSjh3Z1zZ8Rq8pJhcOqz2kC
         6Xd6yLH9xPg56E5yvnvlpP8L2VqJfVz3tU0scPmMqho1MYp5cMAYbs2YLznXOUkMXsy2
         JkUg==
X-Gm-Message-State: AOAM532s+Sr7lDPUjuvg6WXWALmCGQMEEBX60aPYipn4MSN9kaspmk85
        aiupJmtNi3eC3BDk4quO4YY=
X-Google-Smtp-Source: ABdhPJwUHv9gCSik0AJygB1hBoPoE+LvC1chT3BIWydPVTXlqmNYUqnk0AhMSJ3iwcEYds+RtH3bhA==
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr473416wmg.172.1611586136014;
        Mon, 25 Jan 2021 06:48:56 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4b:4500:649e:f82b:bf2d:2571])
        by smtp.gmail.com with ESMTPSA id b132sm21454499wmh.21.2021.01.25.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:48:55 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] kgdb: rectify kernel-doc for kgdb_unregister_io_module()
Date:   Mon, 25 Jan 2021 15:48:47 +0100
Message-Id: <20210125144847.21896-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command 'find ./kernel/debug/ | xargs ./scripts/kernel-doc -none'
reported a typo in the kernel-doc of kgdb_unregister_io_module().

Rectify the kernel-doc, such that no issues remain for ./kernel/debug/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.11-rc5 and next-20210122

Jason, Daniel, please pick this minor typo fixup.

 kernel/debug/debug_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index af6e8b4fb359..7f22c1c0ffe8 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1166,7 +1166,7 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
 EXPORT_SYMBOL_GPL(kgdb_register_io_module);
 
 /**
- *	kkgdb_unregister_io_module - unregister KGDB IO module
+ *	kgdb_unregister_io_module - unregister KGDB IO module
  *	@old_dbg_io_ops: the io ops vector
  *
  *	Unregister it with the KGDB core.
-- 
2.17.1

