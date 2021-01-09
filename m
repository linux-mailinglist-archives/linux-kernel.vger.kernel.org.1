Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5C2F004E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAINz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 08:55:56 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:59917 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAINz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 08:55:56 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B4F351F4EA;
        Sat,  9 Jan 2021 14:55:13 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-input@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net,
        dmitry.torokhov@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 0/2] Add support for Goodix GT9286 chip
Date:   Sat,  9 Jan 2021 14:55:10 +0100
Message-Id: <20210109135512.149032-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the GT9286 chip, tested on F(x)Tec Pro1 (MSM8998).

AngeloGioacchino Del Regno (2):
  input: goodix: Add support for Goodix GT9286 chip
  dt-bindings: ts: goodix: Add binding for GT9286 IC

 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 1 +
 drivers/input/touchscreen/goodix.c                              | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.29.2

