Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6D297C25
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761174AbgJXLlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759799AbgJXLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 07:41:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA2C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 04:41:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o3so3201400pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zDEIEjz6Osy2duw1QBXBYhv7Cd9Q+Aw1BVsmA9mXdS8=;
        b=pJz4Lt6NvsjGVZPBT+E5G6u9r/WnUW2sNxbUQ3WY1clSmKk9sZmhI6RF4SNKEhM3Rq
         k5deqwcBO4uqE0lFMBxoQvX2W5AwTtVwPtWoJXogF0SpkV5Gm0dQ39IaFD/JUFybntVf
         QhjYRMuYm7wH1gEstvJd/gRjTuxHyjiGhm8+NODh7WWjVO+n2zH3UFpUB0tQM4iA/a0z
         VWU+mPWFHGgaSnHIeiRwcQnRxPv6T3KR4d0pkovVPvOWKfVWJA9Fj/zV9Ufr+WzV2ciC
         DDa/0KX8xE3nvRbQ5lj+NffZusxrRZw2Qn7LHKn8QsOi4BOq3gJvg6TwtYhPZwylkUBr
         NAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zDEIEjz6Osy2duw1QBXBYhv7Cd9Q+Aw1BVsmA9mXdS8=;
        b=VmAqBmQNasAMU950PtMbhkwh1GxuTDWS1N0OPT5APDgsiDPCAKytHPKVxnAngCikYu
         kTYDrAiskcA8+x3KYoEusfJXJU7BrHAl1L2acsYCWorQ6oWwUdPLZN55bjqNxlpxuEZw
         a6pf9tfTQnPXwcWN6FA0kiLRg8NTYbhqeGqUdzpx9yLEKP8f7UDmGpFanR3YummoKHxb
         /I0ql5dfc3zhzSnVisn7b0Pwn57g2u3CnUyee4Qu3jQsMBMPazh/IO30yolJeLEq4xc5
         DB8WdTn0wU9dKzdzV5vczAO2261+D8OOF8Y/39BFwAwmXPbrlQnAvNJPYcFfDxiYTpAk
         NYBg==
X-Gm-Message-State: AOAM533n2kw+CEkw+VPi3MPr9iNSCVPTtjjlL7W2XoF2u110R/OrgmUV
        dvdQ4jB2yMkUkppe4Sbw5Sg3HDrgJE8=
X-Google-Smtp-Source: ABdhPJyMIpfJCxGNi0UL3881WhqukwJ9WgZC70ZiXzfb9ZgC5SH//OAYBHaF5m1qXOXVurOCIOdyCA==
X-Received: by 2002:a63:1d22:: with SMTP id d34mr5893496pgd.152.1603539711673;
        Sat, 24 Oct 2020 04:41:51 -0700 (PDT)
Received: from localhost (144.34.187.180.16clouds.com. [144.34.187.180])
        by smtp.gmail.com with ESMTPSA id i24sm5321367pfd.7.2020.10.24.04.41.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Oct 2020 04:41:51 -0700 (PDT)
Date:   Sat, 24 Oct 2020 11:41:44 +0000
From:   Long Li <lonuxli.64@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm/migrate: fix comment spelling
Message-ID: <20201024114144.GA20552@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word in the comment is misspelled, it should be "include".

Signed-off-by: Long Li <lonuxli.64@gmail.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5ca5842df5db..d79640ab8aa1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1694,7 +1694,7 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
 		 * Positive err means the number of failed
 		 * pages to migrate.  Since we are going to
 		 * abort and return the number of non-migrated
-		 * pages, so need to incude the rest of the
+		 * pages, so need to include the rest of the
 		 * nr_pages that have not been attempted as
 		 * well.
 		 */
-- 
2.17.1

