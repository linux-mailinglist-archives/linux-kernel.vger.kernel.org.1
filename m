Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E82A5AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 00:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgKCXuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 18:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgKCXt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 18:49:59 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88843C061A48
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 15:49:57 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id i2so12122020qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=98B4SMJScchAYm+B6VeRF0sz9ED0V6CnMu0GP5al+Qc=;
        b=exOaqDLOfoClAUwauo3IbRppRPEo5nM49bRF28fseKhJJm/Vr3lG5gwejDPIqnACdI
         vlaci54e+uabnSxBoIcyaRAZhnPv9xAXUqvD1IM/YWC2If8fAZqvhzoowRuwx0IMVopx
         vERacFX486czDrnuUGzzdYild34lX77YJgfWSjHn1o7GPm5AO4hZyCzXb2CiWLEoNLhp
         1UWPt3mJZwIIqL3RbbPrrO6Dm9aqHm/RLtEQUyvNu0woSNOOQ6vZwLFLs7/KhIm30rIu
         lMtXwQCV62ac2oRaZeVvlxGZSqYcxFMsvIZBGoNjhe3w43lm75hbSQFpeAVj7kHUbcrs
         xwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=98B4SMJScchAYm+B6VeRF0sz9ED0V6CnMu0GP5al+Qc=;
        b=DLf69rdAvnFn7LAuFrQZ0lyl8hDUvTs9HDazbFQpYmRGPZ11nijz3FBDaeNlq7dU+7
         F6wVtMUnFtoajCw2HSuTHXaC+R+ZJPaBlaKHf6EGluii53xjg4XEA2qQU+LuDOfumUaM
         NhkAYS4vypodpp9n7nhpTr5VztnnCBx8ZF0DmgsmR7/KQYfTOW4YQ8o/KwLxUAc0FkwV
         b9AvZfFcaRIYo3Qha4K0HINmIgu0KkLVC9OkITRxMRb5TKtodubFCVQqjbEUy4B6xeI9
         FkeK4cYdXTeNJBs8ABZoJhFglfkvmSTVOxdYK0+uEpPRB0ZHTJauftWNNdGdsFaNo6xE
         IEkg==
X-Gm-Message-State: AOAM532WsJ7uOYhpHFNYwRQj0A5Tl5msKx63UhVwRSwVS1fRLmS6rEHH
        UyphummURGZwzL6h/emuGCqtoJhrXJUAT+e5tT6I5JhjqQc6N4naFQfd/6XqVSShoVxNqmIkK5v
        OoArQDzJr6moVJVjYqyW1UhCgbmbw39Vv20hsBlE1saCUZp/DIsVc7uK5yIPTNa6OwQHZRZJy
X-Google-Smtp-Source: ABdhPJwdPlntaN4XG640esGJzdQigZ7OVKF00zfcBH1ziXGQ9hFnDsNIjLMsak1eZpUdbPEV6qSE2lSBfYJz
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a05:6214:951:: with SMTP id
 dn17mr30174501qvb.9.1604447396571; Tue, 03 Nov 2020 15:49:56 -0800 (PST)
Date:   Tue,  3 Nov 2020 15:49:48 -0800
In-Reply-To: <20201103234952.1626730-1-bgardon@google.com>
Message-Id: <20201103234952.1626730-2-bgardon@google.com>
Mime-Version: 1.0
References: <20201103234952.1626730-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 1/5] KVM: selftests: Remove address rounding in guest code
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rounding the address the guest writes to a host page boundary
will only have an effect if the host page size is larger than the guest
page size, but in that case the guest write would still go to the same
host page. There's no reason to round the address down, so remove the
rounding to simplify the demand paging test.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 360cd3ea4cd67..32a42eafc6b5c 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -103,7 +103,6 @@ static void guest_code(uint32_t vcpu_id)
 	for (i = 0; i < pages; i++) {
 		uint64_t addr = gva + (i * guest_page_size);
 
-		addr &= ~(host_page_size - 1);
 		*(uint64_t *)addr = 0x0123456789ABCDEF;
 	}
 
-- 
2.29.1.341.ge80a0c044ae-goog

