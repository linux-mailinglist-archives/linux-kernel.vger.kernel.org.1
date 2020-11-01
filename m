Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5B2A1F14
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgKAPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbgKAPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604244644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ng2C8bOdfypGJPdZd9Hy+rwWhjBkyur/122cQ3TG0CA=;
        b=AF8VV3pq1GrSBfMocQD74g6f6oJnTM51fASgJSEINBbLn9lb1k/xJyVRu9AW06wEEvLTrM
        kLX2goA6ZJtcbHyG8xaMMu547gmWf7K5UlWHHUu/gKmouLd/avC26kfkNelFBhRPGqBIXo
        WssOTDrZ9Jf9S5HzF5Cv8gnsFKVKCXA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-tURNUPc3MkuarlxWOkLM7w-1; Sun, 01 Nov 2020 10:30:36 -0500
X-MC-Unique: tURNUPc3MkuarlxWOkLM7w-1
Received: by mail-ot1-f72.google.com with SMTP id y6so3296601otg.16
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 07:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ng2C8bOdfypGJPdZd9Hy+rwWhjBkyur/122cQ3TG0CA=;
        b=ZYCL8QKuu7vez300sdBaMRsIDWHF+gLFy1C6XutZMPP2Chre3lSKVtNjxU86kdI1i9
         WRh0N3Uatvtx9MbFSiaHkB0VXYVwi1FJiRWQ/8LjuieWMNXbVEC5Qjq1FqC2LGS6YODj
         eV3ViLxUa4FwAxyoZrzuHi1aS4HXZZr5O8bSayBRw8NWYhQYnwLOE5Xrw0mcfCuyAk/g
         AdUBLrHLOtt3VHHalwTEy4P/ZQAiwaLqDJ4SiEp0OT0gv41lb5n+AWmPtb4u/VwCstfa
         B/K1gl1YpFm5uH2G2zsuv/IWtUz6o0QBvAdT9g5H6TmX48WFsqjYec5fZ8+iJaz8xmpu
         WUvQ==
X-Gm-Message-State: AOAM53181Ki5jSqYG3ICCXaMolnOgOEvJvehs+dvTP03siURl7A/Ect/
        Rsr+/pcG4xb/JjMR3RsPVq6X/j5euqjk4Bzc95PQY8vRz0RpvPgD2YkWxt9a/9Mqt/i1+IMazJX
        M2h+jQpFXL8Q6oZuHZmhhdj77
X-Received: by 2002:aca:1706:: with SMTP id j6mr7426080oii.82.1604244613404;
        Sun, 01 Nov 2020 07:30:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyc1EOdJdxYjg8nac4JwcA5GeWvi0QxXD1i9zdWiH6oy+lfa0NghV44C+xUR40uU3g1Pgo5BA==
X-Received: by 2002:aca:1706:: with SMTP id j6mr7426072oii.82.1604244613276;
        Sun, 01 Nov 2020 07:30:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 92sm207002otv.29.2020.11.01.07.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:30:12 -0800 (PST)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: sysfs: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:30:08 -0800
Message-Id: <20201101153008.2291089-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..c96ecf951c86 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1207,7 +1207,7 @@ static const char *alloc_name(u64 flags)
 	default:
 		WARN_ON(1);
 		return "invalid-combination";
-	};
+	}
 }
 
 /*
-- 
2.18.1

