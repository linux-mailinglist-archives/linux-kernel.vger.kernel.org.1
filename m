Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B492D0CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgLGJNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:13:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45856 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLGJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:13:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so14111146ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebfi/Zi/zHoTJbwW/sWNc/qX2n8nnjwkVcAcnVx56Kk=;
        b=NQaJ6c3U1KjOd8wNgB9eoW4X+cVMORayfMGUwV8Xclst9fgE7UYUajJLmmw7eaNSyx
         0iCF/LuZwa9E0QYDx72E/+DxPF/Pnc6se8Cmum1T+u7IB9A3saHi3SencOLpESxJbl5M
         iZ0/YhXSepJnQhRJLXqZKy0V1w5nvgf1Fyky4tUR190sk/Tz+ZuYpmE92fqu1MrRMlZL
         DxoXo5Z/QFI878KhCY52HIn4oe3aSnm3mUpN6QiozgjY5Qb/5s5LQVQLavbA+XoENNXF
         gN+nI8zrrnrpSp1bSKi+pWUHglLzUbF9tJ6EVlF/cigWlz1+pAVpg87zsqap2xts0m8U
         T66g==
X-Gm-Message-State: AOAM531+5cBYiXMg+jhJKFyY4k75vnfpkR8hVgo7rsoDhLtsKIvyZg5s
        3/i0U8/Rr6psj3EQ9dAg82gDycjNGrdp8A==
X-Google-Smtp-Source: ABdhPJzsbYAEiO5bhQ0R4i11fNvOJJa1CaJFi6yn/wm1KY6/fdmNU08A5bmWo3v2qvSowQes9sIv0w==
X-Received: by 2002:a2e:8750:: with SMTP id q16mr8780622ljj.53.1607332363039;
        Mon, 07 Dec 2020 01:12:43 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id m26sm552998lfb.288.2020.12.07.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:12:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kmCa4-0000nr-Kk; Mon, 07 Dec 2020 10:13:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] module: drop semicolon from version macro
Date:   Mon,  7 Dec 2020 10:13:08 +0100
Message-Id: <20201207091308.1217-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the trailing semicolon from the MODULE_VERSION() macro definition
which was left when removing the array-of-pointer indirection.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ebe2641d7b0b..b63db970fd26 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -279,7 +279,7 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 			},						\
 			.module_name	= KBUILD_MODNAME,		\
 			.version	= _version,			\
-		};
+		}
 #endif
 
 /* Optional firmware file (or files) needed by the module
-- 
2.26.2

