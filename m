Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57072A871C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgKET15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:27:57 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:48545 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKET14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:27:56 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7BCB622F99;
        Thu,  5 Nov 2020 20:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oxdHvq0gz4GRGuGK+j8md3XnfhogL4o/bIOjGCNEplI=;
        b=kph3EZpmFZa9NQP52qqy6hBoRAyQm1wyOfyrJNO2jgowy3HhKZdXfpon9xJuyM5POYlU/A
        J3aZw/fnUOzZtec/W2FzomMSnbEEpR3GLukR3npCQHEky5D9VQ2qh4J4wyUipYIWdFOd3u
        rGzryq6+7Fy1n92cEMohHQUJuOz4fiI=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/3] clk: fsl-sai: fix memory leak
Date:   Thu,  5 Nov 2020 20:27:43 +0100
Message-Id: <20201105192746.19564-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 will fix the memory leak and can be picked up by the stable queues.
Patch 2-3 will add and use the devm_ variant to simplify the handling.

Please note that the new devm_ isn't exported as the original one isn't
exported either. I'm planning to post another patch which will add module
support to the clk-fsl-sai driver and this will then export the function.

Michael Walle (3):
  clk: fsl-sai: fix memory leak
  clk: composite: add devm_clk_hw_register_composite_pdata()
  clk: fsl-sai: use devm_clk_hw_register_composite_pdata()

 drivers/clk/clk-composite.c  | 50 ++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-fsl-sai.c    | 14 +++++-----
 include/linux/clk-provider.h |  7 +++++
 3 files changed, 64 insertions(+), 7 deletions(-)

-- 
2.20.1

