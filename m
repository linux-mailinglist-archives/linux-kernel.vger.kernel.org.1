Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495FF2D416F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgLILwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:52:46 -0500
Received: from foss.arm.com ([217.140.110.172]:33448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbgLILwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:52:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36DE231B;
        Wed,  9 Dec 2020 03:52:00 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.24.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2918A3F718;
        Wed,  9 Dec 2020 03:51:57 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     lukasz.luba@arm.com, robh@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch
Subject: [PATCH 0/2] Add DT bindings with dynamic-power-coefficient for Mali GPUs 
Date:   Wed,  9 Dec 2020 11:51:41 +0000
Message-Id: <20201209115143.15321-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The patch set aims to add a new property dynamic-power-coefficient to Mali GPU
DT bindings. This property is known from CPUs and they are both aligned. It
is used for Energy Model registration.

Regards,
Lukasz Luba

Lukasz Luba (2):
  dt-bindings: mali-midgard: Add dynamic-power-coefficient
  dt-bindings: mali-bifrost: Add dynamic-power-coefficient

 .../bindings/gpu/arm,mali-bifrost.yaml          | 17 +++++++++++++++++
 .../bindings/gpu/arm,mali-midgard.yaml          | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.17.1

