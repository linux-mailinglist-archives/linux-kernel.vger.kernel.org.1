Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862602F1A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbhAKPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387555AbhAKPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:49:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0FEC06179F;
        Mon, 11 Jan 2021 07:49:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id 6so270664ejz.5;
        Mon, 11 Jan 2021 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fhDyXIzLb3tp3sYrxiiTJVfbmMx3udMPekHrzkNr6g=;
        b=a162Hx+PQVhapVcwLdSPh3bhweg0hZJDd61KrKsuW3AK/SsxCdymuLkIZWHR/4cNCk
         GSQUixWKFVr6YAHCmKukEilBmAW73/CPzYddux6/KHtluoS3LtjYmkPnJqYBJrlvYXv7
         /iBsJQ98rcAveDgqtGf26SgmV8WPKhirG/+fT2rKU+BSrxk14ixDcrRCQi3zH+LwBokC
         Ad5mwNooq9OOoovstqlnuqm29ZN8G2UItIfy5U/VQva4QoJ47uZj26SSLY5jRgdhEYEh
         dVwSkfDI0LPc8u2D2Iu/uzJbMCITQWxgCSLblw1xHqgd4SMXb5J/OdvYvwC6YgxL4CqN
         PijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fhDyXIzLb3tp3sYrxiiTJVfbmMx3udMPekHrzkNr6g=;
        b=ET5o0nHIPyrxL5ZcN8WVFwN8p12a1ZvHbsKt6kXL36qq5q0cTqPHhUz7B2yRgcStCE
         4MN/WWWIRx9cuQ2m6iKba1nIufAXEOMv/Yd8RAS/TZLqHIXJbN2cFoCNjLfa3NTUPOSv
         62Z4g5KZnMI+bXAewjhmdG9u2piFvJMMXqYrvYTIcZI7X0KZQ/QLXsi+d7KWoWJu+eKI
         vdrifWDj7+FcWSFkmPkdQKn3V5IpBhkfvrwGVj3TmN6fkoEw1MZVX5y4XsEgdy/YJEoi
         UvLnciMxfQV1LFmN3bwoxnNKBOSd8lPwL+AT6NmP2wT+0Ut/oCgJ57h80joknUjfNhuw
         xGoQ==
X-Gm-Message-State: AOAM532E2E2j31aQl4v8mOF8YFjHN6b95hf8wTaAuwt7OLN74aCNb2AP
        gkMNvPeDeZG4VKENPkrwtWsij59CqB4=
X-Google-Smtp-Source: ABdhPJw4DvSlOPkT2eJXUb7cebD4P9IWkasY9s9kw/lepsP5u0g+61CH3wm/CTikdyEOi2M4FgUEdA==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr41054eji.509.1610380143928;
        Mon, 11 Jan 2021 07:49:03 -0800 (PST)
Received: from xws.localdomain (pd9ea3126.dip0.t-ipconnect.de. [217.234.49.38])
        by smtp.gmail.com with ESMTPSA id d22sm7182671eja.72.2021.01.11.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:49:03 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next 2/2] platform/surface: aggregator_cdev: Add comments regarding unchecked allocation size
Date:   Mon, 11 Jan 2021 16:48:51 +0100
Message-Id: <20210111154851.325404-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111154851.325404-1-luzmaximilian@gmail.com>
References: <20210111154851.325404-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CI static analysis complains about the allocation size in payload and
response buffers being unchecked. In general, these allocations should
be safe as the user-input is u16 and thus limited to U16_MAX, which is
only slightly larger than the theoretical maximum imposed by the
underlying SSH protocol.

All bounds on these values required by the underlying protocol are
enforced in ssam_request_sync() (or rather the functions called by it),
thus bounds here are only relevant for allocation.

Add comments explaining that this should be safe.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 178f6ab77e61 ("platform/surface: Add Surface Aggregator user-space interface")
Addresses-Coverity: ("Untrusted allocation size")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_cdev.c         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 979340cdd9de..ccfffe5eadfc 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -106,6 +106,15 @@ static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
 			goto out;
 		}
 
+		/*
+		 * Note: spec.length is limited to U16_MAX bytes via struct
+		 * ssam_cdev_request. This is slightly larger than the
+		 * theoretical maximum (SSH_COMMAND_MAX_PAYLOAD_SIZE) of the
+		 * underlying protocol (note that nothing remotely this size
+		 * should ever be allocated in any normal case). This size is
+		 * validated later in ssam_request_sync(), for allocation the
+		 * bound imposed by u16 should be enough.
+		 */
 		spec.payload = kzalloc(spec.length, GFP_KERNEL);
 		if (!spec.payload) {
 			ret = -ENOMEM;
@@ -125,6 +134,16 @@ static long ssam_cdev_request(struct ssam_cdev *cdev, unsigned long arg)
 			goto out;
 		}
 
+		/*
+		 * Note: rsp.capacity is limited to U16_MAX bytes via struct
+		 * ssam_cdev_request. This is slightly larger than the
+		 * theoretical maximum (SSH_COMMAND_MAX_PAYLOAD_SIZE) of the
+		 * underlying protocol (note that nothing remotely this size
+		 * should ever be allocated in any normal case). In later use,
+		 * this capacity does not have to be strictly bounded, as it
+		 * is only used as an output buffer to be written to. For
+		 * allocation the bound imposed by u16 should be enough.
+		 */
 		rsp.pointer = kzalloc(rsp.capacity, GFP_KERNEL);
 		if (!rsp.pointer) {
 			ret = -ENOMEM;
-- 
2.30.0

