Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED525D46A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgIDJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgIDJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:15:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F3C061244;
        Fri,  4 Sep 2020 02:15:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a15so7582779ejf.11;
        Fri, 04 Sep 2020 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dxahPGX4Bh5058cW7YZytcQVfwGeo/dvZ/Z3buLNEgI=;
        b=c161BctUHHXMJf3NH9GGNQWWIJqv5AUGjNOAu6Bx3o5Jlya5vcy/+7WBNuTs/5F6og
         ljDRVUZEp9f5/lht+DCfor9uGYCQkRc2TyWFIJFCcfFAhv53T6ub3oComBOw0VRdlI1E
         WVwsomS11BpBOc1jopv8knoO6LlwUjwWZPTBkX2fhvH+shITt1v9JzrVx5C9etCniet/
         lMkSEJNrMD+q8V9ulQBi5dZmWEvk6U82BoJ+F7XP8OYJHkkkMx2mQKozu3sKTQCCpSx2
         9EoEURQz+ZOqqwApbhk5GLMOx03wrxIDuyJqPPX7hFX42eyLhQI/26M5IWSZz0m8qPM7
         5W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dxahPGX4Bh5058cW7YZytcQVfwGeo/dvZ/Z3buLNEgI=;
        b=VqrWevh1TLRcPc341yg/JnSL4n1aGQ39XMS+eca4ZONmXBLHUkGVWLT4fNgmlin++g
         djlu9ev2zFgg7IpnUt4bJglT8pgvTLoapV8M1suF0fNs4vQboCsCoZSNYJuw+YfgSrvK
         PkjNTPWbPOOfjBskZQDZfN4vaN74XvOZUchXXjo6C6Vgv7PZW2kq6f0M691QGFah83tr
         at+Xg1NoIc5Jibv4rFtmzC9aSNg+eA34uXn3X5UjlnD4AYDRY8Dq79NSvMrNSx2dSwe2
         XVicIry+Y4ADTqVbnN4W9PQTevmlZ/O64jEUQbyplKfi+TFnYCDH1tLhuIQT1J1EFYWQ
         QaZg==
X-Gm-Message-State: AOAM532DEai+j4YaNPa/T0BFb8wdMFnKLZqBOvGU6icvHRi6O875aoWe
        DY8G2CbgJQOMdTIEPcfSwzE9qmnoZIELgA==
X-Google-Smtp-Source: ABdhPJyNi9OTyZw2VFnPvA+QkvNgnAyrYB3D2Nhm8U0fXkMq+OXyT4UGUEy5kcRB5mjWXCO41/uYlw==
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr6841091eja.438.1599210949388;
        Fri, 04 Sep 2020 02:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b904:9293:1d41:83f0:a723:a7e3])
        by smtp.gmail.com with ESMTPSA id a26sm5562066ejk.66.2020.09.04.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:15:48 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 0/2] use generic_file_buffered_read()
Date:   Fri,  4 Sep 2020 11:13:39 +0200
Message-Id: <20200904091341.28756-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (2):
  block: use generic_file_buffered_read()
  fs: isofs: use generic_file_buffered_read()

 drivers/block/sunvdc.c | 6 +++---
 fs/isofs/compress.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

