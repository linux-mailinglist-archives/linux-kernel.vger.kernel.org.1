Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54262BA670
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgKTJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgKTJmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:42:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3AE223B0;
        Fri, 20 Nov 2020 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605865331;
        bh=07pOOQlCf1AGEDTz1zs87GUSSMbKSFGMWO3JJGzRHPA=;
        h=From:To:Cc:Subject:Date:From;
        b=YlefRCN3zf5t5Fs8vJbnE671oSCmica0pA8MVDzFZFPRILhxbSFH0SEBTxkqGTlrS
         0Lb1thKVxN+O94OfspWVuT71QXDyXMwUvqIASQ3bafn0VjyUEQqs5S1fTOdv1f6vUG
         HJO5ZsKSNG5ECQB+1SgpA0GMTUByLQ9+ttnHiwmE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg2vh-00CDFB-6P; Fri, 20 Nov 2020 09:42:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] More meson HDMI fixes
Date:   Fri, 20 Nov 2020 09:42:03 +0000
Message-Id: <20201120094205.525228-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: narmstrong@baylibre.com, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, guillaume.tucker@collabora.com, kernel-team@android.com, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume reported that my earlier fixes for the meson HDMI driver
broke another set of machines which are now exploding (clock not
enabled).

I have thus reconsidered the approach and came up with an alternative
fix (enable a missing clock), which Guillaume confirmed to be working.
Jerome pointed out that this driver is leaking clock references like a
sieve, so that needed addressing too.

The first patch start by fixing the clock leakage using a devm
facility.

The second patch addresses the earlier crash by reusing the
infrastructure put together in the first patch.

Tested on VIM3l.

Marc Zyngier (2):
  drm/meson: dw-hdmi: Disable clocks on driver teardown
  drm/meson: dw-hdmi: Enable the iahb clock early enough

 drivers/gpu/drm/meson/meson_dw_hdmi.c | 51 ++++++++++++++++++---------
 1 file changed, 35 insertions(+), 16 deletions(-)

-- 
2.28.0

