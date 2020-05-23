Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E841DF6AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 12:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgEWKlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 06:41:44 -0400
Received: from v6.sk ([167.172.42.174]:40000 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgEWKln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 06:41:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id C9B86610B3;
        Sat, 23 May 2020 10:41:41 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/etnaviv: Tidy up clocks handling
Date:   Sat, 23 May 2020 12:41:33 +0200
Message-Id: <20200523104137.12562-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying patches that are chained to this message.

They make getting/enabling the clocks in the etnaviv driver slightly nicer,
first two also fix potential problems.

Compared to v1, patch 2/4 was fixed and patch 3/4 was added.

As it was pointed out in response to v1, the clocks documented as
mandatory by the binding document are different from what the driver
enforces. Moreover, there is no agreement on which clocks must be
present in the device tree, so I'm leaving the binding document until
it's cleared up.

In any case, the "core" clock is always present so it's safe to make it
mandatory and regardless of what ends up happening to the binding
documentation, the other clocks can't be enforced without regressions.
At most a comment or a warning could be added. I'm leaving it as it is.

Thank you
Lubo



