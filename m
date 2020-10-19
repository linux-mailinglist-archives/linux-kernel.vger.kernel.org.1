Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8E292D39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgJSR5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728897AbgJSR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603130260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xiF6inCaAJw3ARp/gHhvEnKHYLKp9sFsuYCI0KYkIC0=;
        b=c2PHxeiHiTlkOaJKyDbcVDSiN+bYYg9fUPg9lDBibWp7xgHxUfeudIqE1DKYeZaJpQTPql
        3qbQ5KQzh2BipnpL6zv0gUXF7P5IxD1uG+QBRTF+j80wAdkDt0zx2wwXwjN7nHTk9/LYEz
        oaQ5VRWK4sYColI128wAvSNWaaz/jQ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-YBmzNwSpO3ObwggoWrhefw-1; Mon, 19 Oct 2020 13:57:39 -0400
X-MC-Unique: YBmzNwSpO3ObwggoWrhefw-1
Received: by mail-qk1-f198.google.com with SMTP id x85so201767qka.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xiF6inCaAJw3ARp/gHhvEnKHYLKp9sFsuYCI0KYkIC0=;
        b=h+Sj5FK1z3ayNEJIeE8uXXrTbmBjhw863bAwLUU/zQZDcYCWzLbcljIwhaulBlLvw9
         6y0VEA2LZgGJrfAbIHJ+Vy+TLpClJ8qhsfGCqPj+7Z6CXR0npasBRGoZzaC2Twt5SU2A
         PRaYHEKjXCmUP+5GSiMQ2SOvoaTuWyuwwQOoUxJ22+1LJyjVCPHvij8Ui3l2ZqsWfkIk
         ks/3NQ2LKX4ZNFQ0/L6Y1xxXuu/xo9XPsayJrSBfW+BWc7bbqSVbTKIm9GsCti1x60Ll
         dzLURNgfn0UUpp0Ypt7P715NxD8AelkD+jzu96sYaCcGplc/c2pRpvSQg8Ns78F5syyh
         tT5Q==
X-Gm-Message-State: AOAM533Z6WG8EPDD7snGQ+MM59DvR7rynFm3YYNlZnN+Yj+iBDElBr8T
        KpiC6iK8hI6H/5g/VdrXinC/5Tl7oLjb42ELrAeiBol/LsNA0vb3UwSmTWqxS+Kcgmo5WIca/4+
        /2O80oTdNwgKH7AgoJCssdbpl
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr636518qtb.284.1603130258453;
        Mon, 19 Oct 2020 10:57:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwjiNv1Xl3x/Va1x9EblYHVk7lhZ+z/AYxaoF7BYg3ratsvOYSh19/lszAmlmCc8qgBabCtQ==
X-Received: by 2002:ac8:5bc2:: with SMTP id b2mr636414qtb.284.1603130257094;
        Mon, 19 Oct 2020 10:57:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d129sm308466qkg.127.2020.10.19.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:57:36 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: nozomi: remove unneeded break
Date:   Mon, 19 Oct 2020 10:57:32 -0700
Message-Id: <20201019175732.3289-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Add explicit fallthrough

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/nozomi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index d42b854cb7df..861e95043191 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -414,11 +414,9 @@ static void read_mem32(u32 *buf, const void __iomem *mem_addr_start,
 		buf16 = (u16 *) buf;
 		*buf16 = __le16_to_cpu(readw(ptr));
 		goto out;
-		break;
 	case 4:	/* 4 bytes */
 		*(buf) = __le32_to_cpu(readl(ptr));
 		goto out;
-		break;
 	}
 
 	while (i < size_bytes) {
@@ -460,15 +458,14 @@ static u32 write_mem32(void __iomem *mem_addr_start, const u32 *buf,
 		buf16 = (const u16 *)buf;
 		writew(__cpu_to_le16(*buf16), ptr);
 		return 2;
-		break;
 	case 1: /*
 		 * also needs to write 4 bytes in this case
 		 * so falling through..
 		 */
+		fallthrough;
 	case 4: /* 4 bytes */
 		writel(__cpu_to_le32(*buf), ptr);
 		return 4;
-		break;
 	}
 
 	while (i < size_bytes) {
-- 
2.18.1

