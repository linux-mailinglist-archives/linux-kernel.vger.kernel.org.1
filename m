Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3963028DAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgJNIOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgJNIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:14:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C23C051127
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:54:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so1330216pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rKoJ8K1HmS89dQcSd+qek5XQD2mS7GsLcQDZpZn8svY=;
        b=U4iUTIxdQbehyuFrFc7WiEJXMgU4qgwSykRROhgkVSQ8nJXnnVIu+nERBK+TpjLiRD
         FMwQW+FwFT1JcwaQtl+Fz/QaBvp8jmMtZ7ylnHbyLTEKHTc9wtkbU3mga6WkYmW8/fYf
         hhu4vjpu74tK6F54iGiQ/E39YCMjKuZhHV1IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rKoJ8K1HmS89dQcSd+qek5XQD2mS7GsLcQDZpZn8svY=;
        b=UMezcSotk0jSMjeCgaKgQ8Kca8Kg8eiP22GKOIcYzcGqOnYLXCj7oUKN/sguDJ2bfY
         653cv3Oo1Vq+FhVtB8K9FmVx+yt4EE3K/H2/L+0jjrS+WieLgFp3Kqgp7Ez5C5CG4oer
         5fomJ+LZ6hqGQQhcjeAKj/yKoVJHfIdmFJNjjsbu93gLeHLVJ+phqmp5Qvu07dRdCWfg
         bzELEhlOoak92wjovC4XjOmL4VsECSnKhPJbaeL7gPhRT/D1zZf9vt//NMCC3yiwtXs2
         85CppfXx2wM4sjK1ykLVvrf/0RLu5BcIqSxluyhh4qi2X7XUKyxFDY3UCLPsN3KeFRgI
         hWSA==
X-Gm-Message-State: AOAM533EUuPVZP1pz8ggJPHj6Xsrs68ABkpGLUzTi61DJ8bjVnW+bffw
        q6ROWcJG24fuXtsBCb7ILyS/Nw==
X-Google-Smtp-Source: ABdhPJyUdVLPpvUpy5QQeSSCwMu0ll7oxBPg1VX62WnU03remZdsdlG7MQNxMpks3DmPoBF6p+L4aw==
X-Received: by 2002:a17:902:ee83:b029:d4:bdd6:cabe with SMTP id a3-20020a170902ee83b02900d4bdd6cabemr3465976pld.68.1602662078593;
        Wed, 14 Oct 2020 00:54:38 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id x1sm2007824pjj.25.2020.10.14.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 00:54:37 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] drm/nouveau: fix memory leak in nvkm_iccsense_oneinit
Date:   Wed, 14 Oct 2020 07:54:16 +0000
Message-Id: <20201014075419.19974-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct pw_rail_t is allocated as an array in function nvios_iccsense_parse,
and stored to a struct member of local variable. However, the array is not
freed when the local variable becomes invalid, and the reference is not
passed on, leading to a memory leak.

Fix this by freeing struct pw_rail_t when exiting nvkm_iccsense_oneinit.

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index fecfa6afcf54..8ba8d8e3f52a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -280,8 +280,10 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			}
 
 			rail = kmalloc(sizeof(*rail), GFP_KERNEL);
-			if (!rail)
+			if (!rail) {
+				kfree(stbl.rail);
 				return -ENOMEM;
+			}
 
 			rail->read = read;
 			rail->sensor = sensor;
@@ -291,6 +293,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
+	kfree(stbl.rail);
 	return 0;
 }
 
-- 
2.17.1

