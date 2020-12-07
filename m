Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089CB2D17CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgLGRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:48:35 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:58323 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725852AbgLGRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:48:34 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@nvidia.com)
        with SMTP; 7 Dec 2020 19:47:47 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7Hll1Y001902;
        Mon, 7 Dec 2020 19:47:47 +0200
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     andy@infradead.org, hdegoede@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH platform 0/2] platform/x86: mlx-platform: Fix item counter assignment
Date:   Mon,  7 Dec 2020 19:47:43 +0200
Message-Id: <20201207174745.22889-1-vadimp@nvidia.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix array names to match assignments for data items and data items
counter for power and fan attributes.

Patch #1: Provide fixes for system types MSN2700, MSN24xx.
Patch #1: Provide fixes for system type MSN2700/ComEx.

Vadim Pasternak (2):
  platform/x86: mlx-platform: Fix item counter assignment for MSN2700,
    MSN24xx systems
  platform/x86: mlx-platform: Fix item counter assignment for
    MSN2700/ComEx system

 drivers/platform/x86/mlx-platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.11.0

