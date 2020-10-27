Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE9D29C9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830895AbgJ0UHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2443546AbgJ0UHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603829238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SHVkPineI031WVJrbCGteqt14oTNuWFr/V9p8cK86AE=;
        b=Ecb6tvsUPvDnhf0AsGOv4C+AKVJLduZC8lGc0RCdWd/Po+gb8VOv3WEjWTvhli1mJVJZ/h
        Zsm+MMGbYkowEynMJG2fg/u8qVK4kKlBO0Av6EaDUI8/TWB0yFVhd9w8f1zs//3yKM+gEn
        Wc2SiZ8mC2c+IhEkuqZ7la1RhMErpfA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-UwPUDIKzMQ2Lovhssn7qOg-1; Tue, 27 Oct 2020 16:07:16 -0400
X-MC-Unique: UwPUDIKzMQ2Lovhssn7qOg-1
Received: by mail-oi1-f198.google.com with SMTP id f85so1193281oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SHVkPineI031WVJrbCGteqt14oTNuWFr/V9p8cK86AE=;
        b=bT6zWSza3ly58/Ecvp5A0Fq2p0nlBSmo8I+kKbNMeQFu6hzJAaL/UhoGE8Q9tyBIR2
         E399VKPuV7C7gA620xpK/l4FzheeoWq7IrKL7oyaAJ4Zn3rQPWpF3x1nQHETA9xo0N1x
         tjO4Bq0/vRsC9y0Y9cVsUK9+gfPLtCyWLqAY+x84JlRMIMZrjX3U8q9ZDNuYzGh/EasP
         17B+k4KCAlmhdLQ91EspT1MUVrba4B1zT70PpjyuRib8QVPOVlWqMLNc0cp7eXICmUxX
         LNqSh7eIN6mEgKFSGxnOq2b6uxMeLNOOrGdVspxAtQc/UxsNvr+RMYEucPrewgtwySNQ
         Hasw==
X-Gm-Message-State: AOAM5309Ccft73aL4PQAT03Svtppvl9vcOxKUVwvJmywhXOi/TEg3jgU
        7gAUTR9KNs9lVAqm9RCBRtz6g9Q8CSAZRxHY3lX5BelLzqrJiQyS6WaTIT6Q1WV565/L7E7+74w
        hXkeWJ/glZ0YKroqPxTTz2Tlo
X-Received: by 2002:a4a:6f4d:: with SMTP id i13mr3144427oof.25.1603829235834;
        Tue, 27 Oct 2020 13:07:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa7KOheJ0ATgvhFY4mH04BC/Alap4L0XFHAP4s1GjDF+o8lWmc2BUU9x307je7dwCZ/9PAwA==
X-Received: by 2002:a4a:6f4d:: with SMTP id i13mr3144389oof.25.1603829235626;
        Tue, 27 Oct 2020 13:07:15 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o8sm1981630oog.47.2020.10.27.13.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:07:15 -0700 (PDT)
From:   trix@redhat.com
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Rodrigo.Siqueira@amd.com,
        Anthony.Koo@amd.com, Aric.Cyr@amd.com, Tony.Cheng@amd.com,
        Igor.Kravchenko@amd.com, Charlene.Liu@amd.com,
        colin.king@canonical.com, Wenjing.Liu@amd.com,
        joseph.gravenor@amd.com, Bhawanpreet.Lakha@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 13:07:08 -0700
Message-Id: <20201027200708.1596235-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 7b4b2304bbff..5feb804af4be 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -858,7 +858,7 @@ static struct clock_source *find_matching_pll(
 		return pool->clock_sources[DCE112_CLK_SRC_PLL5];
 	default:
 		return NULL;
-	};
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index fb6a19d020f9..ee5230ccf3c4 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -280,6 +280,6 @@ char *mod_hdcp_state_id_to_str(int32_t id)
 		return "D2_A9_VALIDATE_STREAM_READY";
 	default:
 		return "UNKNOWN_STATE_ID";
-	};
+	}
 }
 
-- 
2.18.1

