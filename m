Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBB2A506B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgKCTtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgKCTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604432975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RMhmlI7J39tGZ2SV4Ku6FWb6g9FR/7RgJqLGVWssnYI=;
        b=A6gX3MyQxOcW5lJS+7zIpigaVS/Zhz5Kkzn03XLouIfhLMKmEeJ+06LxLKnCTP8ndDVt8D
        i6If1YTM60q14nLe9M2giJRRgttpf9JuDzUb6tKEDMQtOlieIveASlPynLiMAM+EsrcOXg
        9F0OUXOzPpB7DhM745X33q7ppcOzCxs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-RHIyxyWoNx656_rsuRvTnA-1; Tue, 03 Nov 2020 14:49:33 -0500
X-MC-Unique: RHIyxyWoNx656_rsuRvTnA-1
Received: by mail-qk1-f199.google.com with SMTP id n23so10463406qkn.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 11:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RMhmlI7J39tGZ2SV4Ku6FWb6g9FR/7RgJqLGVWssnYI=;
        b=g6XYq1Gc9aRP8/OybBulixEHT/MGwDBcrahiDrM9ar+OTqW7FoiJs4cZFlELGyphwJ
         SFYxVaHN6Y6o8bProNggKc5OFScvSsPkn1hfmocOioLtLFv8WvRzvXxCw6h+W0l5R0aK
         xRrzeIwh+NlpCuUUq4bmzvFYhDWgiV+Rfc0z20lNt6TrcSwfkPCG3FBRQJ38hGJ62qmf
         dJZy/fFXuyvp8YLwdWQ0mbElB08vFGk3kjsAPGs/kA0/AXPPjxtY9LV4y0tsTo/mqdwv
         Dt0vkq0VhBBeekk7KhYRJwj0gAF3B0Eik7fxpbYWi9MTXKrmonfmJrdFND9nIpinbDnz
         Rvjg==
X-Gm-Message-State: AOAM530+7LKO/3hQAj4/ykcd5fDuZyT6NPCTSdMMZAPEnjm67DLEP3KL
        szfCNrIvgXaJPrcL1La0SNOZsff66UGLrQ/D4Bb40odNXqP9UgYYm+QTlSMGnJLY5q5g6RAo7J7
        KfBiYpQ+/q4UBMv3/4XrGjP2v
X-Received: by 2002:a37:c441:: with SMTP id h1mr21747178qkm.298.1604432973154;
        Tue, 03 Nov 2020 11:49:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy41D81xBVSWbgfUtCJ62NG9CG/yhsi1aEcls1TS+xTGUJGjh7vp2/8LAkziyOyD18UEa3N7Q==
X-Received: by 2002:a37:c441:: with SMTP id h1mr21747159qkm.298.1604432972928;
        Tue, 03 Nov 2020 11:49:32 -0800 (PST)
Received: from xps13.redhat.com ([2605:a601:a639:f01:1ac8:8e0c:f1cc:7a29])
        by smtp.gmail.com with ESMTPSA id w25sm11392532qkj.85.2020.11.03.11.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 11:49:31 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 0/3] drm/nouveau: fix a use-after-free in postclose()
Date:   Tue,  3 Nov 2020 14:49:09 -0500
Message-Id: <20201103194912.184413-1-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
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

Jeremy Cline (3):
  drm/nouveau: use drm_dev_unplug() during device removal
  drm/nouveau: Add a dedicated mutex for the clients list
  drm/nouveau: clean up all clients on device removal

 drivers/gpu/drm/nouveau/nouveau_drm.c | 39 +++++++++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_drv.h |  5 ++++
 2 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.28.0

