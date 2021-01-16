Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96962F8E5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhAPRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbhAPRiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:38:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03425C061574
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:37:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so17986545lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlad5VW9NeTfqd7HA+X6a+dEIIhoJaZNTXpl9GukvIg=;
        b=rdynwu6bHUZrdSUIffJFVlTKwxUfvEJLKYOps0F8p2xAZUB9o2Ey5tnt8NIQ/T9O5T
         7jeR2T+kiIoWrbndyxOIQinPHeg++cYdme7BJXM4navMCdE3TNy1ml/QDrkxTNC10+dW
         on/TjpuO3KvjmWPYJuGAfaJfyaNMtJAONrJgbCNO8CA3J1O+sjkWvWPpzd2VsE/09C9X
         RMajlIq9rQjb+RryBYdSuhsJXoEiTlJYWq3hR01XVojO06IZAS3r/DxH94sJb7gUz0Bp
         3Anl3Az9N4VdOHUXx03+fNHNEneBDB3qvl04wUG1izBShX15nXqWocTu2xjz7rYq0dPq
         Avxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlad5VW9NeTfqd7HA+X6a+dEIIhoJaZNTXpl9GukvIg=;
        b=ZkFR7B9uqjsu9pI2l8Oet/X0JCBpq42DBE/2WInhLHAAQVll89/xp4IIIrCfF6PRSK
         UBVjoctTsr4TWOomlL8vB26gMlhEXrRjdkiJwwKGG6GXQjVVZjjbHMAsKMjv3PZ/PceX
         uaZFX7YYjRRY8pdzsAOThShSVNHAXLvieJTMQr5hmX1ZGMuDh+tkvmjcQdVt+9i96OlI
         wB5wjcpulyzTJtv/DgEzZoOd9L1E/vapEH9bKnsO7/IidqwNsZ2yqsKhW7S8C0rZ+85i
         XgrrMIuEs/xTOA7kuDzs1OVsJP/iKaghmY9UsnkmSDNF1R7qkiDdEuM2TS10doJ7YzML
         ANGQ==
X-Gm-Message-State: AOAM531t5GQnic40Pu19rCVJ/dCsZkrJn2QJJqjTM/Nftn3xGxjout60
        V0uKxKnROCeaxLokVG8+J4Ho7w==
X-Google-Smtp-Source: ABdhPJyt6TvP8Y+qI7CXRsL8frgcmEEQpTsStblG1j4U4bhbJljH26LrCu03Duxs7j5K/dhWdnXcbg==
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr5667640lfu.328.1610818657321;
        Sat, 16 Jan 2021 09:37:37 -0800 (PST)
Received: from xps.lan (238.89-10-169.nextgentel.com. [89.10.169.238])
        by smtp.gmail.com with ESMTPSA id v7sm1134696ljk.60.2021.01.16.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 09:37:36 -0800 (PST)
From:   Odin Ugedal <odin@uged.al>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        dschatzberg@fb.com, surenb@google.com, Odin Ugedal <odin@uged.al>
Subject: [PATCH v2 0/2] cgroup: fix psi monitor for root cgroup
Date:   Sat, 16 Jan 2021 18:36:32 +0100
Message-Id: <20210116173634.1615875-1-odin@uged.al>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes PSI monitors on the root cgroup, as they currently
only works on the non-root cgroups. Reading works for all, since that
was fixed when adding support for the root PSI files. It also contains
a doc update to reflect the current implementation.

Changes since v1:
 - Added Reviewed-by tag on the original patch (Suren)
 - Updated patch title
 - Added a separate patch to update doc


Odin Ugedal (2):
  cgroup: fix psi monitor for root cgroup
  cgroup: update PSI file description in docs

 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 kernel/cgroup/cgroup.c                  | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.30.0

