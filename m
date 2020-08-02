Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E78235991
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHBSAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Aug 2020 14:00:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48680 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:00:15 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id D8365CED31;
        Sun,  2 Aug 2020 20:10:16 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Bluetooth: btmrvl: eliminate duplicates introducing
 btmrvl_reg_89xx
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200802145642.9990-1-tszucs@protonmail.ch>
Date:   Sun, 2 Aug 2020 20:00:13 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5511988E-D6FA-4488-9090-68FFA4CC36FF@holtmann.org>
References: <20200802145642.9990-1-tszucs@protonmail.ch>
To:     =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tamas,

> SD89xx devices use identical card register settings. Make sure a single common
> instance is used to describe them.
> 
> Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 54 +++------------------------------
> 1 file changed, 4 insertions(+), 50 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

