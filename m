Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7D20E3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbgF2VRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgF2Swv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56515C02E2C9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so5406904wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awbvdf/o8WJSBn2jZAYd3v4hbJ6rKznLBA9Uh+6bpSY=;
        b=bWI/Qpg8KHMiyukEPTm6FGM05U/4gMMkQHOHo8Nz82wB1fM52NfEp9sQEYJxW2Admn
         36jXiYmOkyXpV+MMfSlpZT8Z9s9TZYZBTkr+WU+AkV6levgYIww9eFqKcfy+b7aov0Ar
         aSA6O4aQYnrIzAVcN2+hH+w3Fx7vH5ROlRP5Q22Uxuts5CNaQr/iw9JPKy3+nzLruCX5
         rCb9EPkFb0B6QKG1l2+sEq1zz5+b6EgH7+TAMVkNi3o6cKbwRjBq67YFLhSGVkXgCcOv
         8znzvVP02lrg2wbkpchzZYSHLbUR3k6W/ri5p3Tqp9XejF7alIJ68AbMxV5b4psyB5Oe
         c7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awbvdf/o8WJSBn2jZAYd3v4hbJ6rKznLBA9Uh+6bpSY=;
        b=ERnoRm3L0XFRDtuB00dcXFykdkVsWfGuu1IUWy4IZSe6nqCLMelczfBw6kqhEnCSO9
         9XVO3j6xuSRJrvknxNub8cNFITfRZM9xIyTXSHXPI6q1D472GB3YUmwx5qvLGJ/SzfMB
         HU/4K3iOcsnLOf6lCApah0TdX3DJmUcgBlXmtWEQkk9XjdThFvW9ZIQ+JLjZRzfQdWKq
         0HSyNAxXiGIfSawFNscZrpW8INf2jjVwi7CsBEj+Dmxpgje7utZ+dLDXZRGnEdddbETV
         CjsBVdIpLzoqJMu4vDNmRtBWFBVIqUcxGGSqSsxqHnemuG8VgeRP4qLYJE1OY/b3VP0p
         jySw==
X-Gm-Message-State: AOAM531dFpn3zb6sZgsy9aLhtLIqR2YU1uGsehokSTJYavkPzIacKhim
        7LsKoxH2ZJ2/n8TVJX6rZmLuXA==
X-Google-Smtp-Source: ABdhPJwlYoQKfNVdDrit+2utE+6X7YuQwjowoDK8uijEIVf5IcJ4q9wfncz9T8GKzXHC/FOuq3rmSw==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr18518133wrq.38.1593439487048;
        Mon, 29 Jun 2020 07:04:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        J Freyensee <james_p_freyensee@linux.intel.com>
Subject: [PATCH 01/20] misc: pti: Repair kerneldoc formatting issues
Date:   Mon, 29 Jun 2020 15:04:23 +0100
Message-Id: <20200629140442.1043957-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 kernel builds report a lack of descriptions for various
function arguments.  In reality they are documented, but the
formatting was not as expected '@.*:'.  Instead, '-'s were
used as separators.

This change fixes the following warnings:

 drivers/misc/pti.c:748: warning: Function parameter or member 'port' not described in 'pti_port_activate'
 drivers/misc/pti.c:748: warning: Function parameter or member 'tty' not described in 'pti_port_activate'
 drivers/misc/pti.c:765: warning: Function parameter or member 'port' not described in 'pti_port_shutdown'
 drivers/misc/pti.c:793: warning: Function parameter or member 'pdev' not described in 'pti_pci_probe'
 drivers/misc/pti.c:793: warning: Function parameter or member 'ent' not described in 'pti_pci_probe'

Cc: J Freyensee <james_p_freyensee@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/pti.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 07e9da7918ebd..e19988766aa69 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -733,8 +733,8 @@ static struct console pti_console = {
  * pti_port_activate()- Used to start/initialize any items upon
  * first opening of tty_port().
  *
- * @port- The tty port number of the PTI device.
- * @tty-  The tty struct associated with this device.
+ * @port: The tty port number of the PTI device.
+ * @tty:  The tty struct associated with this device.
  *
  * Returns:
  *	always returns 0
@@ -754,7 +754,7 @@ static int pti_port_activate(struct tty_port *port, struct tty_struct *tty)
  * pti_port_shutdown()- Used to stop/shutdown any items upon the
  * last tty port close.
  *
- * @port- The tty port number of the PTI device.
+ * @port: The tty port number of the PTI device.
  *
  * Notes: The primary purpose of the PTI tty port 0 is to hook
  * the syslog daemon to it; thus this port will be open for a
@@ -780,8 +780,8 @@ static const struct tty_port_operations tty_port_ops = {
  * pti_pci_probe()- Used to detect pti on the pci bus and set
  *		    things up in the driver.
  *
- * @pdev- pci_dev struct values for pti.
- * @ent-  pci_device_id struct for pti driver.
+ * @pdev: pci_dev struct values for pti.
+ * @ent:  pci_device_id struct for pti driver.
  *
  * Returns:
  *	0 for success
-- 
2.25.1

