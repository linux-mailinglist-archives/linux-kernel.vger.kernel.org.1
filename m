Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CD28FD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgJPEM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:12:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60290 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgJPEMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:12:24 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kTH6M-0002nZ-It
        for linux-kernel@vger.kernel.org; Fri, 16 Oct 2020 04:12:22 +0000
Received: by mail-pj1-f70.google.com with SMTP id r1so823030pjp.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 21:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lj+knYxUtKPg4RXVIM/N60ZjQtEWBhu0c8E4sC/HXuk=;
        b=hIGbAYXOwJNS9+0rfVAix9m77LoevKssCslNGnNQNXhEIpotpB37OBcj+5iSLRQb3N
         jH+X3xj23MbSXRvBW/+ggNYrQIWxRcmDUgu0mIKXpR9LRZMTjkdWND8Fb632qTluBVQ5
         E0F9yV91MbhHz3C3YubpFNefD5hrvzIgPXeyaL8rBqSzNjnq+xNA4+Zy5NdoIAUqYapJ
         HqW7RI6xN+DjVkZHhTvNIjxB9s3pqPLwWeU1HRVwsK4tPFxXS2gag22vc5d99l8SrgdM
         6S54F0wfLlUTcbxUAKp/udZ9wGzANHdGL6QAAhkmL72+uqgeZTNUqoJYMNbneY8ffK3B
         OPqQ==
X-Gm-Message-State: AOAM530ZEnXZ6rplMRsnbREPt+Y30BBCgcYx4t31IpP6QSRoTRhiwtOt
        fsQpBdbZ2qlztyAKKast78X843W0T6n9i24xFtz9KKY/zY0YYbNhTTD7LZqqw5AG3cs8dSvk/MK
        koR+odpnhmjvtCw8YO+j2zaOEhUyyCcKxeq1+b79w
X-Received: by 2002:a17:90a:f504:: with SMTP id cs4mr1960317pjb.134.1602821540787;
        Thu, 15 Oct 2020 21:12:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuiSKw3Fc623zX1J/CAP9plBsNCtvs5MGJMMDxfzVtSTbK7rn7o0Xn8rYN4eGs9/I/aF82TA==
X-Received: by 2002:a17:90a:f504:: with SMTP id cs4mr1960296pjb.134.1602821540489;
        Thu, 15 Oct 2020 21:12:20 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id w12sm889596pfu.53.2020.10.15.21.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 21:12:19 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     kuba@kernel.org, davem@davemloft.net, skhan@linuxfoundation.org
Cc:     po-hsu.lin@canonical.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCHv4] selftests: rtnetlink: load fou module for kci_test_encap_fou() test
Date:   Fri, 16 Oct 2020 12:12:11 +0800
Message-Id: <20201016041211.18827-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
needs the fou module to work. Otherwise it will fail with:

  $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
  RTNETLINK answers: No such file or directory
  Error talking to the kernel

Add the CONFIG_NET_FOU into the config file as well. Which needs at
least to be set as a loadable module.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/config       | 1 +
 tools/testing/selftests/net/rtnetlink.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3b42c06b..c5e50ab 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_KALLSYMS=y
+CONFIG_NET_FOU=m
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 7c38a90..6f8f159 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -520,6 +520,11 @@ kci_test_encap_fou()
 		return $ksft_skip
 	fi
 
+	if ! /sbin/modprobe -q -n fou; then
+		echo "SKIP: module fou is not found"
+		return $ksft_skip
+	fi
+	/sbin/modprobe -q fou
 	ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
 	if [ $? -ne 0 ];then
 		echo "FAIL: can't add fou port 7777, skipping test"
-- 
2.7.4

