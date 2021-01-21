Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7FE2FF798
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAUVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbhAUVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:49:56 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:49:15 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 2so1723243qvd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMFjqjTXoNJLUscEpZ/FobMrZilvYZKYbWkmE88q0Nk=;
        b=DlXyrvOFv1gzMSG++klZkcCxz+TQqS8ZU822IMiAtWR3ZWqEpKuGcEf19qVANlnHVA
         kVdqixUar++8l3wa2ir+0gu4XFGzb6dl9tef+t03OYCNeYgdKs92HDJB9lN7m6cWJAuE
         jB4TgzfT0yWJbxA6+OKcLoiDxV/uKn7VtA/wYgkjW5bBB5T39SCNBBbWqNzW8Cdl9wpt
         W8QemlntvmkD0q7Lv9ZHZHmCWR7LOs3ZqJCbXXpdYzbD7lpktCYcNj2NugLJ2mtOkrrU
         dXq+pIYT4X7HdL89vFsGRg6KN36c2AzlUkmL+/CvCjijLZRmCq5FINv8cERUkqwA+2JT
         PK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMFjqjTXoNJLUscEpZ/FobMrZilvYZKYbWkmE88q0Nk=;
        b=jdcltidQFglDbXAIgfrn8NPF0zIrVVdy8uTVoAiJ+2CFQcA3Rqzqq8t2MJV+cabwJD
         WubK87RsjQxLQfJJtcvmQ6Te0jst6QdAipgRRl1vwohQjzzX2UTK5oA21NsWPW84QeYh
         qgEwLBUq3I5xyIDiKt2D7XeJ56v+PaqqsHFlhBlpev+f2+9pZh+kL8XZml8XVtqQS+Rb
         2OWkoxFnU5BQehUm7m5usloc0497wooBmKFK2tkiLf9qRa7BAHhE7hxG7aPDMDAHqU18
         6j+mmZLBK/Dkd6EDS7uCKlZey2fHOLEMLNmKUJyJIaXxcTMGdB2CYutQUK+PqBTxmB0h
         9Q8w==
X-Gm-Message-State: AOAM531YKEP94S05NyggD0wZ66hLifVAVdI6G4Z1mTPVyP6+3OPUf5c1
        TCprkF3NwWnJ/czhmPDUfR4=
X-Google-Smtp-Source: ABdhPJyXFtJUU+wH8WxQcgflcqzKGuymkAZxdqgdPN/mIEvRuhMUCHzBkMYVmgn++MD+nvTcXHWoDg==
X-Received: by 2002:ad4:434e:: with SMTP id q14mr1751382qvs.15.1611265754645;
        Thu, 21 Jan 2021 13:49:14 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id q73sm4672937qke.16.2021.01.21.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 13:49:14 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tian Tao <tiantao6@hisilicon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/zswap: Add return value in zswap_frontswap_load
Date:   Thu, 21 Jan 2021 14:48:05 -0700
Message-Id: <20210121214804.926843-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

mm/zswap.c:1271:6: warning: variable 'ret' is used uninitialized
whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (!entry->length) {
            ^~~~~~~~~~~~~~
mm/zswap.c:1322:9: note: uninitialized use occurs here
        return ret;
               ^~~
mm/zswap.c:1271:2: note: remove the 'if' if its condition is always
false
        if (!entry->length) {
        ^~~~~~~~~~~~~~~~~~~~~
mm/zswap.c:1259:9: note: initialize the variable 'ret' to silence this
warning
        int ret;
               ^
                = 0
1 warning generated.

Prior to "mm/zswap: add the flag can_sleep_mapped", this path always
returned 0. Restore that so we are not returning uninitialized memory.

Link: https://github.com/ClangBuiltLinux/linux/issues/1263
Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Andrew, please fold this into

mm-zswap-add-the-flag-can_sleep_mapped.patch

 mm/zswap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6e0bb61d2a2c..a85334b719b9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1272,6 +1272,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		dst = kmap_atomic(page);
 		zswap_fill_page(dst, entry->value);
 		kunmap_atomic(dst);
+		ret = 0;
 		goto freeentry;
 	}
 

base-commit: bc085f8fc88fc16796c9f2364e2bfb3fef305cad
-- 
2.30.0

