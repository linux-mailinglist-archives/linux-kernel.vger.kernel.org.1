Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586F12FBBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391799AbhASP6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jan 2021 10:58:50 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43137 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391409AbhASPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:52:46 -0500
X-Originating-IP: 86.201.233.230
Received: from xps13 (lfbn-tou-1-151-230.w86-201.abo.wanadoo.fr [86.201.233.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 265F4C0008;
        Tue, 19 Jan 2021 15:51:39 +0000 (UTC)
Date:   Tue, 19 Jan 2021 16:51:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFm?= =?UTF-8?B?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 3/3] mtd: parsers: ofpart: support BCM4908 fixed
 partitions
Message-ID: <20210119165138.4982ae46@xps13>
In-Reply-To: <20210115153901.31052-3-zajec5@gmail.com>
References: <20210115153901.31052-1-zajec5@gmail.com>
        <20210115153901.31052-3-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

Rafał Miłecki <zajec5@gmail.com> wrote on Fri, 15 Jan 2021 16:39:01
+0100:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 partitioning is based on fixed layout but allows specifying
> multiple firmware partitions. It requires detecting which firmware
> partition was used for booting current kernel.
> 
> To support such cases without duplicating a lot of code (without copying
> most of the ofpart.c code) support for post-parsing callback was added.
> 
> BCM4908 callback simply reads offset of currently used firmware
> partition from the DT. Bootloader specifies it using the "brcm_blparms"
> property.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

The approach looks fine by me, let's see what other maintainers think.


Cheers,
Miquèl
