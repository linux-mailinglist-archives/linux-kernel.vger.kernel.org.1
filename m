Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079F82A6E07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgKDTgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbgKDTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:02 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C88C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:00 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so2544974wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JW70o12XNpg7Pls0I5UJqPceVTayC1ax5WqT/gg/jic=;
        b=h+kQLTPYyWmvEgFxKMgTNJi/nylDDDsXmcFqxjiOdqAtQTbAImcROA2sotobq6lpo0
         jB0H1YTo4nlZXKC9Xj4RMUZEIy/3lnqtI7yaoXm5bxhbsqWp1+a7POtqn8vNktgu8O9T
         huZw1rD4AllsPMZt4Yj7JtJdBXacm4BGeEKBmeN4y4LHHIM/7Ixufip6hhIAHdd9I0/o
         sEep/7a4YxJxDSJAfi4NkZjpE/vmJR0x7KoX7hn/wkiPvD0EL2XB9D8CTptVi/BZ4Oa+
         NH1zaio7VCrywiAveY81K+O6IKYbYaNIMb0U0L8tilugXC68rv3BthrU/O4l3eTSkns2
         Lykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JW70o12XNpg7Pls0I5UJqPceVTayC1ax5WqT/gg/jic=;
        b=ImJ1jbBQEfcLLdx3X1xVIRFr2ZEMBs94LGrwK4Rp9MtwPtOYy2Za6Vz432E6m8vmQb
         RUGyGwtiNE6cxFh5DbNXXmX3tZ5DPER9e/zqO3qzmsWI3BQ2x/1xVPBjBQg7bNvgGogE
         w3gVHMMRWE0tVcmlXuJRn5h93+0oRT6UpmEGcInWRjavxXhh573vhrI79SODqe+jbB/S
         yfpkOzb1hv93fXOIfRGE3tiGeahr8DCUTd84PXi+HPVzmJdJZKX5bQqjA8KffJh1XgYN
         vG9Y+SLeFeZSDRpyo7572iWR3fb0BzZD/OKt7O/u4vJ2jvJn7veoeA1xHkUEQfxVyJfu
         +NTw==
X-Gm-Message-State: AOAM530Mkz0+9hztllqHNcN5HoGl6NsnQ3F9uT6nd/OOnQBlHC5KQ9wg
        lzQKMtGbLKO/q/g7w1UT0eHk/w==
X-Google-Smtp-Source: ABdhPJxOkOq8fS0a1MUngKpjjUe7WzFMXAF3FIw5qyC+UNLOlYzwjwI0W4E8s804WZN4+sp0661uhA==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr6499816wmi.174.1604518559545;
        Wed, 04 Nov 2020 11:35:59 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:35:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 02/36] tty: serdev: core: Provide missing description for 'owner'
Date:   Wed,  4 Nov 2020 19:35:15 +0000
Message-Id: <20201104193549.4026187-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serdev/core.c: In function ‘serdev_controller_remove’:
 drivers/tty/serdev/core.c:811: warning: Function parameter or member 'owner' not described in '__serdev_device_driver_register'

Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serdev/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index fecc28a73b3b2..aead0c0c97966 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -800,6 +800,7 @@ EXPORT_SYMBOL_GPL(serdev_controller_remove);
 /**
  * serdev_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
+ * @owner:	client driver owner to set.
  *
  * This API will register the client driver with the serdev framework.
  * It is typically called from the driver's module-init function.
-- 
2.25.1

