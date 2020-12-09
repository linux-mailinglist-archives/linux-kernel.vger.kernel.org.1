Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D442D4F00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgLIXtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:49:46 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50809 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgLIXtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:49:46 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AF16260004;
        Wed,  9 Dec 2020 23:49:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/6] iio:pressure:ms5637: add ms5803 support
Date:   Thu, 10 Dec 2020 00:48:51 +0100
Message-Id: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for the Measurement Specialities ms5803. It is
very similar to the ms5805 but has a different PROM layout (which I
suspect predates the ms5805 PROM layout). Also it supports less
frequency sampling options.

After a bit of preparatory work in the ms5637 driver and its common
library, mainly to handle the PROM layou and sample frequencies, adding
support is trivial.

Alexandre Belloni (6):
  iio:pressure:ms5637: switch to probe_new
  iio:pressure:ms5637: introduce hardware differentiation
  iio:pressure:ms5637: limit available sample frequencies
  iio:common:ms_sensors:ms_sensors_i2c: rework CRC calculation helper
  iio:common:ms_sensors:ms_sensors_i2c: add support for alternative PROM
    layout
  iio:pressure:ms5637: add ms5803 support

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 .../iio/common/ms_sensors/ms_sensors_i2c.c    | 76 +++++++++++++++----
 .../iio/common/ms_sensors/ms_sensors_i2c.h    | 15 +++-
 drivers/iio/pressure/ms5637.c                 | 73 +++++++++++++-----
 4 files changed, 128 insertions(+), 38 deletions(-)

-- 
2.28.0

