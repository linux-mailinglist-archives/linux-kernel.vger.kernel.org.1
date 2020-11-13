Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3452D2B13AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgKMBIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:08:00 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37156 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgKMBIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:08:00 -0500
Received: by mail-wr1-f50.google.com with SMTP id b6so7970165wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImEfKf0vY7pPJTJk/+z0G2jVTZI/ZhtyS/8plRez/Xo=;
        b=tNNtM8PU3JPP5Hk+xUxlHvtYcicA2Q++8m93FmKtAU8jydKpS7JelJG2gvS/gmQiKr
         KJrZLMlMbO7+HG8SWDleEGqauLcdq5hP85UqThT+fUmHc/WapDNNt1bDcpTHtxXZ6dIi
         JIIZTPrAGYGype6ppS//w4VUgJFc+zr85PfCJfAXRP6V8X9FHFih3caRerjc919/dGn5
         eUUlrYmo51a3Ga52btkieb8hcY8KiQjXvzMNe5Jsc559cDkFF0FB9+qM6FwukyfHDdn6
         uVtIUaIdYwW05sliV0r3b2kF3erz2ChiOk4GhK9LjfGxRPPCRYZTEp4nZauK1q+U1BeH
         neQQ==
X-Gm-Message-State: AOAM533uu6lLr9MAVyLFf4Tbjps4F9kGDlgVEiIAuWS3IDh2rMfcDlVj
        1SSH5Nk0rU6mX1j/BBubMcGv4aaMdfzWHk8F
X-Google-Smtp-Source: ABdhPJwQqN7iXF1G63Ta6CCVvrqOOC3Dllnk/xNS5ueb/EC0Bsf05NrCbOUyIuBzJ7y5kQwHWzXevw==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr2113627wrn.392.1605229662756;
        Thu, 12 Nov 2020 17:07:42 -0800 (PST)
Received: from turbo.corp.microsoft.com (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id a131sm7960617wmh.30.2020.11.12.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 17:07:42 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>, pmladek@suse.com,
        ndesaulniers@google.com
Subject: [PATCH] reboot: sync documentation with current code
Date:   Fri, 13 Nov 2020 02:07:39 +0100
Message-Id: <20201113010739.516026-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The valid values accepted by /sys/kernel/reboot/type are a bit different
that the ones used in the kernel command line.

In /sys we supports 'cf9_force' and 'cf9_safe', while in the kernel command
line 'pci' and 'q' are used.

Document the right values in the sysfs documentation.

Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 Documentation/ABI/testing/sysfs-kernel-reboot | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot b/Documentation/ABI/testing/sysfs-kernel-reboot
index 837330fb2511..fcc5d193c16c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-reboot
+++ b/Documentation/ABI/testing/sysfs-kernel-reboot
@@ -16,7 +16,8 @@ What:		/sys/kernel/reboot/type
 Date:		November 2020
 KernelVersion:	5.11
 Contact:	Matteo Croce <mcroce@microsoft.com>
-Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci
+Description:	Reboot type. Valid values are:
+		bios acpi kbd triple efi cf9_force cf9_safe
 
 What:		/sys/kernel/reboot/cpu
 Date:		November 2020
-- 
2.28.0

