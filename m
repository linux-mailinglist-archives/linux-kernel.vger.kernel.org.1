Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE56B1FBDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 20:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgFPSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 14:24:26 -0400
Received: from v6.sk ([167.172.42.174]:47722 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbgFPSYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:24:21 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id ABB7D61625;
        Tue, 16 Jun 2020 18:23:49 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] MMP DTS updates for 5.9
Date:   Tue, 16 Jun 2020 20:23:28 +0200
Message-Id: <20200616182341.944473-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

chained to this message is a patch set I hope would end up queued into
soc/arm/dt for 5.9. It applies cleanly on top of v5.8-rc1.

I've checked I'm not adding new validation errors and booted the v5.8-rc1
kernels with appended DTBs on the XO-1.75 and Dell Ariel board.

Lubo


