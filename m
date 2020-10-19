Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51587292EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgJSTu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbgJSTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gurUpVJY92BNatRtGPJGA4twsuCjo97EHFL7kW3iTCQ=;
        b=XLnTGFYerF/s/BWk8RQaN5NFGSPyz+4u9C42+qylp2Fd0ZDvSecOn6J+WAONYWf8Az6dcQ
        lo/F31Qc84MceTqC8qsCQMMUJ4ZWI6D5LDqMkmALTEFOFbv8kx69Ja8cxiH05G7s7bw8gf
        XcINTp0MxzByaC8JRpEcNmN9ssII/bE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-bTTapj3ROkSE3QJiOh-7Qg-1; Mon, 19 Oct 2020 15:50:24 -0400
X-MC-Unique: bTTapj3ROkSE3QJiOh-7Qg-1
Received: by mail-qk1-f198.google.com with SMTP id j185so530500qkf.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gurUpVJY92BNatRtGPJGA4twsuCjo97EHFL7kW3iTCQ=;
        b=RL6HEAzroW0zjVSk6N6Zh6CPTUnORCegGyO5YE5Fxnpg8DTkW0m810jtzP21LpQFah
         QvJtI+LG2CHwK1f7kmikJUsQ7sJn6wmIwv5m5VJvaM6+ctaW5HM7pM9qRNydrThwFavf
         o1i6JYn/7oJs6bHFndEx4LDb3+3H18QNcHeGgIxzPnK1V89kut0K29aUqky5YKlliNah
         SFpG7AVxXcY6jOpqi415u8ao5wzZ4hTt0mPWYg/ZKO30j4jDPub3iDa+/liu4ZyPj/Ea
         YI7xeTKn/GFcB/hPKqqfc/onqf0r+akzHUfNKZjB3Na/6+SJhnsa5Xxa0jkvP6z02o5U
         9H6w==
X-Gm-Message-State: AOAM533dE80U2hLnz7o4/Cs9m2aTdfWqvSkoGYGEgaumNrTVWlDFz6Hm
        eSO5g4u5Ig3VkhSQS7WGhw1uQJnBQyZZr5Qo90VOHUyXJGp/OQ6UFJxoXN1uQst8Z4UcNYZmZzy
        mbxepzMiwbL0c6gzddAydeekI
X-Received: by 2002:ac8:705b:: with SMTP id y27mr1114111qtm.192.1603137023758;
        Mon, 19 Oct 2020 12:50:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvDlls0C3FPTa4CLaTFO3RK5ocpNR7SlP5iafd30354sGejOe41Jo8FGhAcBQn8KNGmwvqIQ==
X-Received: by 2002:ac8:705b:: with SMTP id y27mr1114095qtm.192.1603137023534;
        Mon, 19 Oct 2020 12:50:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l25sm401073qtf.18.2020.10.19.12.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:50:22 -0700 (PDT)
From:   trix@redhat.com
To:     konrad.wilk@oracle.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] block: xen-blkback: remove unneeded break
Date:   Mon, 19 Oct 2020 12:50:16 -0700
Message-Id: <20201019195016.15337-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/xen-blkback/blkback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index adfc9352351d..f769fbd1b4c4 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1269,7 +1269,6 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	default:
 		operation = 0; /* make gcc happy */
 		goto fail_response;
-		break;
 	}
 
 	/* Check that the number of segments is sane. */
-- 
2.18.1

