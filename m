Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E42DBF30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLPLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:06:40 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:35078 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgLPLGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:06:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9403FFB02;
        Wed, 16 Dec 2020 12:05:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CGMzc-yQ5fH1; Wed, 16 Dec 2020 12:05:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5134A43FDF; Wed, 16 Dec 2020 12:05:54 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] regulators: bd718x7: Add enable times
Date:   Wed, 16 Dec 2020 12:05:53 +0100
Message-Id: <cover.1608116704.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the typical startup times from the data sheet so boards get a
reasonable default. Not setting any enable time can lead to board hangs
when e.g. clocks are enabled too soon afterwards.

This fixes gpu power domain resume on the Librem 5.

Guido Günther (1):
  regulators: bd718x7: Add enable times

 drivers/regulator/bd718x7-regulator.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.29.2

