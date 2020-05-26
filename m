Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4C1DC99E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgEUJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 05:14:02 -0400
Received: from v6.sk ([167.172.42.174]:34758 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgEUJOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:14:02 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 2CF18610A5;
        Thu, 21 May 2020 09:14:00 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] DT: Improve validation for Marvell SoCs
Date:   Thu, 21 May 2020 11:13:47 +0200
Message-Id: <20200521091356.2211020-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

chained to this message is a second version of remaining patches from the
first spin of the "DT: Improve validation for Marvell SoCs" [1] patch set.

[1] https://lore.kernel.org/lkml/20200317093922.20785-1-lkundrak@v3.sk/

I've attempted to address the review of the v1, each patch includes a
detailed change log.

Compared to v1, wherever the license or maintainer information was
missing, I've filled in GPL-2.0-only and people listed in MAINTAINERS
file. As I've indicated in v1 cover letter, am not sure whether this is
the optimal course of action. However I've included the relevant people
in v1 Cc list and asked for clarifications, but didn't really get any
feedback to that.

Cheers
Lubo



