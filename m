Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99802218166
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGHHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 03:40:53 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54134 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbgGHHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:40:51 -0400
Received: from [78.134.117.153] (port=41602 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jt4hE-0009Wd-DB; Wed, 08 Jul 2020 09:40:48 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH v2 2/4] MAINTAINERS: take over IDT VersaClock 5 clock driver
Date:   Wed,  8 Jul 2020 09:40:33 +0200
Message-Id: <20200708074035.31595-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708074035.31595-1-luca@lucaceresoli.net>
References: <20200708074035.31595-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek has been the primary developer of this driver (thanks!). Now as
he is not working on it anymore he suggested I take over maintainership.

Cc: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..5aa16c245c63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8324,7 +8324,7 @@ W:	https://github.com/o2genum/ideapad-slidebar
 F:	drivers/input/misc/ideapad_slidebar.c
 
 IDT VersaClock 5 CLOCK DRIVER
-M:	Marek Vasut <marek.vasut@gmail.com>
+M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
 F:	drivers/clk/clk-versaclock5.c
 
-- 
2.27.0

