Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5C2EC33D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAFSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAFSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:30:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC7C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 10:29:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d187so5573214ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=vqdOFJEXH8f+fWCwR3dVWB92iRCynRAkA1NtJxXRz/A=;
        b=YLTV+pfKZtX4PnvgyYfIm7AKkd+zJg6rQm0hn3UsJKVjIVUqVkobDIO4IiP3t3uAD3
         kZncdvXLNjVrvLkj9sin8sPSyAzP3XzgergppzkoKUIlymdw1zHGmWNCrF7qFJJ33ut7
         PBma0K+U9lS/Q6lVYkJBpgFKEBHPoJBLFVJsptKWGFw7r3Arac0hlvZvA9jgUZC7lg+c
         quaw6kejs2qmJhrvGePvuta/IjVaKQd2Z5f5/9fFEWCj1Xusvp+aVQkty6wC1f2iWUfB
         OMMbyazcLEzq6hHKPTYdBmdbQC7ImUf6URxaNyjNguX5oNwrzx1b6sJdB8ZFZ7hOdMnO
         gUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=vqdOFJEXH8f+fWCwR3dVWB92iRCynRAkA1NtJxXRz/A=;
        b=Yg5k1EMEhugQ5YZS+87Y2+oP557wi6ObCPTEW1534OlBz6LEAQpbVKrmUT8huKqbTH
         2uC48PU2y4902PKHcC7sMb8fUoRvq7xcyBRTEb012s0pPd56xXxi24zvgMURq5j8+01/
         +vF84v6Qx23XyR3zoX/PCLB7vNFXLBUULRTf+2a1T+oa1FVBjC6oJcOLMENuX6TC4N9x
         i8Fh4NaCAZKhrlCqeBUHoLQ/SmHjvAOAR1LhZ5f1c7p7Im/ww+6QWjf+SQshBFskePDU
         GOMcDVlHgMWPfvbGQV8cG1OcLDtxA0l/9Zu0v57Aetf8xbOH3JE3ed1WEM+aq9pBd6+W
         4Yow==
X-Gm-Message-State: AOAM532tWvEhHPo3uV153QSf4ZQkHsqbBZ3l8nMnmNelX5yTevqEXiSG
        fmaYjje1UyRRlc9N4ij0+SuJoIsi+VY=
X-Google-Smtp-Source: ABdhPJy5Nk7Cr77AbZRfg3A9DCxnmvwiVFW2DlCrmtDO9UTWOO6MrKn3bHVaX4hQ2C/j3ZhAmWVRREMR2ac=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
 (user=seanjc job=sendgmr) by 2002:a25:6981:: with SMTP id e123mr8170015ybc.194.1609957763232;
 Wed, 06 Jan 2021 10:29:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  6 Jan 2021 10:29:16 -0800
Message-Id: <20210106182916.331743-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] MAINTAINERS: Really update email address for Sean Christopherson
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my @google.com address in MAINTAINERS, somehow only the .mailmap
entry was added when the original update patch was applied.

Fixes: c2b1209d852f ("MAINTAINERS: Update email address for Sean Christopherson")
Cc: kvm@vger.kernel.org
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1e45c416b1..9201e6147cba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9776,7 +9776,7 @@ F:	tools/testing/selftests/kvm/s390x/
 
 KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
 M:	Paolo Bonzini <pbonzini@redhat.com>
-R:	Sean Christopherson <sean.j.christopherson@intel.com>
+R:	Sean Christopherson <seanjc@google.com>
 R:	Vitaly Kuznetsov <vkuznets@redhat.com>
 R:	Wanpeng Li <wanpengli@tencent.com>
 R:	Jim Mattson <jmattson@google.com>
-- 
2.29.2.729.g45daf8777d-goog

