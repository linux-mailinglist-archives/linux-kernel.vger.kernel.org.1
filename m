Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803A92C6964
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgK0Q2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727904AbgK0Q2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606494517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=hBK4rF+UUZqxXGARBNA3+k4KA9RCCq8gUWcN+N8wXLI=;
        b=c67zXAifS2RbpBtxYNPhhbv/l1yZxILuMjdP5QkcpCrIxLNr6B4ShdEYLNqB7JnSlZuiyn
        EcLQ198NpS3SkhBzFo5JDAtHFgJFAuk5Lrofjto4AdEHDHTddIiVQ6XRA/149qcsIVZIXx
        fjea7Y0TOsEDM1nYaSR2Up8GzJUDxl0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-BWInmr-PPJGauWN1ecKvbw-1; Fri, 27 Nov 2020 11:28:35 -0500
X-MC-Unique: BWInmr-PPJGauWN1ecKvbw-1
Received: by mail-qv1-f71.google.com with SMTP id f2so329227qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hBK4rF+UUZqxXGARBNA3+k4KA9RCCq8gUWcN+N8wXLI=;
        b=Umlm89MJ1mo1+CV7bVlaLRs0YOQHSKVvn4JcNCeG5TdXfv+MkZL3QnyIkbxDKQhaCE
         LS4s5ympmaIrpQUFco7Q9CiynQDDeAwI7Kr/X/pAv8E1fR21Qa3hJ/QRT8mQ+RWS9bmV
         VSOQ7Exn4rEbzrce3ktMVyhaWhVZp92SKYD1zAYivJmEUMQwJZUf2w0zYZ8ul32tDiKR
         wWAk6K5XB1ZZyLPtNJQ1dcTJ4XRJzpwPAgvNmphoUzRgtP38K43u/OzR6fOmbPYuNPGB
         HkA/Z6/Dz9UqHOjS7EX3J2Ty2XIsQX/wsQIe1C0s33ui5xsdaDOHNbN9WNUOT+ehhHEt
         1qOg==
X-Gm-Message-State: AOAM533N7un6JUTqoEln62TKzSBdoQP0pzJYkmUppNcGC8SXrVDm+qV/
        DUiHlnY9E1mrSoyRr/I4ZJdpHq6rciYs+Qe27uCp5XoeuJhg3pTqw4JZz8tAdWeHK8+NZ0xDO2p
        2cFv2689RmG6n1FOCw1csSPtr
X-Received: by 2002:aed:3668:: with SMTP id e95mr8997840qtb.69.1606494514968;
        Fri, 27 Nov 2020 08:28:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3szdD1wWTn6Oo7LYsc3cKd7ZqSuuJJN25Ol+alAuJJ/qJilZvZbeVXDRkqjEGATTXuTCO6Q==
X-Received: by 2002:aed:3668:: with SMTP id e95mr8997822qtb.69.1606494514757;
        Fri, 27 Nov 2020 08:28:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 187sm6632673qki.38.2020.11.27.08.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:28:34 -0800 (PST)
From:   trix@redhat.com
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:28:28 -0800
Message-Id: <20201127162828.2660230-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/intel_device_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
index e67cec8fa2aa..ef767f04c37c 100644
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -104,7 +104,7 @@ void intel_device_info_print_static(const struct intel_device_info *info,
 	drm_printf(p, "ppgtt-type: %d\n", info->ppgtt_type);
 	drm_printf(p, "dma_mask_size: %u\n", info->dma_mask_size);
 
-#define PRINT_FLAG(name) drm_printf(p, "%s: %s\n", #name, yesno(info->name));
+#define PRINT_FLAG(name) drm_printf(p, "%s: %s\n", #name, yesno(info->name))
 	DEV_INFO_FOR_EACH_FLAG(PRINT_FLAG);
 #undef PRINT_FLAG
 
-- 
2.18.4

