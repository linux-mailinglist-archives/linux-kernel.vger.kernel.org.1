Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D829ECF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgJ2NdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:33:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41701 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgJ2NdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:33:07 -0400
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3B3DB20008;
        Thu, 29 Oct 2020 13:33:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ludovic.desroches@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: configs: at91_dt: resync with media changes
Date:   Thu, 29 Oct 2020 14:33:05 +0100
Message-Id: <160397837814.704148.10188497580014584547.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029121223.871531-1-eugen.hristev@microchip.com>
References: <20201029121223.871531-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 14:12:23 +0200, Eugen Hristev wrote:
> The media tree Kconfig has changed recently, and a lot of modules were
> built unintentionally, like the dvb frontends and encoders.
> Resync the defconfig to build the ISI drivers and tested sensors.

Applied, thanks!

[1/1] ARM: configs: at91_dt: resync with media changes
      commit: 036f224ef8f447928bfd3085220c28e158a4e4d6

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
