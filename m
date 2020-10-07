Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F13286982
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgJGUyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728573AbgJGUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602104037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=Ym02VTUDIVW6jtI2TI3KasPED6uMQHUSQTbVs4qo3U8z8CyA4SwUNCNb/3bL9qdmWbJUUR
        vIIU8samipp+CeQzzs+5fTOFxWJeLafQ1dwxArscMqqREf5Or37s26gCwGcFVWod2e/JQ7
        zlmYnzad1nO0CVFUGzxrc5AGeTOXq84=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-90yqu7OZNyqY8Wut9FF3_A-1; Wed, 07 Oct 2020 16:53:55 -0400
X-MC-Unique: 90yqu7OZNyqY8Wut9FF3_A-1
Received: by mail-qt1-f199.google.com with SMTP id v33so2238684qtd.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 13:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=mBwY4Q1ibpcRxQ6B75ofTMwqBL/L9anaUqVeUqA0W5NI4d54H/0/NMLErhoSuTTb5f
         RHBdHTEkhIAkY51dBO0Ug1BeP8WzbbMPsYVPHy6Nj/y9ryhJLcomsI8Sl82oz1bUtK/k
         gLP+2FeCDvUDkZu+cpuI7S3HgZaEfC5EjUFNUVG4c7Ks5M/rYtIkO4X9wvSZJLTVF0IM
         f3qit6QlF4xLx39xUEa+gXZsZuj40UqzxEnKhi3uZFQgNgvj35a6pzLQxNuISrclqyLH
         DPp75BhJifRXmfBhfdic+j8XN5YJPsrv1btLPMjXdm9xBQ0K9p6AhtefMnPh1G2rrLos
         692g==
X-Gm-Message-State: AOAM530LAzJ5SfxhilyLR6Iw6z6CuWKEwmUpm0WAVlhHBnDQd3OflxyS
        YawKNn0YcU9HPBBv1hCaq9TOPz5Z/Uux6eSgKsfntfTZ6V3S0RGpMttyedF71PHWbYXSegyyyXF
        vLiHWWrGsiWKDxexD9Y5UvbL/
X-Received: by 2002:a37:b85:: with SMTP id 127mr4733457qkl.230.1602104035035;
        Wed, 07 Oct 2020 13:53:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNUecZBcDoami0FgrEK8uMvljBkI+3Br5QGNDj7PWgW8PdPE9toF3hper1BbPd65eaXmNpRw==
X-Received: by 2002:a37:b85:: with SMTP id 127mr4733440qkl.230.1602104034781;
        Wed, 07 Oct 2020 13:53:54 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id j24sm2390695qkg.107.2020.10.07.13.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 13:53:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Jones <drjones@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v14 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Wed,  7 Oct 2020 16:53:36 -0400
Message-Id: <20201007205342.295402-9-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007205342.295402-1-peterx@redhat.com>
References: <20201007205342.295402-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
clear it for us before copying the dirty log onto it.  However we'd
still better to clear it explicitly instead of assuming the kernel
will always do it for us.

More importantly, in the upcoming dirty ring tests we'll start to
fetch dirty pages from a ring buffer, so no one is going to clear the
dirty bitmap for us.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 752ec158ac59..6a8275a22861 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -195,7 +195,7 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.26.2

