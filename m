Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1928A93D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgJKSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgJKSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:23:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5CC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:23:38 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f21so2949532qko.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0BP0WWNBc1kPJXyCU75zbEA8DVMOc+8VoH03e5lNmc=;
        b=LtWKMuz6P+DE0umPczhi0z+awwBlfeX7mYquTJdHMBzI2l6DhuqaNtswgW0EXIpW1t
         FrqNzm84B5G+9UXdZ8YXV/NLkexMrUvnY8VgpHO3Ffy4Er9lnlpdj8JWxIKOvF3feyQC
         MP3IcJd83eWozW5O+KARYKs8ZyyH0c9nTv/5X+IO6lTCfHHB05fex5CqHILk0yyh1xEU
         43D0bj83cmCpsizk8cgn1cwmPx8a9EFYdklQIAPh3EeKmW9X34X/nIt/A/zCHiZeEc1y
         dwrcX68TDkEMTnQ3tJZ3RPrNxDjPAY5iTkurPCPGvcd/+mr1Y4Tzs4OwJJDLxLnPghDp
         6sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0BP0WWNBc1kPJXyCU75zbEA8DVMOc+8VoH03e5lNmc=;
        b=Lytcn1BdLgnvSlh7uKWTeSwvKOq4veGlDBTHlyWQWc1QbwT4nvTbf7iXPcF3TpgGu5
         k+39cbGgxLO0tTXD1k4X5uDjRpJFi3I71Bt+5ZxHhbaR/rcMhvtraEMNw8E6C4lDR27x
         egd7ywPYlFP81T04/HxPvObEeTgXjeQ2zZdstPxCqT9Nujq4ZJXv4aOgoKeCp9L68MCg
         k9ZhNR0gEu+hSoBQgNLCESkpXNuEHvepl1sLMoBidgVVW/ecyqZ0SlimT/TAXbL63AOp
         AnzyhTWDb7Q582q620JckYgOmfRlBiVjqVjfvdDndjuCg59QSrobsLYFRUQAF88GEgq7
         qiag==
X-Gm-Message-State: AOAM533BkvFSAcoXBRcAYZL2p46uGb/iD7CQ33qYfeysjDGdlUGbuEVO
        pxZVeirzBBtqqnhIz+eY/F91xE77sB2j
X-Google-Smtp-Source: ABdhPJxrviZdh2A/zK6dCqnQ3OiXnqOQ6cEcIdHbmBspQASoQBUnNCitdgI1nx3AK0VnqmHnHChR0w==
X-Received: by 2002:a05:620a:2442:: with SMTP id h2mr6577467qkn.225.1602440617736;
        Sun, 11 Oct 2020 11:23:37 -0700 (PDT)
Received: from localhost (ool-2f10a155.dyn.optonline.net. [47.16.161.85])
        by smtp.gmail.com with ESMTPSA id t35sm4250136qtc.80.2020.10.11.11.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 11:23:37 -0700 (PDT)
From:   Samuel Hernandez <sam.hernandez.amador@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org,
        Samuel Hernandez <sam.hernandez.amador@gmail.com>
Subject: [PATCH] rcutorture/nolibc: Fix a typo in header file
Date:   Sun, 11 Oct 2020 14:22:31 -0400
Message-Id: <20201011182230.25602-1-sam.hernandez.amador@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Samuel Hernandez <sam.hernandez.amador@gmail.com>
---
This fixes a supposed typo. Before this, the AT_FDCWD macro would be defined
regardless of whether or not it's been defined before.

 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2551e9b71167..d6d2623c99ad 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -231,7 +231,7 @@ struct rusage {
 #define DT_SOCK   12
 
 /* all the *at functions */
-#ifndef AT_FDWCD
+#ifndef AT_FDCWD
 #define AT_FDCWD             -100
 #endif
 
-- 
2.26.2

