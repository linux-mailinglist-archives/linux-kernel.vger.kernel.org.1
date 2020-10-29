Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2798629ECB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgJ2NR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgJ2NRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:17:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC3C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:17:22 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a81so1731598qkg.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hmbKrgrrAV+ZwrZ7GWFGPrZaCp36du3w8RCEfMZ8hak=;
        b=rRA+MGMdUVhxdLn0fiVLTsKyw2gzfgaTTZNdAD8mv7qJa7bRjJvyyRZ8Zlnfig57uA
         3moKitlSUs2lFIZMRVO6D5rHkyNuu2BF7TdlEUiBAh+BISK0kWnxlDQS5AKRJfknorWZ
         ZS4kUR0Qn0LWnANIxO5RCa2DPSVaU8Ahn/juURFEQqXBVc8RTIiEOqOJWy6MRqS8JTs+
         I25VGhq+V7xPkxFFSnwv0nGVjdNTPCuB5osjwNRSXfv6E7lImhDJ56FTQieNXeMsBny0
         XuJ+c3jW1qI2TYoMJqvJ0v67uHoOGLTtuBvRFdAuu9m0JlRcY6z/0/G2avUn1ALzMFbF
         BNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hmbKrgrrAV+ZwrZ7GWFGPrZaCp36du3w8RCEfMZ8hak=;
        b=k7tjzTZQTzLb4FQxdxCz9ASoZfggqhpm0v5R/upy8Kic07xBT5DT88/WbCPPYCKAFn
         tk3B/DB0HaBiG1h3CYcevnVnbG5ZJTh3OjQwrtHqNhMCM2cb9VHItmrmuaOSgtkdMNfi
         JdS7E6Ro9h30OkYAlxKCnYBN7sJOD5dW6Eg96SDyTpwfjgarK3ZuKUWnRKEjiNlgEKgB
         0SokLkmW561uexyf+tXnBNf+jdRSo7YB6vSFnk9BoHIVIPbM2y+DdGBA/2cNXqgQ98Q6
         CQVPjE7BV9xGNom2yOOXIlHYWinITm1UIZlWg/95BTuf0C5Cl5AEAqvBngYvc/KjndOo
         dVzw==
X-Gm-Message-State: AOAM532cAkJBXLnEhfo1SnWL6clXCuzdrI2GTX+RqZgvc3fNX7v1GOS+
        NHz/8ygD0l5Wow/n+EUWtGJ1DPyynw==
X-Google-Smtp-Source: ABdhPJx6Df8kwq1WIJy7wveWRyDoLsov7nxJzypRJUlzUEaRsLhUHrDBGcSs6ssHj4PbKi/Vfn+qIpsyTQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a05:6214:943:: with SMTP id
 dn3mr4211962qvb.45.1603977441430; Thu, 29 Oct 2020 06:17:21 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:16:49 +0100
In-Reply-To: <20201029131649.182037-1-elver@google.com>
Message-Id: <20201029131649.182037-10-elver@google.com>
Mime-Version: 1.0
References: <20201029131649.182037-1-elver@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 9/9] MAINTAINERS: Add entry for KFENCE
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, mark.rutland@arm.com, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for KFENCE maintainers.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: SeongJae Park <sjpark@amazon.de>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Split out from first patch.
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..2a257c865795 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9753,6 +9753,17 @@ F:	include/linux/keyctl.h
 F:	include/uapi/linux/keyctl.h
 F:	security/keys/
 
+KFENCE
+M:	Alexander Potapenko <glider@google.com>
+M:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kfence.rst
+F:	include/linux/kfence.h
+F:	lib/Kconfig.kfence
+F:	mm/kfence/
+
 KFIFO
 M:	Stefani Seibold <stefani@seibold.net>
 S:	Maintained
-- 
2.29.1.341.ge80a0c044ae-goog

