Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0220C28EB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgJODhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbgJODhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:37:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD0C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 20:37:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hk7so1072206pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 20:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsm32m5dqMZ9IiRke0HVSKp+LJR7Zhu1oKQCmbEY7PY=;
        b=IOO8H0dWn3N0RbwRjQeTPWULpmZsYMrAismeJ5mH3OIt63p1U2lVGjxYmRLmMP5NfM
         tAjyUj4Rf2dDJbKAZfDVfzlR+h90Ty8QSbdPN1PTkMwi+qQa36geDK7sbfpGiRau26gQ
         wCtjFU5m8bUXpmG20GId8iynohBSJPr50lXmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jsm32m5dqMZ9IiRke0HVSKp+LJR7Zhu1oKQCmbEY7PY=;
        b=iBfPMxcS+bzUFMbbbA8NRyYuZD9oDRCUsDoAZsXW+5+tpei06fpJ+eo4HjmKDhyFG8
         O8UC7rA2RZ9ZwiUMbdcfJAYFBlIFrmgR21uHQvH1NKOFf0Ok4InHJwuMwoAei2532vtu
         hMFeFGppeoRc5QiszEx8QvaEK06lb4QfF9H5AfSUfE8YaizTQ3k7sm5a0wSRoe56gpHm
         qRQnXAslAoJCHXc8J1WG/6h7O7wacD86gTBEo+x4fxckdxs9NCZiLOzp1u8sjOIxIGP3
         Oa6SswLcbVWcw0JF/g3fCJEtR4J85WAwN/RingUSigxPbGKr+yKr/eQ2BKzQjrzMSvVA
         0p/Q==
X-Gm-Message-State: AOAM531/6UpSH5nC9dpVeA/Yyh1oLilz6KxXIzkycspm09RU9bN0GQ8d
        rs61oRSa32ja6Hwx0FTw98nG8MRv/LCL8Q==
X-Google-Smtp-Source: ABdhPJx1504xJWTWPoVAFTEpicwDTBJJ7j3HEOcF90ph658Opd7eFK0JH7ITgILQct6plxjGXI0JWQ==
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr2307849pjn.127.1602733036268;
        Wed, 14 Oct 2020 20:37:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm1139267pgg.45.2020.10.14.20.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 20:37:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Marco Elver <elver@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 0/3] Actually fix freelist pointer vs redzoning
Date:   Wed, 14 Oct 2020 20:37:09 -0700
Message-Id: <20201015033712.1491731-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- fix commit messages to properly reflect the direction of the overwrite
- justify the less-than-word-size patch better
- add Acks
- move some Fixes up into the commit log as just references
v2: https://lore.kernel.org/lkml/20201009195411.4018141-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20201008233443.3335464-1-keescook@chromium.org

This fixes redzoning vs the freelist pointer (both for middle-position
and very small caches). Both are "theoretical" fixes, in that I see no
evidence of such small-sized caches actually be used in the kernel, but
that's no reason to let the bugs continue to exist. :)

Note on patch 2: Christopher NAKed it, but I actually think this is a
reasonable thing to add -- the "too small" check is only made when built
with CONFIG_DEBUG_VM, so it *is* actually possible for someone to trip
over this directly, even if it would never make it into a released
kernel. I see no reason to just leave this foot-gun in place, though, so
we might as well just fix it too. (Which seems to be what Longman was
similarly supporting, IIUC.)

Anyway, if patch 2 stays NAKed, that's fine. It's entirely separable,
and the other 2 can land. :)

Thanks!

-Kees


Kees Cook (3):
  mm/slub: Clarify verification reporting
  mm/slub: Fix redzoning for small allocations
  mm/slub: Actually fix freelist pointer vs redzoning

 Documentation/vm/slub.rst | 10 +++++-----
 mm/slub.c                 | 36 +++++++++++++++---------------------
 2 files changed, 20 insertions(+), 26 deletions(-)

-- 
2.25.1

