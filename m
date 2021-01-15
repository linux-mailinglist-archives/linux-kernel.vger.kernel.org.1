Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FB2F89A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbhAOXzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbhAOXzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610754835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Thctzl8klIQqyWFoS30BrYAYHvmPyy4D1w4+D1EI1xg=;
        b=XIEIKqIvuSBxx+TKv2EgiNrcMofbpRaP2rTewmqYb5v0m1kJ63mcyxKildE8YpIinhmUBR
        KPoW7tG/mobHrQBLoDqnuKzO7p9FtQB2R3WKbvywh8jZZ+BGtc7Y9Ps64ZSW5TWWWwXeEi
        Py+0sExnLrn6Q8MhcN/o+Jrwxnjj4sY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-um26qqXjMnKj2ZunnbH0Bw-1; Fri, 15 Jan 2021 18:53:53 -0500
X-MC-Unique: um26qqXjMnKj2ZunnbH0Bw-1
Received: by mail-qt1-f200.google.com with SMTP id l7so8777962qth.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Thctzl8klIQqyWFoS30BrYAYHvmPyy4D1w4+D1EI1xg=;
        b=nPGia8gE9OyaE9WiKSLO5mvjMzhE0lr0x8R0gkZL0JT9IYliXwn5fXEhHIOfzyeFnh
         fXHioiPDCspVHHwFs7xl7+MztcUYOh4lQ+AINBGS3MYyCWl31HiRcgB1p2lHwnxbzvNi
         6oIScUPAgCfzJ0Dez9IBnG7JnzusvqliiBWVGJ1R2mSqJD0ziuWiP/d+GsMtQUcCDCSi
         ZouUhUEc3z9C1Mryxn52/KyzFBDUsTVNz+bJIKQWkxK/Jl5/Tp44LMA6LIArYbMer8jM
         ipand2iRhqb2qX4c59BNq8L8d3UKuzktwe4TgeHfzJv5DpHcX6W6Hlw7hiW1qPg1Ny8N
         unMQ==
X-Gm-Message-State: AOAM533KnVQX7i6q++i10ScMOm8z16kqXBNQtHjqBbnR6NYHcvI9RaGD
        lwE5lNMrLrNZXPg9yHUT2jVwhYw+P3CZPLH61s+tocWJYZY2xRuhSEdfoCso9H6tCRifVzNs+lG
        A58uU+BPhgYV+dm1tKG+pzbKG
X-Received: by 2002:a37:96c3:: with SMTP id y186mr15267224qkd.4.1610754833345;
        Fri, 15 Jan 2021 15:53:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXenh3LZHSB9oryu10qlwgY/Nbv0o35C8OvNje9SuTRk3JnnmE74Bm4fww/Gwnqpy3N7jsLA==
X-Received: by 2002:a37:96c3:: with SMTP id y186mr15267210qkd.4.1610754833141;
        Fri, 15 Jan 2021 15:53:53 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p13sm6071345qkg.80.2021.01.15.15.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 15:53:52 -0800 (PST)
From:   trix@redhat.com
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: phy: national: remove definition of DEBUG
Date:   Fri, 15 Jan 2021 15:53:46 -0800
Message-Id: <20210115235346.289611-1-trix@redhat.com>
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
 drivers/net/phy/national.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/national.c b/drivers/net/phy/national.c
index 5a8c8eb18582..46160baaafe3 100644
--- a/drivers/net/phy/national.c
+++ b/drivers/net/phy/national.c
@@ -19,8 +19,6 @@
 #include <linux/phy.h>
 #include <linux/netdevice.h>
 
-#define DEBUG
-
 /* DP83865 phy identifier values */
 #define DP83865_PHY_ID	0x20005c7a
 
-- 
2.27.0

