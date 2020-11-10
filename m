Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC892AD400
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgKJKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:43:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FAAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:43:42 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so8437927pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJcQmaD585nvGEEKsRqlrTZmfOresK0VYOAgqhGxmiY=;
        b=snACxGuvSW5Azjd9ARYJ7GaRRMD1bcWSJ2kPcyqILs5/UtuUTEj+J2wTgL360w/3gv
         X9z6/Pt4bHftRPNhMCrLLGSdbTclranV23QugeBTmgtdJ8KzCMVU3oa0qfcTXnv+a8t0
         t1YbxhHE9Cu68MeISkecbB/6Mf90BtstS2EgvBfYgMo+jcHEU//FYnwhThbHCCYOWMZt
         B421eZLnoXLV1kKhJIzftU3aHyNr35QszWFRNJ0FArU6i2wn4EXP47uV4qZHBaDC/l7z
         4Lo1JHGVND+RJRshiIO21RUbskNv2zBwTdNnPs/pTEwNjNJimQ2g+FSgE7xDI44k1Ixf
         9pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJcQmaD585nvGEEKsRqlrTZmfOresK0VYOAgqhGxmiY=;
        b=oczil3n1wZVF8+IGxWdj5AmMAWG815DV6ivjnn/jDHHuvr3Tlx7LZEEe8dTcax+Kvs
         GQCGmiszTEIHJuGfZbtGE0j1BRfC0ehtxiwyWDYTns7Fj8kplvmbTs09AAl9hL17m4Nx
         g78seCAuSfvw7gXrnBR71ypvBYiK+LPtfElFTuxUbmbsi50hJzRkMTVUW0JRzBllWnwv
         AaKZNakW3RmeXMKXgXGAy7vzjewQGVbEiKH3Y1HRauMnmGkpiwG1QB286PIj8fHECaz5
         s4+c7z9YBrb7ILcbpUds0V7CPZpo17kqh3B1dTtQoDv3aixhakzcWM1z4Udnho3rdQBJ
         iNJQ==
X-Gm-Message-State: AOAM533GznbqD4xm1wrrhy2egASz0lQUwIuZ6nRPh+D1zMCZcayGC5/v
        nsF2+yo8/CKBCLcPMzHODRvjeg==
X-Google-Smtp-Source: ABdhPJwCa1ixceXALYAZn6qUfAqcAJog/vO1fFgdIO4eD9owfj+ZQUFyHb21KiyyQqUnq6yAriELXg==
X-Received: by 2002:a17:90b:3594:: with SMTP id mm20mr4363010pjb.90.1605005021999;
        Tue, 10 Nov 2020 02:43:41 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id c4sm14085616pfo.62.2020.11.10.02.43.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 02:43:41 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: thermal: time_in_state is displayed in msec and not usertime
Date:   Tue, 10 Nov 2020 16:13:37 +0530
Message-Id: <d5461bdf9ab6b6fee7f28f538582edbb426aa077.1605004905.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs stats for cooling devices shows the time_in_state in msec,
remove the unwanted usertime comment.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/driver-api/thermal/sysfs-api.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index b40b1f839148..e7520cb439ac 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -654,8 +654,7 @@ stats/reset
 	The amount of time spent by the cooling device in various cooling
 	states. The output will have "<state> <time>" pair in each line, which
 	will mean this cooling device spent <time> msec of time at <state>.
-	Output will have one line for each of the supported states.  usertime
-	units here is 10mS (similar to other time exported in /proc).
+	Output will have one line for each of the supported states.
 	RO, Required
 
 
-- 
2.25.0.rc1.19.g042ed3e048af

