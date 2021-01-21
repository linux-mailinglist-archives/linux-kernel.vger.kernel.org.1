Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1CF2FE880
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbhAULPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:15:08 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:56941 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730287AbhAULK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:10:58 -0500
IronPort-SDR: RrT9lEI0D1HrsUXwh0B7cbeXEitEVXjLmRow9o7KVIlINJAscPT45DDIrnVi5bsDubUF5yPxfr
 wRscUTeYIE5jYdZEMxZ3ezyWAjdnLU//kY8QBWmhNqn3EjciuvptsNuT+0eICtrWO/bfZ/PeNF
 g7d9jz6jmQMt4nYCqB3QT00Mu4h+gUpe8D1bgds83ERqqQ7kx48G//HtD18TAlr6l9COLvEHzq
 qVht9txxM2NqruKRygwkaYq5+51oqGs1Qy0YleX8PYvESL6Ug+B/3a8nxEH2K8WmQx0CYoz/X6
 19I=
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="15977607"
X-IronPort-AV: E=Sophos;i="5.79,363,1602514800"; 
   d="scan'208";a="15977607"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 21 Jan 2021 20:00:14 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 358D8E9E66
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:13 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 79F179BAFE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:12 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 5AD5A28; Thu, 21 Jan 2021 19:54:25 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v2 2/3] perf tools: Fix lexical definition of event name
Date:   Thu, 21 Jan 2021 19:54:24 +0900
Message-Id: <20210121105425.2695843-3-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the lexical definition of event name so that the numbers are recognizable.

A64FX defines an event name that starts with a number.
 - 0inst_commit
 - 1inst_commit
 - 2inst_commit
 - 3inst_commit
 - 4inst_commit

Signed-off-by: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
---
 tools/perf/util/parse-events.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097..e6bbbd0 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -205,7 +205,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
-- 
1.8.3.1

