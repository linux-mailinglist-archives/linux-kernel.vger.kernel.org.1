Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7C2D211B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgLHCso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727807AbgLHCsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607395637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4svAT51jDNn90VCBgpKJLgnxLVTUryttpZeaTRRqYeU=;
        b=OQQuDDm8+PbT+q3ACukN5MPZqq45PbhUFdFJMpUXWCewOBJ8oaL+fPo422OPluDQIJJWI3
        Jpe2+bBhTpzC08Y9mrjEIVpkA/3tSA5z15TBalKidq5VvBVRgMpUlyURMv3rrro7dQy+Yd
        Xg/GPE31BTZQj3MwzyuYittcxei6rAU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-_5cVDsx7MF-z4vFmEB1zSg-1; Mon, 07 Dec 2020 21:47:14 -0500
X-MC-Unique: _5cVDsx7MF-z4vFmEB1zSg-1
Received: by mail-qv1-f72.google.com with SMTP id d30so13262592qvf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4svAT51jDNn90VCBgpKJLgnxLVTUryttpZeaTRRqYeU=;
        b=FyQ/SpEt0YWPBGU0JV4A4WBgPkhl4Iyp+870ao/SaaqgHwW2tCeU0MOEE4e8Putnlk
         L7MaA9a/OdKm1+DOT6pcvex53AIq0IlSIWnG5xDd/IjgoLmkHoKdj0ghwvnJEMfp0M78
         m+4KRLCYW1hDAY9FIbXDy0zXYQQoGag7O6ZqLfWfrH5wRm2Y1kQsg2UgbrICqsCuwpjC
         V1xLErawwSvS01+NpP8P2TgGdkXKuogoENRZVstZp7eD57Ehb42XdM4EZYkdOAOdZr0L
         /vX8C5dYzGcLis+3OihMq2q54k1G/Uwnga/Cz8JSreYHfajuUfWc2A7ErSELlu7FX/Py
         zuGw==
X-Gm-Message-State: AOAM530E1fS+Ph3xlPooguZXTZYgyZE/04d80NnFzi21wY02iYJc8rDl
        MN0d6aBvoECDVcmK6QooV5XK+tVI1aqfKNfePPOQe8PO9vyVB1HJOipwVU8DDtBZdFUqpNwBC4D
        y0NW83Pw/mMnOUmtD88ulc7F3TC/Np3/q5kf/+olAqQau9EFW4xN5whE6qQiNr+jEZhdraP65/Q
        ==
X-Received: by 2002:ad4:476c:: with SMTP id d12mr11834408qvx.20.1607395633533;
        Mon, 07 Dec 2020 18:47:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfh3P7dY6eaeMmnsALY89l8oHv/XvtnKQ7OrAk09h0yrFjsDvtejpvLnKib5sgRda+p8FG0w==
X-Received: by 2002:ad4:476c:: with SMTP id d12mr11834390qvx.20.1607395633255;
        Mon, 07 Dec 2020 18:47:13 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id n95sm13778744qte.43.2020.12.07.18.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 18:47:12 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/3] userfaultfd/selftests: Always dump something in modes
Date:   Mon,  7 Dec 2020 21:47:07 -0500
Message-Id: <20201208024709.7701-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201208024709.7701-1-peterx@redhat.com>
References: <20201208024709.7701-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BOUNCE_POLL is a special bit that if cleared it means "READ" instead.  Dump
that too otherwise we'll see tests with empty modes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 61e5cfeb1350..31f470d12d0b 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1230,6 +1230,8 @@ static int userfaultfd_stress(void)
 			printf(" ver");
 		if (bounces & BOUNCE_POLL)
 			printf(" poll");
+		else
+			printf(" read");
 		printf(", ");
 		fflush(stdout);
 
-- 
2.26.2

