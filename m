Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7995F2D6F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 05:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405321AbgLKE0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 23:26:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32805 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405320AbgLKEZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:25:10 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1knZym-0001Qs-3z
        for linux-kernel@vger.kernel.org; Fri, 11 Dec 2020 04:24:28 +0000
Received: by mail-pg1-f198.google.com with SMTP id g24so5613734pgh.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 20:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tPXZ+7QAQmRj9Gg0uL9q/qwGUoI81azIs/Hz+gXLnNo=;
        b=q/h4MAl9WyLygIkJBn9tIER5z1fd3T0hDu77aNM4kgs9msydQn69e1i/WgWbJZuLBh
         o9UxZP2RmSC5btHWQYDxAeYu8jZ1J/e40Th3zV2cjSVtelWo3u7PbNrXTs5ElPw8VDnA
         NKPAdNarQueJa0uRZgWO7LmJhtNG81LVxC/gX1NORxpFcNxE901q/rznLo5GMD7GFqNw
         bDmiAggSiUq/b+ytSSMDOIesVUNPIrNb/vTns82GVOzaESUsvZdVplfo4QZHC3O9xeL0
         tJ8bGEj6NW0T5MoeLpZKLf63A0vEonmXXDsXECQg8ctHMRQBEBOvub+4D/elf+lmqGYq
         8Y3w==
X-Gm-Message-State: AOAM533eWZF/PMm8rK4iIRzWV1YnUyBYljl/kCor6v+3y1j6klYpg9Wt
        gIMIHNVP8CNQlZnlOOCJrcBB6y9y2lT1pvzQtIQrbz/1qNxFfHWP10uiM9hoF/7pjd0Eg+IfV4t
        WPV/W0vxQq1wxvT7nrRAs36481kDThC6XAZZ2zKKT
X-Received: by 2002:a63:eb4b:: with SMTP id b11mr9849637pgk.351.1607660666845;
        Thu, 10 Dec 2020 20:24:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyITTeGHkWP6edOaQgLt1ofgM+1Ufy7TeSzXSBK85/VCt82D1wcKgDJYTgmykOnGtzogKj/Sg==
X-Received: by 2002:a63:eb4b:: with SMTP id b11mr9849621pgk.351.1607660666556;
        Thu, 10 Dec 2020 20:24:26 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id m26sm8241810pfo.123.2020.12.10.20.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 20:24:25 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, po-hsu.lin@canonical.com, kuba@kernel.org,
        shuah@kernel.org
Subject: [PATCHv2] selftests: test_vxlan_under_vrf: mute unnecessary error message
Date:   Fri, 11 Dec 2020 12:24:20 +0800
Message-Id: <20201211042420.16411-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cleanup function in this script that tries to delete hv-1 / hv-2
vm-1 / vm-2 netns will generate some uncessary error messages:

Cannot remove namespace file "/run/netns/hv-2": No such file or directory
Cannot remove namespace file "/run/netns/vm-1": No such file or directory
Cannot remove namespace file "/run/netns/vm-2": No such file or directory

Redirect it to /dev/null like other commands in the cleanup function
to reduce confusion.
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/test_vxlan_under_vrf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/test_vxlan_under_vrf.sh b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
index 09f9ed9..534c8b7 100755
--- a/tools/testing/selftests/net/test_vxlan_under_vrf.sh
+++ b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
@@ -50,7 +50,7 @@ cleanup() {
     ip link del veth-tap 2>/dev/null || true
 
     for ns in hv-1 hv-2 vm-1 vm-2; do
-        ip netns del $ns || true
+        ip netns del $ns 2>/dev/null || true
     done
 }
 
-- 
2.7.4

