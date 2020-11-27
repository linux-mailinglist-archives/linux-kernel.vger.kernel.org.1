Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23712C691B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgK0QHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731150AbgK0QHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606493236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TsMD7b3MnWExoEfBuHmM8Gy0J5MPvPWD/mFWcwpBdWg=;
        b=dKwL/9rBSvtpJjjtiKI8iiXJgXkVQUqFTgkIMCtZWEze0+zV2qtuoSNG5SUMw72OzDb6U+
        nQB/ICEE24JSlcTxJGZAcZIR9DY674V65TYUM7ttSqEVIctEFmUnOlqmmlLKqUtLp8qotY
        /WZ64t0IJa2J6suT1Zfomkz3jTH7fM0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-tm9p3mJeMQukwbz4o833ww-1; Fri, 27 Nov 2020 11:07:14 -0500
X-MC-Unique: tm9p3mJeMQukwbz4o833ww-1
Received: by mail-qv1-f71.google.com with SMTP id b15so3320973qvm.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TsMD7b3MnWExoEfBuHmM8Gy0J5MPvPWD/mFWcwpBdWg=;
        b=nQ81atHnRr2ivMmMAzylrJ3j0XeSyvr/+wajCrmOkV0qQmBPWdPGm4fGRYHmxOOjw/
         4gUd/X/WXsZPaFL2+u5TdqmbBZeWJlMf/0oSA7f/yCEFjdCSBqkTW7WCB2jdgT2FEWVG
         SK60NjgRxcijbq4f83u46UJzSDrnfs5lBXMHposB/oWi8L9m16Q9qYa76xM0n3G8W7Z2
         vcyHElcSQmkuCE/sUeTVjN+P/FIS6DvdzuoaLCgLGwFxgLpJehRueLfi3kYJQpmOPnxe
         t348TRyS5XYoFHB5kdnnu5XHJHd/mmEXzPdKrLez1XjshqBuvJ1GRt9gJLZdbXPraFZ7
         T5zw==
X-Gm-Message-State: AOAM532oN3uUUGk3yndLaLTLDq1DAIGLUhJdsITIbRRrE7Uq75eWK5iS
        MkTAjWQYe8wwBAHx7vEmiYeuZGZtjPQKnfcKz8QNZLtiIPuMz4n4vpKCaRhmtlFPhXHg5fnO14n
        hGvCIGFJ8UhLtIakjBToj1X62
X-Received: by 2002:ac8:5059:: with SMTP id h25mr8937153qtm.283.1606493234320;
        Fri, 27 Nov 2020 08:07:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+zzViQ6Rqk2DxgBkqfwyhjs9VcRi7Mngdgz9bSSxFH/DfJqKgsYTy1Dp2gQ9sUoRbMvjYaw==
X-Received: by 2002:ac8:5059:: with SMTP id h25mr8937129qtm.283.1606493234096;
        Fri, 27 Nov 2020 08:07:14 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u22sm6252620qkk.51.2020.11.27.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:07:13 -0800 (PST)
From:   trix@redhat.com
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] xen: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:07:07 -0800
Message-Id: <20201127160707.2622061-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/include/asm/xen/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index 5941e18edd5a..1a162e559753 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -355,7 +355,7 @@ unsigned long arbitrary_virt_to_mfn(void *vaddr);
 void make_lowmem_page_readonly(void *vaddr);
 void make_lowmem_page_readwrite(void *vaddr);
 
-#define xen_remap(cookie, size) ioremap((cookie), (size));
+#define xen_remap(cookie, size) ioremap((cookie), (size))
 #define xen_unmap(cookie) iounmap((cookie))
 
 static inline bool xen_arch_need_swiotlb(struct device *dev,
-- 
2.18.4

