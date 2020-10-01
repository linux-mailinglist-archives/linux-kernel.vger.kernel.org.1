Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6C27F74E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgJABWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725823AbgJABWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:22:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601515350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=Kn2rZHzPZoah9M371/OZrGaqOCioMm5Gu+qaes43bz9qZ+DpOnchWeaFQEaK+6NaLvs/+1
        YQiAn2nmg783Lld3DCKGOa2s4HtwbA4YwqtrwJ86oR/a7OafdlxaE+XnVzM67LefqpdJeP
        6ZlI5TyHkrRBknMM3LWTokYz+wfKJ3I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-IEPJEjXaODOHvnNtWXffjQ-1; Wed, 30 Sep 2020 21:22:28 -0400
X-MC-Unique: IEPJEjXaODOHvnNtWXffjQ-1
Received: by mail-qk1-f199.google.com with SMTP id 196so2098042qkn.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ALy67CtgBF8fDQMZT8Ir08uhC8QFjLGT5DkxROP8I=;
        b=I2EyFBLwjg/keujyKNe0XtupHl5J9mamtpyW7RkriFgLGw1phVFFIHjtdUJX/UkHDD
         BzmHYq5PZOYoof+hc8RiH7+MTpz8V0BbvhCYowqCmFwB3YDb9ckvmUatx5j8iqGELk/B
         cjSajfREoI/jrdnNohGxvKEkzy9Th6YVSY7OyAW7o6Io0yzeSvMOFGxPV+3yC5aKbd7W
         HYRA/wtlyNk8njvshHLqCZg3OEYViIsgQ6YHj1BUX5c2vIjfwe7UYK74VVqOBXLBGOHQ
         kIgxTx+umgcSn7qI+KyIAfYkXdrGnzIULA+LrBjgR6R+lKQmOfaEPVdoTcfShnGzcke3
         QJhA==
X-Gm-Message-State: AOAM533TQUfGOfDzHo83xl2nQW99HH6Nbr9kE5rWDrLl2dA65cZMw28H
        dws95hVTVZzRorq4xo1R57Bi2UzeLlMDpgkmNW6PQDc1QQm0JHrF1sIh5xheZcDKdBnz/PshSti
        HO1vTB5ZudYfWFW20Q85XqgkV
X-Received: by 2002:aed:2d62:: with SMTP id h89mr5256460qtd.193.1601515347934;
        Wed, 30 Sep 2020 18:22:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9qiG51yJzzbbV8CDlgt3OtjUOka7BB6YhLzeZuvbNwtq6YsRQsYHzXit7tCeO7Dn84X1xdQ==
X-Received: by 2002:aed:2d62:: with SMTP id h89mr5256449qtd.193.1601515347718;
        Wed, 30 Sep 2020 18:22:27 -0700 (PDT)
Received: from localhost.localdomain (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id f24sm4160239qka.5.2020.09.30.18.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:22:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v13 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Wed, 30 Sep 2020 21:22:28 -0400
Message-Id: <20201001012228.5916-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001012044.5151-1-peterx@redhat.com>
References: <20201001012044.5151-1-peterx@redhat.com>
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

