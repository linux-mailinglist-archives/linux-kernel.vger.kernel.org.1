Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05872C6C35
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgK0Tyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730326AbgK0Tt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9qJpD7PFdKgMu/xcOXN6q7idq5UlxcE8KGC0MQOhIgM=;
        b=SVfRrTvl+6ngJZixTRJZdYyfmhlK14JbxvmwkRM7NzRX5RSkZW8Cyg//7TYVzta/OLM3XG
        Ba1JM6wwFb8TtJIiGQTN46926TMJw69Tgcsmwh8QO2ouqBnu81Q+E2yP8fswIrOFELZAUE
        cZCH/NQ32+98ut1AK6E8yhVglZb/XFI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-X2ZdtNGuO1CDbDmM2ayIow-1; Fri, 27 Nov 2020 14:27:42 -0500
X-MC-Unique: X2ZdtNGuO1CDbDmM2ayIow-1
Received: by mail-qv1-f72.google.com with SMTP id i2so2355487qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9qJpD7PFdKgMu/xcOXN6q7idq5UlxcE8KGC0MQOhIgM=;
        b=jnCZn3B1/m47s8CZmALZP6eWotnUYYD9VdPhuDrpsibQolJlWaMxjbvWe8NGehWU0o
         /R5xr5n3DirHEXs8eUOtAp40iMYG2GPewFNN16bK/PVnmuiocsSqTHP5EQXGGXhInS+E
         1FjlwLAkyLcOIIr7X5WNPbPhsZ/nEFjlQYVF7AOpeTybudl6G63TpElaITAOzft1ARPy
         Mtj7u82MTk5JXZLa61sxx3+2j4klxkD2gQm109RZGoPCVVUUXBD4Z2JQij95giad48Us
         zDs1pG4vakrbNmOZSKFT0Y70k428T2ZX8+idBdKuSFCGofCza6uzovvP8x893WwD7Za0
         42Ww==
X-Gm-Message-State: AOAM530XyIezMJHx92rPCqpxTpuF6nzh7leg6ow6XBren1Pa11bPN+W0
        VVGwuZ1RAYFXDUt2Ad8SvKO0sjRISeFGJ2B8+LrQhildJ5bP8N+sRGfjLrFVLGre23/FrRUiiQn
        JfxSLX+JrObENPXBYcQ/g5oEu
X-Received: by 2002:ad4:5544:: with SMTP id v4mr9383598qvy.43.1606505261712;
        Fri, 27 Nov 2020 11:27:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuNWhcU9Ar3O10Wn0TX41HHp7RN7H86NAdJD2PtPOP28EoXt8oYhhMF7eDA1G5lCwZpeGCiA==
X-Received: by 2002:ad4:5544:: with SMTP id v4mr9383569qvy.43.1606505261511;
        Fri, 27 Nov 2020 11:27:41 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w54sm7395471qtb.0.2020.11.27.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:27:40 -0800 (PST)
From:   trix@redhat.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:27:34 -0800
Message-Id: <20201127192734.2865832-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/trace/events/xdp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index cd24e8a59529..65ffedf8386f 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -146,13 +146,13 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
 );
 
 #define _trace_xdp_redirect(dev, xdp, to)		\
-	 trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to);
+	 trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to)
 
 #define _trace_xdp_redirect_err(dev, xdp, to, err)	\
 	 trace_xdp_redirect_err(dev, xdp, NULL, err, NULL, to);
 
 #define _trace_xdp_redirect_map(dev, xdp, to, map, index)		\
-	 trace_xdp_redirect(dev, xdp, to, 0, map, index);
+	 trace_xdp_redirect(dev, xdp, to, 0, map, index)
 
 #define _trace_xdp_redirect_map_err(dev, xdp, to, map, index, err)	\
 	 trace_xdp_redirect_err(dev, xdp, to, err, map, index);
-- 
2.18.4

