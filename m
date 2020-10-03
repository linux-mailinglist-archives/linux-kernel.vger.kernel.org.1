Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF1282525
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgJCPhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgJCPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 11:37:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBACC0613E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 08:37:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t16so5043004edw.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfWb1QvzEtlqqy8XFPM/8NHEfrfMPuBTiUyjdxLWQ9k=;
        b=rP9ULBumcayL5fLbfM7eDQhihWy4oQFHgmOqUZmefgWbg+dMrN4mKQic4U8MW1tOFI
         5FnGIE1fhCtxI/653Hq8YkPmU1N6xjamvKilZXQWvmPgMCIFFSKxwIZiDCxOE1/Iohw7
         rA6c2eRcpkWBCQ5RQnukhERLJ1b1GORLtu+Wr/5OyBHVCQTyzxCDthzWfhhM4GRIJW+v
         BgUdcq5Jg01cAksJ+94dL4c2B1c37nDmRQsV/XNExGDiwR58ZHMG0GryaRon86LrK52n
         Ij/LaLy0d/Bqav2wGbO9zW4wsgMfFreQdGu9W6HPvHdP7+3d3+NKAB3krdPc3++IDq+z
         qXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfWb1QvzEtlqqy8XFPM/8NHEfrfMPuBTiUyjdxLWQ9k=;
        b=LLWheaj6mEmyuCjNolpYHJuiChqJY/cJjj0haeDlQaccHwnXJKw9yLEwQpFUjLSvah
         //tpYIw55OxmX4kGI+uztirwCE3HAdx0gIaU1ZoHu/go2eYfov5LJjr7UqeNZFQb0tXT
         N0K6kmcajJ0LTDV6mOsscg5/fanCU4sjwax7+Fj35vjBHHIGbDNb5LFmyNczwAmsCQNn
         qAOCq3Q1fSHl0ULG2ZorxDPsKjVE5Xv86OuHTtSAL3xI+DwVNhnY/orQ0uu8jJN5kBXy
         RaVODVLEpfN9j+f3vWeiCjB6UoqDmkWPr3wYM7pyAxxrYKSB9XWQoPIwiTKcaU3DydbV
         913Q==
X-Gm-Message-State: AOAM533fLzSV99CV8WS/dluUBOytUhWFI2PnB0dPRD7Cwkru9t8A1Ffc
        AusQ4g7XFRI9ncboYqS375d9Zw==
X-Google-Smtp-Source: ABdhPJxS9bXlGuf066KNdZLv8CsXQJZOZ/763lB4JzQgPcVxHnY4Gf+ORu5OSGkeODk1wE8sUDsMqw==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr9060153edz.149.1601739423024;
        Sat, 03 Oct 2020 08:37:03 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id w15sm3268679ejy.121.2020.10.03.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 08:37:02 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Geliang Tang <geliangtang@gmail.com>
Cc:     Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mptcp: ADD_ADDRs with echo bit are smaller
Date:   Sat,  3 Oct 2020 17:36:56 +0200
Message-Id: <20201003153656.1224144-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPTCP ADD_ADDR suboption with echo-flag=1 has no HMAC, the size is
smaller than the one initially sent without echo-flag=1. We then need to
use the correct size everywhere when we need this echo bit.

Before this patch, the wrong size was reserved but the correct amount of
bytes were written (and read): the remaining bytes contained garbage.

Fixes: 6a6c05a8b016 ("mptcp: send out ADD_ADDR with echo flag")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/95
Reported-and-tested-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 5 +++--
 net/mptcp/protocol.h | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 411fd4a41796..03794f89efeb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -587,7 +587,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
 		return false;
 
-	len = mptcp_add_addr_len(saddr.family);
+	len = mptcp_add_addr_len(saddr.family, echo);
 	if (remaining < len)
 		return false;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7e81f53d1e5d..e19e1525ecbb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -183,11 +183,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
+	*echo = READ_ONCE(msk->pm.add_addr_echo);
+
+	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	*echo = READ_ONCE(msk->pm.add_addr_echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, false);
 	ret = true;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..6eef4db9ee5c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -464,11 +464,12 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.rm_addr_signal);
 }
 
-static inline unsigned int mptcp_add_addr_len(int family)
+static inline unsigned int mptcp_add_addr_len(int family, bool echo)
 {
 	if (family == AF_INET)
-		return TCPOLEN_MPTCP_ADD_ADDR;
-	return TCPOLEN_MPTCP_ADD_ADDR6;
+		return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE
+			    : TCPOLEN_MPTCP_ADD_ADDR;
+	return echo ? TCPOLEN_MPTCP_ADD_ADDR6_BASE : TCPOLEN_MPTCP_ADD_ADDR6;
 }
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-- 
2.27.0

