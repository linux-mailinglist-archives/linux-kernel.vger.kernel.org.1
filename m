Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A94292E59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgJSTT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731271AbgJSTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603135197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/UNHIosp3cVAd663F6tCAJF4cHtF8pw7KZ/KpFqhcKs=;
        b=BhZXJVn3z9usHymloracMKQU2GafI+gt7l0LSXGUjjZDLa9STtJ2L/QKz2FFn62a1gGnbA
        Umx+idm+yoSCIMZEin9puyP//5q2wg9F8mevNsjT8u3WmtILNzqwU3HrvPpaRhecpsjyr5
        tColAHV66S3hOquIEr4fkQAm+hvpC3s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-x_eGHvUrMD2zhNO_H-jfpA-1; Mon, 19 Oct 2020 15:19:55 -0400
X-MC-Unique: x_eGHvUrMD2zhNO_H-jfpA-1
Received: by mail-qv1-f72.google.com with SMTP id i5so604546qvr.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/UNHIosp3cVAd663F6tCAJF4cHtF8pw7KZ/KpFqhcKs=;
        b=ZjhGHmTncM/pLtr8Tb7MnWBCZ5+Yv+X6R9lMYxMWqym0NpBrV8J+pRe9r4+khWMkdL
         zcxWcOwJQNtdFtq1xGjaGckqFxMAVhE8glSykfFHMnuXO6Ep5ZOWkMJaNE5KKvdLXgwM
         Ru69QWS9BjLUBu/03TLCRAoh0vKpCWlR1CM5uwTHpLISUKoU48nefgdlUK6SKokKU6Eg
         ZWT9zvfettlhLJVCl1U8zyUHkpfaC4e7dox0hV2tpNQffA2OIidTrMOM4Ty54A+r7/+2
         9A4yW9lef+8Pw7eMWjrWLQlI1hOlpD0ORV/Rsqi1DpmrpkmuzIs58EFjMIe7jG21wnJ0
         Q2iQ==
X-Gm-Message-State: AOAM530W5mGCc6EXfJk2td9vSByz218b5qz6C1CICBS5Gsuh9ftv3Sre
        1oFgXnm5q3vVqbebbXLJfg8UcN6WrBkzOMbsQeON9/Ss4LwFTgh9+7Yt/vrW0fqDOXGejiVNFYi
        P/5kURAtxF0FMm7pdeNhHqyw+
X-Received: by 2002:a37:6413:: with SMTP id y19mr1105750qkb.139.1603135195102;
        Mon, 19 Oct 2020 12:19:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD9hU21lIF+UvW612n9VgAUffmmpNI98WIqFKfQDD/JnPE1dbUHJMvrnlN3qtwZcUaGgWnbA==
X-Received: by 2002:a37:6413:: with SMTP id y19mr1105726qkb.139.1603135194792;
        Mon, 19 Oct 2020 12:19:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f4sm352036qtd.35.2020.10.19.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:19:54 -0700 (PDT)
From:   trix@redhat.com
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] message: fusion: remove unneeded break
Date:   Mon, 19 Oct 2020 12:19:50 -0700
Message-Id: <20201019191950.10244-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/message/fusion/mptbase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 9903e9660a38..3078fac34e51 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -473,7 +473,6 @@ mpt_turbo_reply(MPT_ADAPTER *ioc, u32 pa)
 			mpt_free_msg_frame(ioc, mf);
 			mb();
 			return;
-			break;
 		}
 		mr = (MPT_FRAME_HDR *) CAST_U32_TO_PTR(pa);
 		break;
-- 
2.18.1

