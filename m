Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C737328A6FE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgJKK3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 06:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgJKK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 06:29:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54892C0613CE;
        Sun, 11 Oct 2020 03:29:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so11224220pgb.10;
        Sun, 11 Oct 2020 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C1KPnMgJ65IAvAdqRGhP0IKoKnOw4H6Tv8QLXkVMTpk=;
        b=ipdTQFudIgX+/95HPKoeJDSTGlYyY1R4AKjV7AJXPFvcYYUUaM/kSLKsGZBw1PCtC+
         ERu0QKF5gAevSBOohzbf24jz7MHg3trLtifirLqKgsmXu646cO4unhmrsJ0xcr43w7GG
         2STcH0kDbnc9lIn2VH+WBxu4K00qyenMr6m1CSXKEzxdh9MEYIfbdwq1Kg4gLE58wza4
         2lO3DNLa7x1EjyZQlYxBz/JAvYXai1v9pgtWzlCHXV0iByU0E9VjrEh5l3fylytfBUKZ
         I1ySo56Y4sPK5bxAwD9fY0BwXZZlhr2jEnd1cfOynkz4SJE+LPJhwJ0rnYH4MuxWghKD
         b1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1KPnMgJ65IAvAdqRGhP0IKoKnOw4H6Tv8QLXkVMTpk=;
        b=FR4JVbqOaMYk/Nt5OFikZ7MfV3gWayzMV0JyVkFVK0DcY93uAAWByKxtNvzSf6fV8d
         vNBEuSKtn/Z5SCovBBw7iHHFhgqa3Yfcgbkdl/QV0t9fD2BDZXJFQKNMTMJuMpi6OBFw
         H1RO5Cjj6Z/kZ1Numk++OYw5n/mZ3aVT3HY1fBPif11NIzNVK1Rvh/DiTDEeKqakB+aX
         SqY0dyRsvpFZXrXotwc0vlWvtAZkSUjhLZX/iVXtxcNQ7ie3armv/wD3QXaNIo0q6JCc
         FDYu+d4pdBBfXMmdTVuZtaFhw5XaYwHnApOhkscW3xftut1DZ+PU/Vv14qvUA+vRimyZ
         uTVA==
X-Gm-Message-State: AOAM532F1L77OvPmKpaHkGt2MAdVNz6skouQxLUXiaFs+H00IPFt2eQ+
        dK+9MfdwOV/0Jl5XFik3tCo=
X-Google-Smtp-Source: ABdhPJwnb69Aqohdd1/q0tobIuWCkoI//DISJfM5lGloQ9TYgzKNGcZiha9HsOOfOFKfB5b4dOaKDA==
X-Received: by 2002:a17:90a:dd46:: with SMTP id u6mr15384584pjv.67.1602412186950;
        Sun, 11 Oct 2020 03:29:46 -0700 (PDT)
Received: from adolin ([49.207.215.73])
        by smtp.gmail.com with ESMTPSA id e16sm17421201pfh.45.2020.10.11.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:29:46 -0700 (PDT)
Date:   Sun, 11 Oct 2020 15:59:42 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 2/3] scripts: coccicheck: Change default condition for
 parallelism
Message-ID: <13de95fe3959459ac9ae8c74d99eb7e3c5702a2d.1602410019.git.sylphrenadin@gmail.com>
References: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602410019.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Coccinelle uses at most one thread per core by default in
machines with more than 2 hyperthreads. However, for systems with only 4
hyperthreads, this does not improve performance.

Modify coccicheck to use all available threads in machines with
upto 4 hyperthreads.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index d67907b8a38b..209bb0427b43 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -79,7 +79,7 @@ else
     THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
     if [ -z "$J" ]; then
         NPROC=$(getconf _NPROCESSORS_ONLN)
-	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
+	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
 		NPROC=$((NPROC/2))
 	fi
     else
-- 
2.25.1

