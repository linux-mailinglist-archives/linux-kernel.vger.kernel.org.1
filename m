Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3322C6B98
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgK0S3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgK0S3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606501753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KRF8S0dPX/GnO/XcafgjJXGQUweQMcg89DFReh4493Y=;
        b=VskClAYZ7Jvbgn7/So2tsBvPiiVE1xUlPxo+FCFWfqs3V6iV5kqIXFy9zRXzl9BX4nFvDN
        3XPOLKhhXoj/2JwsqLEILaV7Er0Zszb7c7f2yg16KzYTibq1wqAAUEFHzKu0A9TT1H+PvX
        uH1XP7MjGXIBJu1gHoukRwFOi+cSges=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-gTfq9z-RMUCbkYzCJvJQeg-1; Fri, 27 Nov 2020 13:29:12 -0500
X-MC-Unique: gTfq9z-RMUCbkYzCJvJQeg-1
Received: by mail-qv1-f72.google.com with SMTP id ca17so3514336qvb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KRF8S0dPX/GnO/XcafgjJXGQUweQMcg89DFReh4493Y=;
        b=Tv6DBNJOnhrrdmSzI4SmKh0P490H9sDFP3ZnzCN9t8Ct6ToZRHI1Pcb5lMMh4HXnAU
         F5Lu3BGbkL5Xw3Js/k2a17iLpVGAbbsPY2G7zDV0NTw+hoF5gISfP02qyWNyfVu8PuBA
         yV7Om2eb0IzxbAWoXSpZyWkjv8bZajBa9YKY2OBhLXX330/9n6DZHzevFugOOHNoL4uv
         38AYeSTwLLqsGS9uZV673181SIlPZTql+q8tjF1c6CgrEsCj7D6Tgd2fu2LYXHXRj3N7
         C7Uo51dtHnU5VkwaTZcWhP+D80EadULKgIn2hfu3KwOgaivW9Z4x3Xi3DWnRZNNxeNm+
         J9fw==
X-Gm-Message-State: AOAM532PHK0dedkC+oKBYt3H35QCioVFmyb+kVgorA2AhA6Fp2DmC9Vd
        0Ylt0aJzkbY92yBYXRvby8/5Kk/fjSkxkLOhFq27qxAGRLKnTjSiqglkoOtlowuq4YAfyWyE8DX
        UkFYy2Ulr6gEPgW2cAZ5LfI+S
X-Received: by 2002:a37:a70e:: with SMTP id q14mr9726579qke.337.1606501751590;
        Fri, 27 Nov 2020 10:29:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhGu1WOKP8stMJVEMLMTtWyPaoBWByx3eRAF69XSEmQNhq8pMQl84V5cYetxnsIlV6rRdJCw==
X-Received: by 2002:a37:a70e:: with SMTP id q14mr9726560qke.337.1606501751419;
        Fri, 27 Nov 2020 10:29:11 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y44sm7437555qtb.50.2020.11.27.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:29:10 -0800 (PST)
From:   trix@redhat.com
To:     willy@infradead.org, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] [SCSI] sym53c8xx: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:29:06 -0800
Message-Id: <20201127182906.2804973-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/sym53c8xx_2/sym_glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index d9a045f9858c..f3b3345c1766 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -1001,12 +1001,12 @@ static int is_keyword(char *ptr, int len, char *verb)
 #define SKIP_SPACES(ptr, len)						\
 	if ((arg_len = sym_skip_spaces(ptr, len)) < 1)			\
 		return -EINVAL;						\
-	ptr += arg_len; len -= arg_len;
+	ptr += arg_len; len -= arg_len
 
 #define GET_INT_ARG(ptr, len, v)					\
 	if (!(arg_len = get_int_arg(ptr, len, &(v))))			\
 		return -EINVAL;						\
-	ptr += arg_len; len -= arg_len;
+	ptr += arg_len; len -= arg_len
 
 
 /*
-- 
2.18.4

