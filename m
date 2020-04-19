Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA00A1AFC82
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgDSRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 13:12:03 -0400
Received: from v6.sk ([167.172.42.174]:43796 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgDSRMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:02 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 76297610AF;
        Sun, 19 Apr 2020 17:12:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] ARM: dts: Marvell SoC Device Tree updates (for 5.8)
Date:   Sun, 19 Apr 2020 19:11:42 +0200
Message-Id: <20200419171157.672999-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying the patches chained to this message to arm/dt.

I've sent about the same patch set before, but there were some issues
and it was way too close to 5.7-rc1. Sorry for that. I decided not to
hurry it, because none of the fixes is really all that important.

Majority of the patches just deal with reducing DT validation noise once
more schemas are converted to JSON-schema. Those that actually fix
things relevant to older released kernels have been Cc'd to stable@.

Thank you
Lubo


