Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7E1A046B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDGBRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:17:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726594AbgDGBQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4t0rXeJXf/7Is8eR7dpPgB8JuUv5NDEJCaYkFwA7To=;
        b=ffyuNgfUypVREmgVNaL+CrGAxV+dMbIlOhImOp6K78b83xD+/mQ2r2uW2m52+tHI+vWf6X
        JrHiQfKISCuPs7iJDW+30MoYWyYh69fbnBW1Zw7fbisPe6bYsnAULl61egq+d444s4Avtt
        wCDeb14yRyZLoNIoJ7Jnz3XLGKCS/iQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-AUUdPABqOZWca5PqudPiwg-1; Mon, 06 Apr 2020 21:16:41 -0400
X-MC-Unique: AUUdPABqOZWca5PqudPiwg-1
Received: by mail-wm1-f69.google.com with SMTP id n127so39310wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l4t0rXeJXf/7Is8eR7dpPgB8JuUv5NDEJCaYkFwA7To=;
        b=GDXhLLciODfy4Jq6B1lK+HFUZ7cmeJPvV0Xk69KnWALJ/cOIAKdyrFlsuD+7IbPHB3
         u+9dod0A8LTZqsQHwWugJmOLRnDM1shEyqWzhD3oUEqNro5foZu5G97/2QyF5jOzIOzi
         gSCgZHGFF3f6CazitSmcz6rjLB87doT8F+GweyhwzbmrEdFnHV8CXJhd7f0V/0AqxKIA
         rm1Pxq+m1cMdLFgrpL7I4r6rIQcvL4/NMG8VTsbKaVN7z0XSn7rwR1s1RqXsS1BC66C6
         gD6xMr3ZEEWngB02awt76jBwV8mmHugb5OqCFMopHzw8cXLLlyoUo3OCa2T2bx3QjOBB
         R0YA==
X-Gm-Message-State: AGi0PualqVyAkPRd9L8NQQWx4gDacgtUY1/fvsekxLWPHzoukTGxD9J/
        dtxu2En83IxiLrdiEtsTWGgxwyKcH5pEXBSKa63Tt11GjMFpq1wamEouqLXYvQc4BqA2MH0QVHr
        FZTGsIqxw3VoeGHQlwzJmDqbz
X-Received: by 2002:a1c:a553:: with SMTP id o80mr1972468wme.159.1586222199753;
        Mon, 06 Apr 2020 18:16:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypLzgPCpeHBVPTtA2sAbQBKCKQ2qzZXjvqfsDhPpYNlRvmHlEV5qibDafwbRFUM0lCv6VFnpwg==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr1972456wme.159.1586222199594;
        Mon, 06 Apr 2020 18:16:39 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id g186sm99764wmg.36.2020.04.06.18.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:38 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 05/19] virtgpu: pull in uaccess.h
Message-ID: <20200407011612.478226-6-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to virtio header changes, include uaccess.h directly as
this file is using copy to/from user.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 205ec4abae2b..289dabbce477 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -27,6 +27,7 @@
 
 #include <linux/file.h>
 #include <linux/sync_file.h>
+#include <linux/uaccess.h>
 
 #include <drm/drm_file.h>
 #include <drm/virtgpu_drm.h>
-- 
MST

