Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C750273260
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgIUTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgIUTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:04:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:04:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 185so18146197oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cKrN3WdDNV8/lFmLblMOrAbq3oeIGBgEeOUaeWBL6s=;
        b=enHq3cSRYPNAby1KRfZzos8tiQ1DQFoVUb6KM+dFg6Oso6PMjGqiT0mPL38MP8DE2y
         fKxHHRYTAAuHufuqd8i87/H4CdAXPNB8B/v+BvXrOfeHHlrG/TG+wd6gCJuK+f14tsWs
         Rv7Nh8pgQtn9Sjfo8wNup+SltlVdoOvW2ZwmfxbQaHaXDoAX3ldyXNMvzO9//HbzaZMb
         FOma7ZyeKVbP3DGQocyh8mrYKIfILUs/N+x4Jr6+P3v8fiiWkTtHYffYuK4F5eWYfYv9
         ZdknmpjPxm5EFJZNQFnIZuDjemTFt6CXp6hb+KA07hFIb0wUUBdLz50Xv35eCg029bg0
         ikow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cKrN3WdDNV8/lFmLblMOrAbq3oeIGBgEeOUaeWBL6s=;
        b=cvq1ZDW5X5zJREvvSNOsgBqfz+t7XlqVRItNlZcjEiDYWyygKfAd7YGoLAq5wu6mqH
         POnCt8dITbMq91o8kxjOcTE131n4EjA4Cvk3d0EzodLa7WA3hpHkCjfsF1/Rlzhdscdi
         zYbpKYtx4taNQCj5s8G8tnEFqsuHJiNqWold2dSFc/HMQb56R+ViEdA5O6q2JDrZoxoT
         3W2gJsyjdJZz7uuQIkADevdPfWfUSnTuv4w6G2oQVKL4nZRhGBekiLpbwXoKOE8rmRS9
         9fViKFYjXQlez+a3Cx0N3jKZ2ZyuMqcGqB5UZN0K28TEXL0Lux63papD6HKA8baFab15
         C6Vg==
X-Gm-Message-State: AOAM532ATHP/Es04tBsWbVkAKg5zHqAaNjD6m5oDw0zRTa2LpAVgqk+v
        4CCNW4eByg9JAzT58/2itUk=
X-Google-Smtp-Source: ABdhPJzvpi3psh4W1vlt9WVUYcZwzS7lQcS/RS/RzsZuH9smP3REPLC7Vw2NAydQfeBI/7ePXl7qOw==
X-Received: by 2002:a54:4484:: with SMTP id v4mr498474oiv.143.1600715080870;
        Mon, 21 Sep 2020 12:04:40 -0700 (PDT)
Received: from frodo.comcast.net ([2601:284:8203:5970::2931])
        by smtp.googlemail.com with ESMTPSA id f1sm7426493ooq.12.2020.09.21.12.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 12:04:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] dyndbg: 2 fixes/cleanups for 5.9
Date:   Mon, 21 Sep 2020 13:04:31 -0600
Message-Id: <20200921190433.1149521-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 things which might qualify as fixes
  a bad (reverted) patch hit a BUG_ON, change that to return -EINVAL instead
  keep useful part of the reverted patch, use keyword, arg varnames

Jim Cromie (2):
  dyndbg: dont panic over bad input
  dyndbg: use keyword, arg varnames for query term pairs

 lib/dynamic_debug.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

-- 
2.26.2

