Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91427DDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 03:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgI3BUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 21:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgI3BUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 21:20:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9DC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so408194ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=JGYJS9NsdZi1x8beX5PbpUGbiZl53A1tuTawkgjS2/I=;
        b=Vi/xsfmtZt0OubUV/0I5sNv7CqOvrLxLoXAOnwdmWcs9UNaz3IytMNDB+VDywmMkFt
         4Nvn2U3hgPCbckquNLY6N2RNzVOKRAkpzuxRLOgyivJoqu5FhIwLGd3vCDsViVU1VX1U
         0j01qqilWxOOR3pYtf6YX7LySWAu5+8Y2H8UWKijw/Dvm5B9BDOh0nn4ZQVMlrm2MJ//
         gta12xDCdtSm33nPxOO8SnPFSndLzKGKqUtoS7hqWz15pPPDHAmMItCY2JyOaV4kWM5d
         gE80NxPWOJp3FI3eP3wbcvL5GSfe4L1ismIZq6L4aXThyhp19RGqyNQ/r/jSPV4Stp1L
         vYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=JGYJS9NsdZi1x8beX5PbpUGbiZl53A1tuTawkgjS2/I=;
        b=dNhbXrJUzeJZhUHwLp48ksNhC2RT5iUGkVsW0HBUaMNRkX7CYGvvnct7gvzWOaF0wx
         enkFhuk8h4GF2iYhEd6I7Z1mYNj0z0Zzcc/UBsTUGiuGQK887BW3274CFKypWXNqTy/R
         96NixvAFylXkjqO2+QZMDhspzIhS5G13rHscMxLG97O/DXqTCLjJ2ohQpOrnEgiEa72M
         U7+gWfY+B82Plhj3om2ux56D7u1NCedZSluKAN0YDPMAPFLLbRyraIylXDp59f4cdJ5X
         ByOoujakSyxQC8RlDFmsagLy3uqlwnmxfBXk0gswNm6+52TIOsmTCcyOe5tzAIDdYtjO
         7AtQ==
X-Gm-Message-State: AOAM5307wD5Z4FvKpk3KrrYYQteDyxhFPJFcawE5qoQsCmSVEd+TRKk6
        TLEHlP5rXLY2aX+zx/5yZEarTog94HvpRYDOnd7++w==
X-Google-Smtp-Source: ABdhPJyRWWwuTyTX/XXS9zCN7ij+NQlamQSZw7NV5QSXRYBapraXEqXZ1OWbdSP0h+eqkO/Qteau7MjPS9vhW/GAPH0=
X-Received: by 2002:a17:906:980f:: with SMTP id lm15mr438339ejb.184.1601428802457;
 Tue, 29 Sep 2020 18:20:02 -0700 (PDT)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Sep 2020 18:20:01 -0700
From:   Jann Horn <jannh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930011944.19869-1-jannh@google.com>
References: <20200930011944.19869-1-jannh@google.com>
MIME-Version: 1.0
Date:   Tue, 29 Sep 2020 18:20:01 -0700
Message-ID: <CAG48ez1GM==OnHpS=ghqZNJPn02FCDUEHc7GQmGRMXUD_aKudg@mail.gmail.com>
Subject: [PATCH 4/4] mm/gup: Assert that the mmap lock is held in __get_user_pages()
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having cleaned up all GUP callers (except for the atomisp staging
driver, which currently gets mmap locking completely wrong [1]) to always
ensure that they hold the mmap lock when calling into GUP (unless the mm is
not yet globally visible), add an assertion to make sure it stays that way
going forward.

[1] https://lore.kernel.org/lkml/CAG48ez3tZAb9JVhw4T5e-i=h2_DUZxfNRTDsagSRCVazNXx5qA@mail.gmail.com/

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f11d39867cf5..3e5d843215b9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1020,6 +1020,8 @@ static long __get_user_pages(struct mm_struct *mm,
 	struct vm_area_struct *vma = NULL;
 	struct follow_page_context ctx = { NULL };

+	mmap_assert_locked(mm);
+
 	if (!nr_pages)
 		return 0;

-- 
2.28.0.709.gb0816b6eb0-goog
