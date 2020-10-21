Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27437294B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441801AbgJUKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439091AbgJUKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:52:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100A1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:52:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg9so2060305edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5nYDPMP7i+kIxn8tnUUMEhReWaflkAWF7EfJa0hm4Y=;
        b=eIzq3gcxnrFq0TSGT3/1GueFjwSt3l8xKNXZzB3F2CrNfubZgRGL+zm68uJl9RqRIX
         4ARq8Sg6QI0a+nBS2PSg4XRp/IEspzUwlfxjN1SKPWZcyPy3kFkqX1fpRTgPkuQQ54IY
         jnp1uynvobPnHqfbe7FcAESpIifU8bn0aLAYuCXFyjaymysuz46FHmgQFMrctfTQXK4A
         0eYwTEpR6kFgQ+O+S3YiIIpQhix+fJqMCTUpegWRMlYyQ9yyyAKumGDYvzZBEz1mC7zB
         HFEUw0y8VQ4zsikf4mtAtl9cuMlS2/bIQKNyGbKqRSrxwvnwk9ZxU9/W1oMLfe82yfl1
         umQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5nYDPMP7i+kIxn8tnUUMEhReWaflkAWF7EfJa0hm4Y=;
        b=Xrt/15P/LmKx70PT5C3OVQ3gu2ZOJ3rwkQfRAW4r9ZfON3DjY3koPEPhufHxzg6Db2
         r+z7rkruKHlLO6/+SR8J65LInBFGh/dkphD9XlUPpGX/oIUYn2JX8DI/WBaz9+0ye2B7
         ypTxNYc0aPNTb0Zvh7GGHvxKmn4R71fWsEmv70ud6d9SMnS9E17aUSOIfNF6kZxOd3hf
         ITwngOoAJ8k+TCIWM+REeidBh4mCnoI3sXL3QYrXqIjRh2ahIuVMOeca95BvRaOhWjBf
         NlAUietTMffqZL8VpRKQtaPYnJ91m9S4/P+E4xIO0bMBJtrhKTewaohVe61KCciR/ocV
         JlHw==
X-Gm-Message-State: AOAM531Agplzj+s5bTcIn+mAykz1JMpFzuXgPOe2KXOn8XKDDx2U9P+y
        m8cUow9O+6/c75CRLzhSjY8lFQ==
X-Google-Smtp-Source: ABdhPJzM94ne2tVbzhczM/ZCWUmUniQPQP9idtuvm3bgr1LPn3BRwjfweSLz1fWu/kWLEIMLlK0AHA==
X-Received: by 2002:a05:6402:396:: with SMTP id o22mr2377871edv.361.1603277531516;
        Wed, 21 Oct 2020 03:52:11 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id ec3sm1756620ejb.34.2020.10.21.03.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 03:52:11 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] mptcp: depends on IPV6 but not as a module
Date:   Wed, 21 Oct 2020 12:51:53 +0200
Message-Id: <20201021105154.628257-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like TCP, MPTCP cannot be compiled as a module. Obviously, MPTCP IPv6'
support also depends on CONFIG_IPV6. But not all functions from IPv6
code are exported.

To simplify the code and reduce modifications outside MPTCP, it was
decided from the beginning to support MPTCP with IPv6 only if
CONFIG_IPV6 was built inlined. That's also why CONFIG_MPTCP_IPV6 was
created. More modifications are needed to support CONFIG_IPV6=m.

Even if it was not explicit, until recently, we were forcing CONFIG_IPV6
to be built-in because we had "select IPV6" in Kconfig. Now that we have
"depends on IPV6", we have to explicitly set "IPV6=y" to force
CONFIG_IPV6 not to be built as a module.

In other words, we can now only have CONFIG_MPTCP_IPV6=y if
CONFIG_IPV6=y.

Note that the new dependency might hide the fact IPv6 is not supported
in MPTCP even if we have CONFIG_IPV6=m. But selecting IPV6 like we did
before was forcing it to be built-in while it was maybe not what the
user wants.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 instead of selecting it")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    For more details about the issue we have when we try to compile
    CONFIG_IPV6=m and CONFIG_MPTCP_IPV6=y, please refer to:
    
    https://lore.kernel.org/netdev/CAMuHMdW=1LfE8UoGRVBvrvrintQMNKUdTe5PPQz=PN3=gJmw=Q@mail.gmail.com/

 net/mptcp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 8936604b3bf9..a014149aa323 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -19,7 +19,7 @@ config INET_MPTCP_DIAG
 
 config MPTCP_IPV6
 	bool "MPTCP: IPv6 support for Multipath TCP"
-	depends on IPV6
+	depends on IPV6=y
 	default y
 
 config MPTCP_KUNIT_TESTS
-- 
2.27.0

