Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A1267BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 20:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgILSdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 14:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgILSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 14:33:47 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D90C061573;
        Sat, 12 Sep 2020 11:33:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b12so13690355edz.11;
        Sat, 12 Sep 2020 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sDdNABI91Tfr3hqKhoVLbPlEvPq5j5lfipsDHNaq4ik=;
        b=POua7IFvCe0e6K6KYqXq0wSmVk2tqbCN7sftakcwvJNpHX0YWSIhY+GoCljfJ7I85a
         4TjrNL9eFYYu82+CcAtWBegXoOq2YF0aCOYUldzXY7tyTzld4fgEXkuqPPpTpTNYMOnp
         1xxCjpKqHLog0AVRcRXJoisHzc6dygviNaZR7Iydf2rPC7KhdbwvwEtpA0zPJp31fNPX
         7sye9aW+jbSAuy4nufR2RvSzrugllPJUjN/1lSVihOPtB3/mMPvs9ve6zmhqJGYsMIfk
         bjp4PjbSBK4SXk4iUrxMcnOqwoBGa4lzz9DfHlq0J6UjZoiifd7GzPWKmfXvmhxmzXrk
         3Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sDdNABI91Tfr3hqKhoVLbPlEvPq5j5lfipsDHNaq4ik=;
        b=YXKTlQqFsS8tA+YaEj0zA+m3zZwZpNawsj87fmKUOAd5Y8eyJw4UsBmIYU0D4GRukb
         9OLE9xZP+w667t38PykV2dcnSEsy5zW8YqTQZizDDbRi2tDAXgD04uvYbIKqKXRs+ITi
         bzVIaUqkyT/Zl3Kc7h8xKFKRaB8Cgwp0dGlIwFg5Ps4YXFGSYL4Ly3CPNriR9OuxFopd
         GO0OUuVm920uL/vKVVaicPcl6lmAEmnDWsOi8mZIyBYnTeaV/MmODiT71jM3lDTxV5pn
         Yzsu6ZmSvzNUXgJGYGsZFFHZM89zzWiyUNYkyELwLCrGszlzEAJp2F8xDgEKeTgpGTe3
         ihhA==
X-Gm-Message-State: AOAM530ybowsdZp5nblvPRi3D98fg8qLYaVouLLc0yX4Hm2KPtE9i/UG
        2iJcFb/KqzX0pcbGVOpp15g=
X-Google-Smtp-Source: ABdhPJxhXt41CHf1+Qod2riES3Z2vcmnrRmGcoecWnMBU11QIqnqWnaonf9eRAkhxYhvUjVqdDursg==
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr9567811edx.213.1599935625874;
        Sat, 12 Sep 2020 11:33:45 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dd9:a000:10b6:eb2f:be44:9365])
        by smtp.gmail.com with ESMTPSA id v2sm3589248ejh.57.2020.09.12.11.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 11:33:45 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: make linux-aspeed list remarks consistent
Date:   Sat, 12 Sep 2020 20:33:34 +0200
Message-Id: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f15a3ea80391 ("MAINTAINERS: Add ASPEED BMC GFX DRM driver entry")
does not mention that linux-aspeed@lists.ozlabs.org is moderated for
non-subscribers, but the other three entries for
linux-aspeed@lists.ozlabs.org do.

By 'majority vote' among entries, let us assume it was just missed here and
adjust it to be consistent with others.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on master and next-20200911

Joel, please ack.
David, Daniel, please pick this minor non-urgent clean-up patch.

This patch submission will also show me if linux-aspeed is moderated or
not. I have not subscribed to linux-aspeed and if it shows up quickly in
the archive, the list is probably not moderated; and if it takes longer,
it is moderated, and hence, validating the patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26af84f97353..f2561c3fc9db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5448,7 +5448,7 @@ F:	drivers/gpu/drm/panel/panel-arm-versatile.c
 
 DRM DRIVER FOR ASPEED BMC GFX
 M:	Joel Stanley <joel@jms.id.au>
-L:	linux-aspeed@lists.ozlabs.org
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
-- 
2.17.1

