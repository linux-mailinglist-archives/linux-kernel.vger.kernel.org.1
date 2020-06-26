Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42520BA80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFZUqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 16:46:36 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39095 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:46:36 -0400
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 07608100004;
        Fri, 26 Jun 2020 20:46:32 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>, krzk@kernel.org,
        linux@armlinux.org.uk, olof@lixom.net, sudeep.holla@arm.com,
        ludovic.desroches@microchip.com
Subject: Re: [PATCH] ARM: configs: at91: sama5: Enable CLASSD
Date:   Fri, 26 Jun 2020 22:46:32 +0200
Message-Id: <159320438192.1518713.7066726725417998350.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618154147.687878-1-codrin.ciubotariu@microchip.com>
References: <20200618154147.687878-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 18:41:47 +0300, Codrin Ciubotariu wrote:
> CLASSD is present on SAMA5d2 SoCs.

Applied, thanks!

[1/1] ARM: configs: at91: sama5: Enable CLASSD
      commit: 7651d824125c7a1819e5700246dbb5582ba85c98

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
