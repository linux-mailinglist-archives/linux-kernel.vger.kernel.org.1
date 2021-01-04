Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30CD2E9D12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbhADSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:31:37 -0500
Received: from vern.gendns.com ([98.142.107.122]:38762 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbhADSbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vHOp9SccK0mfDJKqdnqjykG4G7mbS4+yCMHa+5JGryQ=; b=zMZqU27KDrzo1vdGSv7qgiG9p9
        jSUrqvCbSTeUGPt562Pom0TTTZRyY+nOOv8T4ugCFg92k01nuE+pFclUAAokk1yvOd+yCniTeHWmA
        e6m8dbXZK4+H74e9idLX7tzacblnyNAYjprbsddQpolgkrMUcHB7YS1lsAU2u8jGbF/+38R5MMCo7
        ZFP/pKX/j0FpIy0zwAYAEvli6X+Ck1gG/s1KDDesGt2C6MzE15Ua1dfkqUe+HfYso9gycFIyqBFzu
        gcZrg66La/ErVxZDvVaPa+IbIysmvuEMGPG8zBqFAfnPwVymQWi7YBacrcOBHAnMI11sTszBUQoyG
        9Amr52Kg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51064 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kwUd0-0002rB-Sy; Mon, 04 Jan 2021 13:30:51 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for TI AM18XX/OMAP-L138 PRUSS
Date:   Mon,  4 Jan 2021 12:30:19 -0600
Message-Id: <20210104183021.330112-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first step for adding support for the PRUSS on TI AM18XX/OMAP-L138
SoCs. This series adds support in the top-level PRUSS driver. (Patches for the
interrupt controller and individual PRUs are independent of this change and
will be submitted separately.)

David Lechner (2):
  dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
  soc: ti: pruss: add support for AM18XX/OMAP-L138 PRUSS

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  |  2 +
 drivers/soc/ti/Kconfig                        |  2 +-
 drivers/soc/ti/pruss.c                        | 76 +++++++++++--------
 3 files changed, 47 insertions(+), 33 deletions(-)

-- 
2.25.1

