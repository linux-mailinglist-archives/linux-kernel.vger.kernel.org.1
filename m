Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C1F2FD407
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbhATPce convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jan 2021 10:32:34 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58645 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390920AbhATP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:29:54 -0500
X-Originating-IP: 86.201.233.230
Received: from xps13 (lfbn-tou-1-151-230.w86-201.abo.wanadoo.fr [86.201.233.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 936A0FF80B;
        Wed, 20 Jan 2021 15:29:05 +0000 (UTC)
Date:   Wed, 20 Jan 2021 16:29:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] nand: raw: remove tango driver
Message-ID: <20210120162904.1a1588bf@xps13>
In-Reply-To: <20210120150555.1610132-1-arnd@kernel.org>
References: <20210120150555.1610132-1-arnd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@kernel.org> wrote on Wed, 20 Jan 2021 16:05:26
+0100:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The tango platform is getting removed, so the driver is no
> longer needed.
> 
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I didn't know. I'll just fix the title when applying to something like

	mtd: rawnand: tango: Remove the driver

If you don't mind.

Cheers,
Miquèl
