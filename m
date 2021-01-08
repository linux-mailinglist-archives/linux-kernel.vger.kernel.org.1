Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C672EFB55
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbhAHWsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbhAHWsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:48:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 14:47:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s26so26657385lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 14:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJXk2BAUmcofcz+CyBJ2mq6BwSyyharKDCKpISJ6XtA=;
        b=BeTCSAMaRIarLvsejN987GvITBD7YrUfLFch1IA1k9G3IaMZXO1H8Ohcx1mcQNjgkd
         NPjevGSSZ/fF27Ww7rkFqQ0mSVa+RPUk1XnEBRZjl9Fgq0V8W7DAfcf3OXkvoQLx3dC1
         xX7p9uP9IRQmG7Wme6lHpbFwhXwkVjr1OiC90E3dT6/MKEo3k2EwToHsIkFFEDYduvZK
         gevKhrzrestqAvmVnl05MbC5N1Sp1oYw3bQV3k8Avs701wyTKO1iR30FVZQj4gT0AmVz
         VNTsAfSQ3KDMR8irqB746zm0wyJW1On24oM1LZIB4A6aLiR/AGSoUy7+eT1ebNcS5p5n
         RRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJXk2BAUmcofcz+CyBJ2mq6BwSyyharKDCKpISJ6XtA=;
        b=K3zgBPOWp0d7m1UvnYaWqu0jJM0gAKzaKKuVj2+KuOuD6jEG5x6eLOsepwou/HqWJN
         ahcym17xzpIumssQwaNAO3piydbiqFm0wAbXDoOF6QEX0ySsPWBS+uxXgCOTvpZiWI0x
         32+S0F2I0oYNTGqGYVir3vxxtA239E7r4T5+/2dur/QLIFnvrUYY6137E8ecM8ov1ILa
         DrNEPK5TrMaSbQHiTOEEtm6YQRp+yMUgF7mwq+74dqmeeKLK0NwkuXhnAzCEtBGmbg+C
         1IhWvu4aK6qohUpxdFkvdCO/oPykm8LMpzNaeSEJ86uX8kVM55B9bOnOGapID832Vg8n
         c/eQ==
X-Gm-Message-State: AOAM531VVnx+IGTH24Fr8KtnS3Bo9xCJH7D+LPLYZ//lAhf30VkCbAZH
        loaM7Jb9QO9yvPXvWkTfwSP3znhi2fI=
X-Google-Smtp-Source: ABdhPJz8249ScJhwB5+HzWsPxOFqrK4AD4CpygCzAHd/j2U9CxW/AP6TZLPWefoKBzWwvpEp5uvngA==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr2621568ljc.353.1610146038257;
        Fri, 08 Jan 2021 14:47:18 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id n13sm2355960ljj.70.2021.01.08.14.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:47:17 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     ric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] 9p: Constify static struct v9fs_attr_group
Date:   Fri,  8 Jan 2021 23:46:50 +0100
Message-Id: <20210108224650.25872-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of v9fs_attr_group is to pass its address to
sysfs_create_group() and sysfs_create_group(), both which takes pointers
to const struct attribute_group. Make it const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 39def020a074..cdb99507ef33 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -583,7 +583,7 @@ static struct attribute *v9fs_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group v9fs_attr_group = {
+static const struct attribute_group v9fs_attr_group = {
 	.attrs = v9fs_attrs,
 };
 
-- 
2.30.0

