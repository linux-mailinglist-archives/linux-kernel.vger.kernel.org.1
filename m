Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463332BC68D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKVPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgKVPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:39:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B88C0613CF;
        Sun, 22 Nov 2020 07:39:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gj5so19801028ejb.8;
        Sun, 22 Nov 2020 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftXwQvyxOtcWWpnt7XYMWgjz5qMtAk2DUcYi43bDv84=;
        b=PdJCrZPkHvWOcst+CCC62W6xNE4eAr5hye/30q1J5e9aZ1lJvevE+tyWBH5KuW5BOO
         YNpVWN+691ticJKStM9Y5C24IXRAdRQoZaRVjaXBUopa3ouSnV/u7XK10yLvanX94+Uz
         6QF1wTFppJ4VwL2TPAr8znxEDX20rR5O2Jkm/VRmqZV4vbH4D0yWPly934Yk9IjOOZZY
         wnqgBomkoS0IV7+Fumbsf2/t7FxW0Zo2rQEomHg95+iD98RMvtlxtMDTLeEP3fuxJECg
         0hkqOpMyngQcTMs69k9NdP4bXkCHkqqGUFG4bCEuHy1t3IiYBByoyftGO0JytSLqdeLN
         29lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftXwQvyxOtcWWpnt7XYMWgjz5qMtAk2DUcYi43bDv84=;
        b=Mw5gG/M3iQsK0AoJhlpsxlX/NGG7yzFTbMOXKlVF8Lpop4HpK7xwqA7zAR3MP/thw5
         NGW7QI1E5hl6jSb8FTkbESBj86BkvIkds1TAWtByRfgsYHAv41o3mFwkfCu9+gykkBzc
         mVbO1a3kRtjHUwa/BAvnEfKp00uJKq2DFpNbv8Tf5+xLk9Pjr0JiT5hxXdbTi8qKyvI8
         uDbh6EuC0XZxXCYfRpspLkfffjwxWzWgbFk3oVEWlkl7VFj8GuSlxB73nzTLEPBYN24V
         JnhS7cbA3KeszE8nfwSd0jahPMMApR2NbJRzt4YCTt1bUZK+ydcDsQNnvA4qZIITyTaX
         3K3w==
X-Gm-Message-State: AOAM533BrHJKVLs5jPQDHQwiYNKsxi4KAExSjQ+Lwd2a8nWNasljnzA5
        MhRrQQdIldQR4fWaNf1Wa/MC8pZfYCCOtg==
X-Google-Smtp-Source: ABdhPJwMYEgrVKwLekIaOl6hxXu8AxP9wFNJBtJ+GnB9oB6MbKZrp7K7yNeeDV6nhq3AgIFUOopkFg==
X-Received: by 2002:a17:906:76d0:: with SMTP id q16mr9010685ejn.164.1606059545736;
        Sun, 22 Nov 2020 07:39:05 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q19sm3693742ejz.90.2020.11.22.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:39:05 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 for-next 0/4] optimise sbitmap deferred clear
Date:   Sun, 22 Nov 2020 15:35:44 +0000
Message-Id: <cover.1606058975.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sbitmap takes away some cycles for my tag-deficient test, removal of
locking in sbitmap_deferred_clear() gives +~1% throuhput.

[1/4] and [4/4] are simple, it'd be great if someone could double
check for ordering issues for other two patches.

v2: add 3rd (CAS -> atomic and) and 4th patches

Pavel Begunkov (4):
  sbitmap: optimise sbitmap_deferred_clear()
  sbitmap: remove swap_lock
  sbitmap: replace CAS with atomic and
  sbitmap: simplify wrap check

 include/linux/sbitmap.h |  5 -----
 lib/sbitmap.c           | 44 +++++++++++++++++------------------------
 2 files changed, 18 insertions(+), 31 deletions(-)

-- 
2.24.0

