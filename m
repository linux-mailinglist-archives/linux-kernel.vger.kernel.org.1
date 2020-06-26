Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1089D20BA88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 22:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFZUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 16:48:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55411 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:48:19 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6049D20002;
        Fri, 26 Jun 2020 20:48:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        robh+dt@kernel.org, ludovic.desroches@microchip.com
Subject: Re: [PATCH v2] ARM: dts: at91: sama5d2_xplained: Remove pdmic node
Date:   Fri, 26 Jun 2020 22:48:16 +0200
Message-Id: <159320449048.1519242.4348779875317362688.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618152845.682723-1-codrin.ciubotariu@microchip.com>
References: <20200618152845.682723-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 18:28:45 +0300, Codrin Ciubotariu wrote:
> The PDMIC needs PDM microphones to work. sama5d2 xplained doesn't have
> such microphones, so there is no reason to enable PDMIC and take the
> pins since there is no-one using them.

Applied, thanks!

[1/1] ARM: dts: at91: sama5d2_xplained: Remove pdmic node
      commit: 51139cc82c8d6edec034a6c2401090070195fa13

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
