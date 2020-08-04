Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3023B8A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgHDKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 06:18:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgHDKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:18:22 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k2u1U-0006aQ-7U
        for linux-kernel@vger.kernel.org; Tue, 04 Aug 2020 10:18:20 +0000
Received: by mail-pj1-f69.google.com with SMTP id ei10so1889107pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 03:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9y6aVddCClGzQPDVtd0OG0Kza0yw4aTj1d1wJ/cWqtg=;
        b=GSIvyRiy/rKNYCzBG8ffFOpMUZc1V8vWmb/eNEY/wOHDFy4ApQsHad76N5uk0FVIeQ
         XOgho+TnDwQp+wZ4yl12nE2DaUJ3k2H0vIxFymZ5zJp12YDsYK7kwtU0iKgqDNfp43LS
         hykU/fItocE3r0KL23JX7Y+KpkfwVu9U8ttXyvKRbbdBqnc6W1iOeRhod/MOOEKd6oHX
         3A4Pujp09GZP2/MxVV4voKLUHO7Kb5oneySMSLgeaWxUScEOvw/9qoy1FCCSamOOZFDR
         K0KVEgs2AlSAq2m4XeTqn8o6bQ82eCbqLfY9mqqzzkYbW12MpVW2J1wCH6pXsSuWKyNt
         qdLA==
X-Gm-Message-State: AOAM531hHGlhlwryY1V0BFm0aR4flWmjwlWaglCCB4OpTjj5bRS4KCv8
        Rn1pz3V66K9E4vsb+lfoNSpYPtAFd4jqjE3Km8MIhI13MLxWXLt8FwpyiSt10Cog4ETo9MC778t
        VQwxS8AdFmI4bqOq09uVhZ8wKeFhUVLGk8Twqsg/E
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr320661pfu.312.1596536298838;
        Tue, 04 Aug 2020 03:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsE+Fcirt/qLaliPJjElSz4ZKTaaDIQH60WMh+u73qbKMH7YGedwDZUr3UiAQLoAb4EXty9A==
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr320636pfu.312.1596536298468;
        Tue, 04 Aug 2020 03:18:18 -0700 (PDT)
Received: from localhost.localdomain (111-71-32-223.emome-ip.hinet.net. [111.71.32.223])
        by smtp.gmail.com with ESMTPSA id g15sm15578674pfh.70.2020.08.04.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:18:17 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: rtnetlink: make kci_test_encap() return sub-test result
Date:   Tue,  4 Aug 2020 18:18:03 +0800
Message-Id: <20200804101803.23062-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200804101803.23062-1-po-hsu.lin@canonical.com>
References: <20200804101803.23062-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kci_test_encap() is actually composed by two different sub-tests,
kci_test_encap_vxlan() and kci_test_encap_fou()

Therefore we should check the test result of these two in
kci_test_encap() to let the script be aware of the pass / fail status.
Otherwise it will generate false-negative result like below:
    $ sudo ./test.sh
    PASS: policy routing
    PASS: route get
    PASS: preferred_lft addresses have expired
    PASS: promote_secondaries complete
    PASS: tc htb hierarchy
    PASS: gre tunnel endpoint
    PASS: gretap
    PASS: ip6gretap
    PASS: erspan
    PASS: ip6erspan
    PASS: bridge setup
    PASS: ipv6 addrlabel
    PASS: set ifalias 5b193daf-0a08-46d7-af2c-e7aadd422ded for test-dummy0
    PASS: vrf
    PASS: vxlan
    FAIL: can't add fou port 7777, skipping test
    PASS: macsec
    PASS: bridge fdb get
    PASS: neigh get
    $ echo $?
    0

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 9db66be..7c38a90 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -564,9 +564,12 @@ kci_test_encap()
 	check_err $?
 
 	kci_test_encap_vxlan "$testns"
+	check_err $?
 	kci_test_encap_fou "$testns"
+	check_err $?
 
 	ip netns del "$testns"
+	return $ret
 }
 
 kci_test_macsec()
-- 
2.7.4

