Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D128949E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbgJITy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391311AbgJITyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:54:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9FC0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 12:54:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bb1so4957594plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2TuK5ejrS4eO7yBYGxlh4AfvTTT9eubX9M0NFaNHUw=;
        b=WmBTqbBHc/fLbnYNSF9b2ZcYqm01OyvGBVCdOMlOlplf+K84OlLZT78WwFWOagQuLL
         tDy2L8MOtypox20wQcgMiCc7YNVSLgaLbl/v5wT3DFsEBCQ5+QAukKZ+evprA3Lh/MCc
         glirkHKlR1Dy+Nksiwkc5zH0AJjLGUHWF+KuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t2TuK5ejrS4eO7yBYGxlh4AfvTTT9eubX9M0NFaNHUw=;
        b=BiR43AV/goRGwg03DjdH36yxrbwPrLiYSwAf9bOPubNbvcK+VET9HdB0z+WsDyEyk9
         EqThYgyBI9yAxVax4u9FtdmGu7I2QisxUHkQH3kRS89UK1Mj5mljqJ7ijK4/JnusGxSi
         9FzfJlZpixQ9h0cAkdIp7+67uUHkHsFAwPMUopl5J3e9TmKOuDJ0VpcEQfnf+Y5BtzY9
         P0k8AtaCNQclzeKhPdtllYc1pDJTtquwMFyPDMtDP0WO2+8Yt6hKb30pBEV4Q3xmcoeX
         /g7gEFB6vMdaWobKzCizqrFEAJa91+tVqFueYg+jkv30FDm07HmKXGLZsFoI3wJk2ihR
         zKsQ==
X-Gm-Message-State: AOAM530mz5/n6H78s+aozZQWVx6LttL/ESQiIQ+2N+IN5H9jQ4pq2Qjf
        9uDnD2VzsHr8H+IWyY9kYCwVrQ==
X-Google-Smtp-Source: ABdhPJylPL8PSKzfsb/31DQv1ffR9H5CiGwEbjOyZ1DOxnKQzkhmw2oI6Kjc3x/3NEhDPJExrT73pQ==
X-Received: by 2002:a17:902:6545:b029:d3:d1fc:ff28 with SMTP id d5-20020a1709026545b02900d3d1fcff28mr13609528pln.34.1602273257514;
        Fri, 09 Oct 2020 12:54:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b185sm11752903pgc.68.2020.10.09.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:54:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/3] Actually fix freelist pointer vs redzoning
Date:   Fri,  9 Oct 2020 12:54:08 -0700
Message-Id: <20201009195411.4018141-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- add additional clean-up patches
- add Tested-by
v1: https://lore.kernel.org/lkml/20201008233443.3335464-1-keescook@chromium.org

This fixes redzoning vs the freelist pointer (both for middle-position
and very small caches). Both are "theoretical" fixes, in that I see no
evidence of such small-sized caches actually be used in the kernel, but
that's no reason to let the bugs continue to exist. :)

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

