Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8002A1EE0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgKAPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbgKAPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604243200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=wJ/LAdUgWk4kj3ikySKt8S3LnfEtd4hd8yxK7w0mF2Q=;
        b=e+nVc+t84qVftpbppVnXtlx5z+wMJ/mbr87wYLttn7u459Ovd0JLVTa89725l7LcV4nEbV
        duBGOgl8KQsnnIGNhXQMFSNk5FuD6gIJ2p82IK2gewvGam8SuscUYROKBtQoRhVkl4vrp1
        zVKd++kJisUnX8c9mWtMC3oz5sDs0Hc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-yqnTJuXVM3qxIjn35wjNhA-1; Sun, 01 Nov 2020 10:06:39 -0500
X-MC-Unique: yqnTJuXVM3qxIjn35wjNhA-1
Received: by mail-oo1-f70.google.com with SMTP id c19so4571194oov.22
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 07:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wJ/LAdUgWk4kj3ikySKt8S3LnfEtd4hd8yxK7w0mF2Q=;
        b=qrS5N35znB5rkRZdTL40/GOZo+T7mIKlZnFU6r0QzXSgaVhR1x/HqDqEV/HJzfpvZx
         1nPEXCcp8sjQeRObYkCRwtodB+A+rHNWerSgMMsgDbSyTnCWbEz1YsJHyQSwH5MIhEIQ
         OJgRG+WHJka0im1xjDNVQM5QwbfjsXCIE1bqD6CtW94QhH2Q3cRVuD/2K8ilq+TtjNJp
         mWOBN7HgahIzuoVYd3Voz6furaQFm5kij6sspzn42HkgJR1H2WIsPnOBP5TL0fBFopSJ
         pKAP0p8Rs23GvDIWW6BIdE1IuuZMwlp7QR/cqYdrVJ3d/ieoXM+efUkytsoDgZqCEQjc
         aAMg==
X-Gm-Message-State: AOAM532TlAidwuuBd/hBuOpG5uDc99s1dR86uG+OiqTlJAMFNJAWI1Iq
        lHi2O6xcLexzSwdK7fXJihwyqZFgYRn7goCR3kySyhbsJLfGsLM14an2CZ19dJtvL+s3dP+AG0M
        2U3DfSuPgqcPRiq53ncnIjs+G
X-Received: by 2002:a4a:dd0a:: with SMTP id m10mr8950424oou.80.1604243197886;
        Sun, 01 Nov 2020 07:06:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi7nrIgHcqXU72cuWS6O0nlS/xTzXubwdfw6WG3TMN7Pod2mwYawFVe8PQCYaME3qcvab8lA==
X-Received: by 2002:a4a:dd0a:: with SMTP id m10mr8950419oou.80.1604243197694;
        Sun, 01 Nov 2020 07:06:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w10sm1598353oou.47.2020.11.01.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:06:37 -0800 (PST)
From:   trix@redhat.com
To:     joel@jms.id.au, andrew@aj.id.au
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: aspeed: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:06:22 -0800
Message-Id: <20201101150622.2288203-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 26db42ef6aae..20a1d4aeb051 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -51,7 +51,7 @@ static const char *siliconid_to_rev(u32 siliconid)
 		return "A1";
 	case 3:
 		return "A2";
-	};
+	}
 
 	return "??";
 }
-- 
2.18.1

