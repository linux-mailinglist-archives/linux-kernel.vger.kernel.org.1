Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5C2ED533
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbhAGRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbhAGRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:10:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E792311E;
        Thu,  7 Jan 2021 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610039415;
        bh=6v6WVnoIqE7sw9jFJHSBEaEkEMiJorGTXyZgfaoOsng=;
        h=From:To:Cc:Subject:Date:From;
        b=fB/tYTPGvEPuwegov2o7wP8qWBqKsxjIlmBnkC4PixRGtf7Un5m5ie+P10dh0fX+Q
         WHQ5em/W4HCcjwMtPpALOf9+G0FKuM2i7WKUJQ/V1FJ6K98SN4Hl7udJ0tuBhwUKT+
         T+7L91x7kpjyagopX+63sfXD8FY37iQ7xGXhExRUeX31LBOAgoeIVZZD0ONM+ymC6P
         vh+vizFKKCaSJJEO3wk0ZrJim1T/kgj+RfWJf+4xvWa/27BQthtnA4GCd3I4VjvkXj
         lQKSyiQjbY4mlaOX/+E3jOw3hdQPX7d9RX68nIlBYJwJy2mb3V1gtLTd/UP8STJSdg
         Qrn4v90TX9INg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.11-rc2
Date:   Thu, 07 Jan 2021 17:09:30 +0000
Message-Id: <20210107171015.38E792311E@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.11-rc2

for you to fetch changes up to f6bcb4c7f366905b66ce8ffca7190118244bb642:

  regmap: debugfs: Fix a reversed if statement in regmap_debugfs_init() (2021-01-05 14:34:41 +0000)

----------------------------------------------------------------
regmap: Fixes for v5.11

A couple of small fixes for leaks when attaching a device to a
preexisting regmap.

----------------------------------------------------------------
Dan Carpenter (1):
      regmap: debugfs: Fix a reversed if statement in regmap_debugfs_init()

Xiaolei Wang (1):
      regmap: debugfs: Fix a memory leak when calling regmap_attach_dev

 drivers/base/regmap/regmap-debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
