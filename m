Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73E2285F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgGUQmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGUQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:41:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987BC0619DE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:41:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so21903414wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfDjUA593MuBMsUoDcOCldx6yOsIutwb3at5+hZcMH8=;
        b=uS2We1QXESiFdsyeFgZJ8qcpnYWSH4GYKE2+1ykiEWTD8Or0KBtvnLEePVpMEiaal3
         hsWv8ESjxXtzD3jLi0bl5YxQkygMBuQlnhuDVzrJtiZKbyLi9V0yX5dU6RW7Vtrm9YgN
         /jaW3SLJboEMgyVRUTGxnQZpOx07ejf01IhtMgz7AtJCQx8lwV0wJsbvMK8GKlHeLp+d
         JPlCih+LhE0ECuHHnMaaRxWA7POlAfaw6xYfA0GZVjb4kHbPORxP3qkUGGZPlQUg28ef
         l5OmbIHcKkHJhaCTytH64rwK406QK17r4SWrhc9aacKGwtnOTZnzU1O2iD03Oi+KrQbR
         mclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfDjUA593MuBMsUoDcOCldx6yOsIutwb3at5+hZcMH8=;
        b=GXbSIHn8VI0k3nEJMy/X89QOZjrFOjBmP3SHIjBAShJSWGFs2SG9pzSUCN2bIRmmLi
         vQmYgN0nXj2J29UZBPbxmLo5glAhayEsxXkrJf0b4BrEwQjEOmRdg9o0rk/XL8hWuAK0
         l3K/FBaH8R8SHp5sjw4ynMidcniY0Dis4gfmHPf3/379jYCYCaKl6EjdwafFX7njtv0O
         y5sSPo2969Qav1IPGLrfbb0YztU07FzzmNVr/NskjwJHr6zLMem31Vbtj4/zTZzRNir4
         /hF/jtmNFNdIhOlgc0F0rng3TR7xp1l2BEyWzATFXEjGqt8wCnG/RfQVrLl8w0STR31c
         YItQ==
X-Gm-Message-State: AOAM5327Q0GeYEO2s/gt3k5r8+NwdT18o4uTFvSXKDP3ZQxjiyBUsp8E
        /ROXRYMltk46TYJEUk7WtrQ8iQ==
X-Google-Smtp-Source: ABdhPJxlqrf9qoABZosf5QxKiUSbADvH9vyBoXG6UbDTJlUEZFhoTXnVzHyUvgYOxdedUp4pA+/fnQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr28343857wrq.189.1595349717570;
        Tue, 21 Jul 2020 09:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:41:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Subject: [PATCH 04/40] scsi: aacraid: rkt: Add missing description for 'dev'
Date:   Tue, 21 Jul 2020 17:41:12 +0100
Message-Id: <20200721164148.2617584-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And clean-up a couple of whitespace issues while we're here.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aacraid/rkt.c:64: warning: Function parameter or member 'dev' not described in 'aac_rkt_ioremap'

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aacraid/rkt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/rkt.c b/drivers/scsi/aacraid/rkt.c
index 5f2cede4d4776..8ebc67e541af0 100644
--- a/drivers/scsi/aacraid/rkt.c
+++ b/drivers/scsi/aacraid/rkt.c
@@ -57,6 +57,7 @@ static int aac_rkt_select_comm(struct aac_dev *dev, int comm)
 
 /**
  *	aac_rkt_ioremap
+ *	@dev: device to ioremap
  *	@size: mapping resize request
  *
  */
@@ -77,8 +78,8 @@ static int aac_rkt_ioremap(struct aac_dev * dev, u32 size)
  *	aac_rkt_init	-	initialize an i960 based AAC card
  *	@dev: device to configure
  *
- *	Allocate and set up resources for the i960 based AAC variants. The 
- *	device_interface in the commregion will be allocated and linked 
+ *	Allocate and set up resources for the i960 based AAC variants. The
+ *	device_interface in the commregion will be allocated and linked
  *	to the comm region.
  */
 
-- 
2.25.1

