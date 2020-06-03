Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8141ED72B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgFCUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 16:03:53 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:37842 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgFCUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:03:51 -0400
Received: from [78.134.115.170] (port=37458 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jgZc2-005dPA-O7; Wed, 03 Jun 2020 22:03:46 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [RFC 0/4] regulator: lp87565: ignore ENx pins and add LP87524-Q1
Date:   Wed,  3 Jun 2020 22:03:15 +0200
Message-Id: <20200603200319.16184-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
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

Hi,

the first patch in this series is a small but significant variation in how
the lp87565 driver enables the output rails, allow the kernel to always
know when it is enabling an output. However it can change existing
behaviour (depending on the hardware setup) and thus it should be carefully
evaluated.

The following patches are a fairly straightforward addition of a new chip
variant along with some DT bindings cleanup.

Luca

Luca Ceresoli (4):
  regulator: lp87565: enable voltage regardless of ENx pin
  regulator: lp87565: dt: remove duplicated section
  regulator: lp87565: dt: add LP87524-Q1 variant
  regulator: lp87565: add LP87524-Q1 variant

 .../devicetree/bindings/mfd/lp87565.txt       | 66 ++++++++++++++-----
 drivers/mfd/lp87565.c                         |  4 ++
 drivers/regulator/lp87565-regulator.c         | 21 +++++-
 include/linux/mfd/lp87565.h                   |  1 +
 4 files changed, 73 insertions(+), 19 deletions(-)

-- 
2.27.0

