Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA42DAF28
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgLOOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729389AbgLOOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F8joEElleXKdzZZoOlmFpnV8pMLwxW0aIioc9VmMinw=;
        b=aGktZw/APZXyRVabOyW4KPMmqun0nOyseEeo5NSpq97O47XKlc64QKILQ6aoVXnqOEvTk3
        ULKsanRsv93c3Y2NV8Ne1qG0sWoa0AVhCv4n3arEjPwSeMGsZI87n+Q2C8TfGQZm6JF4h5
        gO9ykClNmR2bwgAgGfZC+XKMXFrQsq8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-K5QoXhHBPfW_pBF9FgW42g-1; Tue, 15 Dec 2020 09:41:08 -0500
X-MC-Unique: K5QoXhHBPfW_pBF9FgW42g-1
Received: by mail-qk1-f199.google.com with SMTP id o190so15398340qkf.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8joEElleXKdzZZoOlmFpnV8pMLwxW0aIioc9VmMinw=;
        b=j2X3Oz79pVobk9RUnPaPa9P2nNVwiv5XDC3WqDkfKIVIwjXe6Ce7VXT7W4yngFOkAt
         1VkK9uP+iARb42BazVwbwNefGtPNHVsCdrvxmvqKEq4CVWLp5A2/LhhdmJDf90rmSPab
         H+iU7sNuIb4TmY3PhWJa+dSusfVSx8rLBDkuIGkv5gWkYUasWUIbOSWpF8RH8ZK8Lwws
         oIH5hm4+WaEMsOGwynKkfvIC9GcrGVuP5PhBa/yJw6lX6xTZVii+8KQZkrgacvOeozCU
         yLVPlGJ4cPsubrc7t5zLPUcJD34VOg0xQOhMfdA3FMjDjsiyIsE2O+KGsHAw38Vmo4CJ
         g2/w==
X-Gm-Message-State: AOAM530dKrdqq8e2VNOVepLgVTFniQWuJj+1uMQOSYTlVyFtCUwKP33z
        +OP1CZtTLJ/QscXq+U96J9i8QNGo1rV2DOrS/co1TU+N3iws7PMAHYa75YdjfGwlReB2kOfb6rJ
        fSgGK0Gqa0YqnDonBH9JUpz9x
X-Received: by 2002:ac8:588c:: with SMTP id t12mr35766788qta.184.1608043268254;
        Tue, 15 Dec 2020 06:41:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0aOW3zgklpzEA6VS9bGbEduK40Txfz03DgS33CSsoQvHcRVw60dBnH0UPlARX48A3H9vH8Q==
X-Received: by 2002:ac8:588c:: with SMTP id t12mr35766768qta.184.1608043268018;
        Tue, 15 Dec 2020 06:41:08 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b6sm16306599qkc.128.2020.12.15.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:41:07 -0800 (PST)
From:   trix@redhat.com
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com,
        daniele.ceraolospurio@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        lionel.g.landwerlin@intel.com, venkata.s.dhanalakota@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:41:01 -0800
Message-Id: <20201215144101.1878719-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/gt/intel_sseu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_sseu.c b/drivers/gpu/drm/i915/gt/intel_sseu.c
index 8a72e0fe34ca..80be9e818a6b 100644
--- a/drivers/gpu/drm/i915/gt/intel_sseu.c
+++ b/drivers/gpu/drm/i915/gt/intel_sseu.c
@@ -755,7 +755,7 @@ void intel_sseu_print_topology(const struct sseu_dev_info *sseu,
 		for (ss = 0; ss < sseu->max_subslices; ss++) {
 			u16 enabled_eus = sseu_get_eus(sseu, s, ss);
 
-			drm_printf(p, "\tsubslice%d: %u EUs (0x%hx)\n",
+			drm_printf(p, "\tsubslice%d: %u EUs (0x%x)\n",
 				   ss, hweight16(enabled_eus), enabled_eus);
 		}
 	}
-- 
2.27.0

