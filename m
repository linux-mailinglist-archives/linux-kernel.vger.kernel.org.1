Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBF2254B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 01:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgGSXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGSXLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:40 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0ACC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so13028191oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ9r7Kj2JZ78SZKbu2ksaAjGKTUOUIiaxChKdLFlRa4=;
        b=Upq5jsJbyhEgpKW7Pkr+aqO/nuzSbbqBjvUFRLBNio6eEOnfcteoqYD99EDrYTX9I1
         g9LUwxDqpUWkSbPx6RlkcBceJLCnGYsTYXbKaOY8ygqy7Vqm9TrSeyPHg5gUs24KZN19
         tsfYUYxLJPyxpZSN5kqM4jvyWGNjkJPgp04kbT+bNqG+8Ec7SIFDHd/BgJRA5ZcvbMg3
         uj/NKSJ152rOGx61eLMDBWVqfMWbzuYt4DTbVy2DVOOi1IaR88xv0+iPsVKuKHqbNz9g
         97NINoDb99Yn+n2CZdrn9szoQ+e9UwPqeTeoixFjXNiE21r1xNllS+DhMqaCCQo51pjd
         iVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ9r7Kj2JZ78SZKbu2ksaAjGKTUOUIiaxChKdLFlRa4=;
        b=oRx2KIvd+V8YLRAQljM01oUIcA5vxJA93YdQ2NvMsgwloEErMEX0W61T1Xguh74TiP
         ModF0BLFWfL7OaUeMU6I4qF+dSuen92IsnphC66ezDj5lBXc7dpNVKExY0o2jLqKiXR1
         1yTK/mB4T0suyMWtDYO6G8wGwzKHQ5Qn824zW4sPcepQyVNAqB+mv19tAg3v8UkghrsW
         ciEBDU2D07l45KZsKCX/o4aLecOmNEbexgppCo8+8Sf/aqkvPjaXqsz6Pjkzhf881TpV
         vejB0JanmKXT/mbIVUBnzWFVwhO3d82iK8l4FpKdmHQ/63Z+xYmRcnbO2JDh4mz8g8zz
         JuBg==
X-Gm-Message-State: AOAM531C4VVkw2/9NiJuKuh/eQWWEoKEhpI1oyEoA4fyrVkNGsa+IFWg
        VaqnrDDNAhoXmy5Mktq9K7c=
X-Google-Smtp-Source: ABdhPJxzITwpBg2Q2KpgteDgmkYYwJxeKoC4n5bocu6REUkV9/qNB7Dv/YpmzcMT4Xk+5dZOpok/mg==
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr16186298oif.121.1595200299046;
        Sun, 19 Jul 2020 16:11:39 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 11/18] dyndbg: use gcc ?: to reduce word count
Date:   Sun, 19 Jul 2020 17:10:51 -0600
Message-Id: <20200719231058.1586423-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reduce word count via gcc ?: extension, no actual code change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e879af4e66e0..6d0159075308 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -127,10 +127,10 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
 		 msg,
-		 query->function ? query->function : "",
-		 query->filename ? query->filename : "",
-		 query->module ? query->module : "",
-		 fmtlen, query->format ? query->format : "",
+		 query->function ?: "",
+		 query->filename ?: "",
+		 query->module ?: "",
+		 fmtlen, query->format ?: "",
 		 query->first_lineno, query->last_lineno);
 }
 
-- 
2.26.2

