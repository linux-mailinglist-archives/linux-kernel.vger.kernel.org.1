Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07C5295A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508120AbgJVIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:36:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51838 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503421AbgJVIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:36:28 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kVW5C-0003Fc-K7
        for linux-kernel@vger.kernel.org; Thu, 22 Oct 2020 08:36:26 +0000
Received: by mail-pj1-f69.google.com with SMTP id gv16so652781pjb.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2jy434wIuwXoLXzyeW6c/CAdjOSlRMynxqAD7g4/dU=;
        b=kLQbPagJ1XC6eKrzhn2138fCBa+aDdn0okTrnjGxiosZSZExgrIUeohf5Q64iWdZd+
         wW7Auyjce4yFROSYRfALA4KA6tWJcwSp0zbon661TNSNIQBqNfXjN9svryfsUkouvSMP
         ELSBkvTbFDB3D7hyagrAbzz2FW3WpclfzIVRBkk5PPIiEVdqRSJGiFOkIG62SNE3lACe
         jMzPqrDNijcj/lX9qX99M/lpcoH1kWX5h76Xfy1QcOMhFi39fMYxj0zAwyY6kfz9ZOCO
         v+THSwtCfNjN1t+5BUsegF31l7thdpXmNCGYwxoEEcBDPoYvSUWIIhUVUuj5kBbkgrGD
         rOzQ==
X-Gm-Message-State: AOAM53229umO3E81VVaYxntC7/SrA5MOK0TYMxUqnNJur5hcU1bfiGRM
        4xmUGHrofJ4HTuENLew8hW8p8jCIiVXkQa1rOPlZtweHZv7h4ERBZbnEOtuc/uSex+t9HqmGTMs
        uVCoCPQsD2Fso+/qBwPDweh+W5QzY/YXKSav5olTt
X-Received: by 2002:a17:90b:438c:: with SMTP id in12mr1367417pjb.32.1603355784923;
        Thu, 22 Oct 2020 01:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNakAo0xdaw0VJxwPqXKhIaUfkhybuIzehY4Ztq4OIlZTIcIge6pr0+zczxLDbkwa2t0WsBg==
X-Received: by 2002:a17:90b:438c:: with SMTP id in12mr1367403pjb.32.1603355784654;
        Thu, 22 Oct 2020 01:36:24 -0700 (PDT)
Received: from localhost.localdomain (223-137-29-213.emome-ip.hinet.net. [223.137.29.213])
        by smtp.gmail.com with ESMTPSA id y191sm1335465pfb.175.2020.10.22.01.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:36:23 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, shuah@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, mathieu.desnoyers@efficios.com
Subject: [PATCH] selftests/powerpc/eeh: disable kselftest timeout setting for eeh-basic
Date:   Thu, 22 Oct 2020 16:36:16 +0800
Message-Id: <20201022083616.41666-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eeh-basic test got its own 60 seconds timeout (defined in commit
414f50434aa2 "selftests/eeh: Bump EEH wait time to 60s") per breakable
device.

And we have discovered that the number of breakable devices varies
on different hardware. The device recovery time ranges from 0 to 35
seconds. In our test pool it will take about 30 seconds to run on a
Power8 system that with 5 breakable devices, 60 seconds to run on a
Power9 system that with 4 breakable devices.

Thus it's better to disable the default 45 seconds timeout setting in
the kselftest framework to give it a chance to finish. And let the
test to take care of the timeout control.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/powerpc/eeh/Makefile | 2 +-
 tools/testing/selftests/powerpc/eeh/settings | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/eeh/settings

diff --git a/tools/testing/selftests/powerpc/eeh/Makefile b/tools/testing/selftests/powerpc/eeh/Makefile
index b397bab..ae963eb 100644
--- a/tools/testing/selftests/powerpc/eeh/Makefile
+++ b/tools/testing/selftests/powerpc/eeh/Makefile
@@ -3,7 +3,7 @@ noarg:
 	$(MAKE) -C ../
 
 TEST_PROGS := eeh-basic.sh
-TEST_FILES := eeh-functions.sh
+TEST_FILES := eeh-functions.sh settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/eeh/settings b/tools/testing/selftests/powerpc/eeh/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/powerpc/eeh/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4

