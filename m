Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4311F539D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgFJLjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 07:39:02 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:2085 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgFJLjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:39:02 -0400
IronPort-SDR: QOZnzLdhziz0cwun+NJ8W3bVxIjr4WurjR7RBNs4PBZO+Eb4Cgyr5zPweL+8mSj6YsEbaDN2oE
 yVyWBhjMjAx+FoPoTJaFmc475fQXEyR96zKYUjy8ME6u4HtTtbe+nC+gR+OFbp44C9q6yQlE//
 NSHTzJ/4cDO9l/gq+Lm9eRINWtHlLBQR8nnCcEUOapEbihwnSDXM4zehioYXN8E0AtJisXu69N
 x14ySQG6VyUDFc61pV37PvrmTvEYO79jCuxY98akt+3QqcGqywHHsxq9HTm8la7hujvDPdkkSS
 BBg=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636204"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Jun 2020 13:38:59 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 10 Jun 2020 13:38:59 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 10 Jun 2020 13:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591789139; x=1623325139;
  h=from:to:cc:subject:date:message-id;
  bh=SCPwkIJO8ixVT8Es4oQfUibnuDS4476i4fJI4A1Ujgc=;
  b=qJkJvsLSmJ0AZEo35xr3qVmsvWZkLFV9cPCtPxx3UWgWxVeDhbl36dll
   5Lsp0gy/SbtXH3Gk7qc0Cktq3R+G0wyPx2M/1o7A/QjqODIFQmk3bvgVu
   KuYMG2zrkK9VHkNM+hI045ghDiruzoqxwmnvJM+Om6Oxn/MPzd5jQQH9G
   RtHNGPGZ9E9swqwY7rDbM71MWbVOLVd/dUGMr1dWTedfQihoXqqnC3CoS
   3Uh1vAPvqizcsQUWweKhNkPpHtNtDNYo1VzHVEzCxr8Rw+nPy3zMNlmJw
   c/7aMOWWJF9ThCgK+mpYyzglBbEZE5E7F4g7EgdHe/JPXLo7XSHE7uHYu
   g==;
IronPort-SDR: XUMlzlBV9h+REJeElJ2SARd/3O9iFEv8HKlxt0IDyFYU61iu+17k6VmCs3aBQXJ544Ayp9ykVO
 trIxKllXl0WKtlRuwCaRoODAizg/ZePSwvDfYzJiKc/v6anKBOZNML3BlSXUQCYpOp5c22nE2G
 +9FbHR+NgshCATn3WbujTigBuSB8l6ByO2Ht1tLfqj+EWYZ7kOZhXyLO2pjBh/+dGjpXmAm42N
 ltv9OmbZMc2ETh26zGY8XwWroosOMxBRNk+VgijpPwhU6blJFysmFukDQEA1GKnMPnErim7r6W
 6cA=
X-IronPort-AV: E=Sophos;i="5.73,495,1583190000"; 
   d="scan'208";a="12636203"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jun 2020 13:38:59 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 31011280065;
        Wed, 10 Jun 2020 13:38:59 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Krummsdorf <michael.krummsdorf@tq-group.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] clk: qoriq: add LS1021A core pll mux options
Date:   Wed, 10 Jun 2020 13:38:37 +0200
Message-Id: <20200610113837.27117-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>

This allows to clock the cores with 1 GHz, 500 MHz and 250 MHz.

Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/clk/clk-qoriq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 374afcab89af..5942e9874bc0 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -244,6 +244,14 @@ static const struct clockgen_muxinfo clockgen2_cmux_cgb = {
 	},
 };
 
+static const struct clockgen_muxinfo ls1021a_cmux = {
+	{
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV4 },
+	}
+};
+
 static const struct clockgen_muxinfo ls1028a_hwa1 = {
 	{
 		{ CLKSEL_VALID, PLATFORM_PLL, PLL_DIV1 },
@@ -577,7 +585,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 	{
 		.compat = "fsl,ls1021a-clockgen",
 		.cmux_groups = {
-			&t1023_cmux
+			&ls1021a_cmux
 		},
 		.cmux_to_group = {
 			0, -1
-- 
2.17.1

