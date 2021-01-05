Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01B2EA68E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbhAEIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:23:53 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0EC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 00:23:13 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i5so20837023pgo.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2Ns+KjaRZiIsqBfJstvkjNabzsP3wbjh23QJIKvTaQ=;
        b=YQfcpfCfGzqCAiKiaiQkLNI531wW1pkJsiHVjANA2REPooMz624jcPhFLj+xsTSX6I
         6Fs6Ob1Ln6xEUBFPsKz6Kdwjp7RaBAK0xW+/4x/C7lAwmf9v71kUH6fwvH0TlNjqjPIi
         MPWOgLuteyXYrYA5SRc5es/ddD4SwdqZ4cBY6FBEpNksw9BB8te7ZlHWZPYecCOnPJXi
         xF+deoCGbPEgTrvka+YjCP5OrR/8H5/YHBhoobcc4rQLPZrDME61AxzT7syZk68K2K6i
         pjhaRcqWn2Y07kF2J339XBC7ekmETb4SwZyDoN+fwCCDxhj0LDvjri30Vcy7pzdzWqmI
         0NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2Ns+KjaRZiIsqBfJstvkjNabzsP3wbjh23QJIKvTaQ=;
        b=ogQa/EhTXiumRR/nCYwbVtpfRc3cEawxdyIEsVjVB9zdtmUe0QSnoJPzkXB4q5gIq0
         w7CA4rU5pbPYzkAhtUsAYPHOelwaCvfBA0u1TuzeNt+n0GPLyVSXapAndEMmLG/NQ4bh
         QuV2zMUI7EqCqvRPxq8bmNOnLaIpyL9G1eFQw4tYc03DaVcA3xEVr+ML7YfLfcaERLUD
         0xf/KQVdrlxMiXhiHpjVzTWZRbd3Bz+PxdJXRjMFSiP0l100HvXVy1nnWHOV5ywE9B0j
         wX+wNfbqgDFDaDECNGcMjPnOAl0K6Joe21/axYhlDbj/wyRWZucyC8Xf3hgUkkG78BOW
         Rb8A==
X-Gm-Message-State: AOAM5319w2ycXzmhtvkrxq35qy0E6wYUhUKmRV1sLzGSugJ3rtQ4aLrt
        7cjxj5psJe6WO0MOBfOKkUc=
X-Google-Smtp-Source: ABdhPJw1hnzLD8RleGkOsv9x9hjymBlVqEzMqd9nHE1T6RaM0f1Sq0LkD/2kqPyd2rYL7d9uohcQJw==
X-Received: by 2002:a63:b05:: with SMTP id 5mr75795965pgl.163.1609834992702;
        Tue, 05 Jan 2021 00:23:12 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6064:97d:44da:5ae4:7c76])
        by smtp.gmail.com with ESMTPSA id q26sm58584699pfl.219.2021.01.05.00.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 00:23:12 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add a new check for strcpy/strlcpy uses
Date:   Tue,  5 Jan 2021 13:53:03 +0530
Message-Id: <20210105082303.15310-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer.
This could result in linear overflows beyond the end of the buffer.

strlcpy() reads the entire source buffer first. This read
may exceed the destination size limit. This can be both inefficient
and lead to linear read overflows.

The safe replacement to both of these is to use strscpy() instead.
Add a new checkpatch warning which alerts the user on finding usage of
strcpy() or strlcpy().

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d6a4d25b0972..0003fd9de62c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6604,6 +6604,13 @@ sub process {
 			}
 		}
 
+# Check for strcpy/strlcpy uses
+		if (defined($stat) &&
+		    $stat =~ /^\+(?:.*?)\b(str[l]?cpy)\s*\(/) {
+			WARN("PREFER_STRSCPY",
+			     "Prefer strscpy() over $1()\n" . "$here\n$stat\n");
+		}
+
 # Check for memcpy(foo, bar, ETH_ALEN) that could be ether_addr_copy(foo, bar)
 #		if ($perl_version_ok &&
 #		    defined $stat &&
-- 
2.27.0

