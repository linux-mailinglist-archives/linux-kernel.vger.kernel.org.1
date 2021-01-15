Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC12F89AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbhAOX5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:57:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbhAOX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610754964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cGjEZEFUxe554punPGhls5fx0stMnIYqvwbTtWgboaU=;
        b=h4QfB/Yn7i6ZSrRctIPvNWjwyNdfmuuKAkU6oBXcQ/5XKLrR1ld1TKfS9skxr18bUXyZzs
        Cx7b79gHcXnzktGbEGtcUJf+EktM8d9uNf2fVIPW2IeptJTrx2CYF6G2S2IplZA7NR9X8f
        xEmVxk5vXZb1X46LQHxv2HG2gwTR/IE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-42mi1nj5OyePmZ3U2EN7Mw-1; Fri, 15 Jan 2021 18:56:00 -0500
X-MC-Unique: 42mi1nj5OyePmZ3U2EN7Mw-1
Received: by mail-qk1-f197.google.com with SMTP id e25so9660424qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGjEZEFUxe554punPGhls5fx0stMnIYqvwbTtWgboaU=;
        b=pA48AXzxQg91EDWTquyGftMi3HNMVOBuVcqclW0hgNhsQwpVYY33Gzdrc5vZlXhvxw
         FgQ4XDYGT/Jxsq7Z/jLxEFFGH0Mr8A4/GsHOjlRde9D0nNmmfdIHSRQurqL1pZabrd3k
         5rWnvAwqZm1aSFbnVCBlbdvSDNUEGxyVPDTXQJhusk1Blsbbpq02k0b5AeNQN63lkGzN
         01wMCTj/2ZVxudMHJ/7qk0F8dyHLik39zxzIrkSpAfaniU1v0PMH5crigJaaj6v6M7ad
         qLXD/Vef+t3t5YIGNXZbXduVaff9L4BvbjxESDvd38bAZT+Y80MxGx8e6Hi4mOlRjfFN
         VF/w==
X-Gm-Message-State: AOAM5325673OZuBmAtxL5O9bhHullz+rR68vKGd7lYcsL0/wTy6kdUqS
        jA8ELWudzKy+JrB3nzW0oR68V9w5fAH5D0pJ9A21nEY8LaC91G06w0ErCw0Ge6zttiBI8x5+wmh
        LHUex8AwfK/51nWO756gavvwz
X-Received: by 2002:a37:9ac9:: with SMTP id c192mr14533316qke.453.1610754959965;
        Fri, 15 Jan 2021 15:55:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpls7ZQlmvJu5XrFUrVZ5xSL5nXDsB8rVwbVCjXoNaUiafJx+npfQJFw5ceiTr+wxzt4bN1g==
X-Received: by 2002:a37:9ac9:: with SMTP id c192mr14533309qke.453.1610754959804;
        Fri, 15 Jan 2021 15:55:59 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q3sm6075310qkb.73.2021.01.15.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 15:55:59 -0800 (PST)
From:   trix@redhat.com
To:     dmitry.torokhov@gmail.com, hdegoede@redhat.com,
        gustavoars@kernel.org, luomeng12@huawei.com, rajatja@google.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Input: i8042: remove definition of DEBUG
Date:   Fri, 15 Jan 2021 15:55:53 -0800
Message-Id: <20210115235553.290476-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/input/serio/i8042.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index abae23af0791..411ebb2cefb5 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -111,7 +111,6 @@ module_param_named(nopnp, i8042_nopnp, bool, 0);
 MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 #endif
 
-#define DEBUG
 #ifdef DEBUG
 static bool i8042_debug;
 module_param_named(debug, i8042_debug, bool, 0600);
-- 
2.27.0

