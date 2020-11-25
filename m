Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610722C4903
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgKYU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:27:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729175AbgKYU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606336028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vosBqspdw7JmFXivYdUDySO0pSWDCWmE9V9Dch1o6C4=;
        b=ctQ118EuOGio0oUVlLHD9Ym1fCutQXFJXGtgmQKFbTbAQyuSDu7iG5jGJLqgH1XFrqRoeS
        Y7ZziBkWSLwHicNpD1W67GWk2zvjR9W23dTJi7fmrt8ROUv/39tjrE+5ugfV2z53j/4xzA
        e8rgXJoa663VqGw6uMwT6XyrKCA6c3g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-pPqC7REHNaa1stUMJZsM6A-1; Wed, 25 Nov 2020 15:27:07 -0500
X-MC-Unique: pPqC7REHNaa1stUMJZsM6A-1
Received: by mail-qv1-f69.google.com with SMTP id i11so2090181qvo.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vosBqspdw7JmFXivYdUDySO0pSWDCWmE9V9Dch1o6C4=;
        b=L/aqq/4Qn19EyECv8n8ZsUGhmbsGsBrcf3452qNkjhhQ2QTYkUgqXHCZW0y5004AvI
         2ZamtRyaY/h6MxeCNGBQdtpfakRy57pr2xbfm1dFAJwVrAI3CUabT9mEiFS6wEgS/lLE
         KCDmojYV6HZmtCYTQDBXeV8iy8X892wz/K52PsCsyr2a33W3IXNKJ6XOeJ0rHwgW1InO
         lVR7k3yTa49SEkaoFUAdKOsGulz/QyGbVgdQBiEzcn7eMrPfQd9Mw8QPgVyixKXcEvuf
         i9ZDCNZHOWtSOYEx64THsL+jh69qINsqyPaUPycnj8b/r4PImeSLXjKY+xbC8Q4+qc9h
         07oA==
X-Gm-Message-State: AOAM531m/R2wDWgNzSjPaCtCEwqBmNrll5Xa0t2ShB7xsx8wVkQGi0PH
        VKBvxyY0eoGNwwy5CofQtHGpgggasCfmiwjvNmMo8LTvgGKpJSytOkXrRu0lWHcSMX71tG5UGx7
        yzhwxFQgGFPLD4KL9NDwrg+Ed
X-Received: by 2002:ac8:ec8:: with SMTP id w8mr621872qti.371.1606336026756;
        Wed, 25 Nov 2020 12:27:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT78zpa38ZcqRtOpdxdblr3H4mlGuN8etlAySSZYr1uSsG5rPx8jYrid33ovUycVEA93aYXg==
X-Received: by 2002:ac8:ec8:: with SMTP id w8mr621855qti.371.1606336026552;
        Wed, 25 Nov 2020 12:27:06 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a638:b301:9966:d978:493:6a3d])
        by smtp.gmail.com with ESMTPSA id o187sm431772qkb.120.2020.11.25.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:27:05 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2 0/3] drm/nouveau: fix a use-after-free in postclose()
Date:   Wed, 25 Nov 2020 15:26:45 -0500
Message-Id: <20201125202648.5220-1-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103194912.184413-1-jcline@redhat.com>
References: <20201103194912.184413-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a number of use-after-frees in nouveau's postclose()
handler. It was discovered by pointing IGT's core_hotunplug tests at a
nouveau device, but the steps to reproduce it are simple:

1. Open the device file
2. Unbind the driver or remove the device
3. Close the file opened in step 1.

During the device removal, the nouveau_drm structure is de-allocated,
but is dereferenced in the postclose() handler.

One obvious solution is to ensure all the operations in the postclose()
handler are valid by extending the lifetime of the nouveau_drm
structure. This is possible with the new devm_drm_dev_alloc() interface,
but the change is somewhat invasive so I thought it best to submit that
work separately.

Instead, we make use of the drm_dev_unplug() API, clean up all clients
in the device removal call, and check to make sure the device has not
been unplugged in the postclose() handler. While this does not enable
hot-unplug support for nouveau, it's enough to avoid crashing the kernel
and leads to all the core_hotunplug tests to pass.

This series reroll addresses a missing mutex_destroy() call and a typo
in a commit message.

Jeremy Cline (3):
  drm/nouveau: use drm_dev_unplug() during device removal
  drm/nouveau: Add a dedicated mutex for the clients list
  drm/nouveau: clean up all clients on device removal

 drivers/gpu/drm/nouveau/nouveau_drm.c | 42 +++++++++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_drv.h |  5 ++++
 2 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.28.0

