Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AB28293E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJDGtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 02:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgJDGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 02:49:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0844C0613CE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 23:49:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so775731ejg.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wiRu/UNA0pjlrtebSlMYi06x0VP2UdPXkT2G8Mphkow=;
        b=HfuxUtnUsdgWaV/IejQpBLhZK4DHvH7NTScAIhboOCXBEFSb6p7xTUDQgHNwsoHaTm
         mK0DwcWi2+vAgTtHWu4eGnYZ1KxIDMIr0nQvdLXPDNup3ZY/yCBBKqQUqv+B5RqfpqGN
         Uh50R6W/f0DRNU6QKqqs+l+vh/pWYCuUjQspigeNZywYJJ2hDkhMvuRzwSLCC877/47Z
         kLAeUQzUR8ByVehoQlSHYMsbnXMxRKAGQB4QbnffuYDc0SX42s7r3kseOdab1mvRg2da
         hJjLM87djzOLAOsY5Mg8h6Meso9nKpVY+E8ktIWVesCfULLqo1smeieB9W63OQ1ZiNFy
         RbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wiRu/UNA0pjlrtebSlMYi06x0VP2UdPXkT2G8Mphkow=;
        b=CQb+C9fkIHxRrXzrXb6GHlMNWZ66UGXaQjmkJnLcxXmP7qGVYw5eMSeR+XdcCfd7Pe
         G6LE9lvnG0CB1QZnepm8GCOM3ZjHtRxUXIy+vMDluxO3Ukxquht64GU0uPEqsj5sBCV5
         c6JbSN5z5JVFpSTr+WdPY2TslW+TkVfWSOiqRDEjS9yeHW+pPMausKrie8leZP6SZ04G
         Q3S1NkAoN8FTxdgIPxv5LHmipIPRvA8FZqOOgslj/T72nXngQwIMWTg7HsiM9p04UXol
         3OWukGdlHI5cWAbzuHy1dF0hsnAmqvrVX6duABkZdBmjtl0WqeckZDFxbo7GpkXGvBqi
         ndgw==
X-Gm-Message-State: AOAM533YkNvAxiBoYGQmmijHlec0XXZ17gJudTN+Vln6HiVR1KQItKgl
        dSujpTxgBS1svELwwp6Atkz/11Ha6mrdhQ==
X-Google-Smtp-Source: ABdhPJz14hUFLw7fCqVAA9pOdA4Sq3LEc7INoEX7Lx5q+AmDdf1Cl+/cjL3SumAP0xn9ifG93rM2ng==
X-Received: by 2002:a17:906:af10:: with SMTP id lx16mr987391ejb.400.1601794173230;
        Sat, 03 Oct 2020 23:49:33 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d26:f700:8d52:b46b:d125:e62a])
        by smtp.gmail.com with ESMTPSA id x12sm5840602edq.77.2020.10.03.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 23:49:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm/amdgpu: remove unintended executable mode
Date:   Sun,  4 Oct 2020 08:49:17 +0200
Message-Id: <20201004064917.17941-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the intended change, commit 3437f5f6c979 ("drm/amdgpu: add gfx
support for van gogh (v2)") also set the source files gfx_v10_0.c to be
executable, i.e., changed from old mode 644 to new mode 755.

Set to the usual mode for source and headers files. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20201002

Alex, please pick this minor non-urgent cleanup patch on your -next tree.

Huang Rui, please ack. You might want to check your development environment
introducing those executable modes on files.

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
old mode 100755
new mode 100644
-- 
2.17.1

