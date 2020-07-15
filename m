Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1D22108D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgGOPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:11:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E77C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:11:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a1so2516014ejg.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANeFtpgsDdH07BSJ3r/FEFFwUnnrJcRtNy/hmdhNkgo=;
        b=CtElDGHwYMrTdIlhaLD1XghrGm7sOuxMcREU4G1+MeXHBsLAHwZQpRNGd8LxGfhatk
         baEZ5wD4vdtyPXjPrUECNCbURnZjynmvkx/DDmocxb6mS+P+yKz/scLtTdmt5Un9KMqb
         AjukBAkU4Ji/CtSw/2g215xbpih0/QppZgQEaskyWccy21ZttVePZjFOpLCecRtJxoWb
         6U0UVJFBCDvLBUxZ+OV72zZCw4jjt60N6zbtMhteCLSwUz7bbz2iQ+dgZQoVblAMSumq
         dlVqn075KFBaTOdPXLnXkeEhlRafu1yMv10lFMd6AwkhUvcq5wC+AwN7bOklqp27BIm0
         vA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANeFtpgsDdH07BSJ3r/FEFFwUnnrJcRtNy/hmdhNkgo=;
        b=NcG6SvfPoSAi2PR9599KQn8UZdYQ6609P8J54YBA0FmHtxhMLuWK5Y9VbVoVR6zGzJ
         LoK8Ikt7ixrT8JqI4VwgA6USj1MbdnlHZJimqyQg4GW14ViK4NKMycm5xxs/t452/k7S
         zxYNaZ9LyRlJq89z3qjIpWv0HMVSWLZnotuF5ZgnNbgNOfBexIvTHBkDmg38M59qnlEP
         mwsvQzXWqG1QpW9C35klUpfiIcN27t/vl4fxGrih41QcC5DrMzFFOs7r8NxnvQ/2IjkG
         GfgmY7ByJxlS8Qc221Q3fUOliW7nLLg5qE2uFyISkg299lDK58fnUBW6LrIhsKvpbJtQ
         Oaag==
X-Gm-Message-State: AOAM533sMa+Kw+yt8y0Mu67Swt4ldNYsmQP8jkGdPf7Ui+TZ7JE887cs
        lfCA7AyZ19AsvOn6gxW0vhsM0fJQlIlAmBZz
X-Google-Smtp-Source: ABdhPJwjncRyfVHDwFt/3ntCvC2oC0UWO+uG/6cIda5CX6SJAx8a+b7ol2DJ8QpryqmqsjYGEAWUWg==
X-Received: by 2002:a17:907:2170:: with SMTP id rl16mr10125880ejb.422.1594825910229;
        Wed, 15 Jul 2020 08:11:50 -0700 (PDT)
Received: from garrit-VirtualBox.fritz.box (p5dd0dd67.dip0.t-ipconnect.de. [93.208.221.103])
        by smtp.gmail.com with ESMTPSA id m6sm2248824eja.87.2020.07.15.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:11:49 -0700 (PDT)
From:   Garrit Franke <garritfranke@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Garrit Franke <garritfranke@gmail.com>
Subject: [PATCH v2] kobject: remove unused KOBJ_MAX action
Date:   Wed, 15 Jul 2020 17:11:16 +0200
Message-Id: <20200715151116.6098-1-garritfranke@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714063517.GB662760@kroah.com>
References: <20200714063517.GB662760@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop in lib/kobject_uevent.c that checked for KOBJ_MAX is no longer present, we do
a much more sane ARRAY_SIZE() check instead (see 5c5daf657cb5).
Therefore, the KOBJ_MAX is not used anymore.

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 include/linux/kobject.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 6cba088bee24..ea30529fba08 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -59,7 +59,6 @@ enum kobject_action {
 	KOBJ_OFFLINE,
 	KOBJ_BIND,
 	KOBJ_UNBIND,
-	KOBJ_MAX
 };
 
 struct kobject {
-- 
2.25.1

