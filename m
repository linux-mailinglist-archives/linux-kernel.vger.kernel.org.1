Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E8303AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404302AbhAZKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbhAZCFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:05:55 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A229BC0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:01:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b17so2305591plz.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuvqgCacX4Pb/J8emd8ASYQj+aaRXfkyo5/tJUTXC18=;
        b=Q1nyIoOg9cA/NbhZwjGDZ1yfAR40idBgrI8GJtJYQD0Jy5i4RP5cMAnGe8d3sup0X9
         TtInhbmtjpHx5/vQC6JZ25GsSIDxUgJkKpRCryJVAUzjjG39MnQ33CfJtSDKLYdgc6du
         MQ9XR+oahIBNnUJIEzG9uyxkdZI3aRmVXxjRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuvqgCacX4Pb/J8emd8ASYQj+aaRXfkyo5/tJUTXC18=;
        b=IH9z09eIA7eQDAnbaTlUvhcV40P/I2Z3o+YQ+Q24L75yQtuNuduTfNBojeIQekpOGm
         V+V+UV/yUCv7FtAZuD5X4kwWy/hNwkimaCD9B2/B+CtMzhwbGSZ0G/DNw3j2FkSkF7eE
         j0EOsTW8XQv5UbaH9xpPAww8XAyVCrQU8DPFLbFit48gsblBbslhXHRZXQGjxouDdUZ/
         MEsOR7ppPPP0S8cVM5cOjQeQ1pjYSfQAirR/ayt0CmIHIF1E6v4qfQv+13I6JWaOELDr
         hEFwJymFkBgPQb+LsXLct7lBVPMWP1C9xVUOpAIXi2IuiW6bPVJ8BvS3ezoAQDgHI7Zb
         NMaw==
X-Gm-Message-State: AOAM5337YOIDDgTAvOjgnMrvo+6OOrJuBBpaFuumvJjJUhh4hkD+MCDR
        OIh0Uepql2x0OCbLUfKJAxla+Q==
X-Google-Smtp-Source: ABdhPJw/S2YrtvvvxKvJJZka0jRnlXv6swbqbI0W46SZnmLlTUVuNP8AiVQFCtSIVh74m6nO4eXWsQ==
X-Received: by 2002:a17:90a:f318:: with SMTP id ca24mr3337732pjb.30.1611626480086;
        Mon, 25 Jan 2021 18:01:20 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id n2sm16975028pfu.42.2021.01.25.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 18:01:19 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Krishna Manikandan <mkrishn@codeaurora.org>
Subject: [PATCH] drm/msm/kms: Make a lock_class_key for each crtc mutex
Date:   Mon, 25 Jan 2021 18:01:13 -0800
Message-Id: <20210126020117.2753615-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep complains about an AA deadlock when rebooting the device.

============================================
WARNING: possible recursive locking detected
5.4.91 #1 Not tainted
--------------------------------------------
reboot/5213 is trying to acquire lock:
ffffff80d13391b0 (&kms->commit_lock[i]){+.+.}, at: lock_crtcs+0x60/0xa4

but task is already holding lock:
ffffff80d1339110 (&kms->commit_lock[i]){+.+.}, at: lock_crtcs+0x60/0xa4

other info that might help us debug this:
Possible unsafe locking scenario:

CPU0
----
lock(&kms->commit_lock[i]);
lock(&kms->commit_lock[i]);

*** DEADLOCK ***

May be due to missing lock nesting notation

6 locks held by reboot/5213:
__arm64_sys_reboot+0x148/0x2a0
device_shutdown+0x10c/0x2c4
drm_atomic_helper_shutdown+0x48/0xfc
modeset_lock+0x120/0x24c
lock_crtcs+0x60/0xa4

stack backtrace:
CPU: 4 PID: 5213 Comm: reboot Not tainted 5.4.91 #1
Hardware name: Google Pompom (rev1) with LTE (DT)
Call trace:
dump_backtrace+0x0/0x1dc
show_stack+0x24/0x30
dump_stack+0xfc/0x1a8
__lock_acquire+0xcd0/0x22b8
lock_acquire+0x1ec/0x240
__mutex_lock_common+0xe0/0xc84
mutex_lock_nested+0x48/0x58
lock_crtcs+0x60/0xa4
msm_atomic_commit_tail+0x348/0x570
commit_tail+0xdc/0x178
drm_atomic_helper_commit+0x160/0x168
drm_atomic_commit+0x68/0x80

This is because lockdep thinks all the locks taken in lock_crtcs() are
the same lock, when they actually aren't. That's because we call
mutex_init() in msm_kms_init() and that assigns on static key for every
lock initialized in this loop. Let's allocate a dynamic number of
lock_class_keys and assign them to each lock so that lockdep can figure
out an AA deadlock isn't possible here.

Fixes: b3d91800d9ac ("drm/msm: Fix race condition in msm driver with async layer updates")
Cc: Krishna Manikandan <mkrishn@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/msm_kms.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index d8151a89e163..4735251a394d 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -157,6 +157,7 @@ struct msm_kms {
 	 * from the crtc's pending_timer close to end of the frame:
 	 */
 	struct mutex commit_lock[MAX_CRTCS];
+	struct lock_class_key commit_lock_keys[MAX_CRTCS];
 	unsigned pending_crtc_mask;
 	struct msm_pending_timer pending_timers[MAX_CRTCS];
 };
@@ -166,8 +167,11 @@ static inline int msm_kms_init(struct msm_kms *kms,
 {
 	unsigned i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++)
-		mutex_init(&kms->commit_lock[i]);
+	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++) {
+		lockdep_register_key(&kms->commit_lock_keys[i]);
+		__mutex_init(&kms->commit_lock[i], "&kms->commit_lock[i]",
+			     &kms->commit_lock_keys[i]);
+	}
 
 	kms->funcs = funcs;
 

base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

