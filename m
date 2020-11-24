Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0D2C23C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgKXLHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:07:39 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49943 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732732AbgKXLHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:07:34 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3CF5D1BF20C;
        Tue, 24 Nov 2020 11:07:31 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pcmcia: at91_cf: move definitions locally
Date:   Tue, 24 Nov 2020 12:07:30 +0100
Message-Id: <160621597363.1087931.2225027989675268841.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930184804.3127757-1-alexandre.belloni@bootlin.com>
References: <20200930184804.3127757-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 20:48:02 +0200, Alexandre Belloni wrote:
> struct at91_cf_data is only used in the driver since all the platforms moved
> to device tree, move its definition locally.

I've now applied those patches on the at91-drivers branch, please shout if you
want them to go through your branch.

[1/2] pcmcia: at91_cf: move definitions locally
      commit: 496e9b64d7297d3e6c209c51218cee2939694b25
[2/2] pcmcia: at91_cf: remove platform data support
      commit: 91be3e89f450aa738204f6629f06d8b0e3d8d77b

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
