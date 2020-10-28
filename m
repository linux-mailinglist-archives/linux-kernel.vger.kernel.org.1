Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B52929D60F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgJ1WLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:30 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41992 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbgJ1WLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:24 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id BF0DE3ACB7D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 20:28:56 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 38789C0009;
        Wed, 28 Oct 2020 20:28:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Kai Stuhlemmer <kai.stuhlemmer@ebee.de>
Subject: Re: [PATCH] ARM: at91: sam9x60 SiP types added to soc description
Date:   Wed, 28 Oct 2020 21:28:22 +0100
Message-Id: <160391688365.399357.8129509159302322736.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008125028.21071-1-nicolas.ferre@microchip.com>
References: <20201008125028.21071-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 14:50:28 +0200, nicolas.ferre@microchip.com wrote:
> Adding SAM9X60 SIP variants to the soc description list.

Applied, thanks!

[1/1] ARM: at91: sam9x60 SiP types added to soc description
      commit: 786c395dbe4216c2349914952b8cdb57ea8a326a

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
