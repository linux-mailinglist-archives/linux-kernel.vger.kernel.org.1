Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF281CBECF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 10:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEIISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 04:18:03 -0400
Received: from v6.sk ([167.172.42.174]:48952 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgEIISD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:18:03 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id EFA38610B1;
        Sat,  9 May 2020 08:18:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 0/3] phy: Add USB HSIC PHY driver for Marvell MMP3 SoC
Date:   Sat,  9 May 2020 10:17:51 +0200
Message-Id: <20200509081754.474787-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please consider applying this patch set. It adds the HSIC PHY driver for
Marvell MMP3 along with related DT binding changes (added since v1).

Thank you,
Lubo


