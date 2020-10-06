Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF762284F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJFQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJFQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:06:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 09:06:38 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ly6so17166707ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+y9F2HEpHR7lpSOgScZpt3aZTxZ1exfih7MMVF+3Hw=;
        b=jf88Ccrjz6JfstZvP1H6vKpUwaTbdYZQWbaqcorUPs55gtjmyI3fseCArUh1epVqS3
         4eYNRt440ub75D4QaXWpqP8ARoht8EmKsdCjpkhEIHbxaEiablFizXmgczRurfzefJaY
         zHLPbvcCYjtcnCnQUd+ADgEZcRIHNZrjL53518daGtLB6NDrV9XNi8ab5/Kmg7WBizOK
         egSWWtXN9UmDmdu/uHETlYZsUpP5g/rIPVYVi8wWudAApcmJy5zAxn1vKXvoMZ91HADg
         CH4TGBFnVr2ZxtiL9Dg1jVYUTLNPXugnvf+aOl77pBULkmJm+Zmahy+rlgX5ebxHRGwS
         xwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+y9F2HEpHR7lpSOgScZpt3aZTxZ1exfih7MMVF+3Hw=;
        b=CzMJPPBr1BoeJHGfFi+aCysj6J2XdSpFQvFNGrsOWxyP7VjL0mz8nBKBS1uZOBxQEY
         OfJtAGPNlmxzwQXBlmss6H/i2YQjFjO/bI5ggRJ1pWg9dh4Jc1K0JL6M7bqQZcK9pV4u
         25LXA1nH/RO0OmDYgj9e+tUcLdoBDDP/T0QQEkWGQ9yC+48vP53BjWMdVgnMjiimIq7F
         Sz6c3V+jWq0Vh4+EeTaTzK9QHjLwu04mZ2MicfPz7EnQJ3CMW+mfj1GW7eDUzSwlqFt9
         XgCDqapPLHG1BX/YDuJajYTShwCgrIp6RZ8CzNfhpVZzG+qa2GgPI4ywm8Wh4jPoT/sh
         9WxQ==
X-Gm-Message-State: AOAM5319gwi7fsJXpO7Tb/BEWW6uxQ2G1HMxIyElMgiDULg2VUZvJrqz
        y41QmOVyow4BjZ5U5FnKBOfb/ZfTe3/Y2b9h
X-Google-Smtp-Source: ABdhPJyzjVYRacyR1diWDrgUya8FodDmT9FCiesreDN+9KHyafL2720b1WgbdyuWdfsIk2q8a1ZJlw==
X-Received: by 2002:a17:906:441:: with SMTP id e1mr213966eja.396.1602000396693;
        Tue, 06 Oct 2020 09:06:36 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id jw9sm2412039ejb.33.2020.10.06.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:06:36 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: mptcp: interpret \n as a new line
Date:   Tue,  6 Oct 2020 18:06:30 +0200
Message-Id: <20201006160631.3987766-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of errors, this message was printed:

  (...)
  balanced bwidth with unbalanced delay       5233 max 5005  [ fail ]
  client exit code 0, server 0
  \nnetns ns3-0-EwnkPH socket stat for 10003:
  (...)

Obviously, the idea was to add a new line before the socket stat and not
print "\nnetns".

The commit 8b974778f998 ("selftests: mptcp: interpret \n as a new line")
is very similar to this one. But the modification in simult_flows.sh was
missed because this commit above was done in parallel to one here below.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 0d88225daa02..2f649b431456 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -200,9 +200,9 @@ do_transfer()
 
 	echo " [ fail ]"
 	echo "client exit code $retc, server $rets" 1>&2
-	echo "\nnetns ${ns3} socket stat for $port:" 1>&2
+	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-	echo "\nnetns ${ns1} socket stat for $port:" 1>&2
+	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
 	ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
 	ls -l $sin $cout
 	ls -l $cin $sout
-- 
2.27.0

