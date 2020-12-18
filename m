Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE02DEB42
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLRVp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:45:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43500 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgLRVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:45:28 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdf9.dip0.t-ipconnect.de [79.239.205.249])
        by mail.holtmann.org (Postfix) with ESMTPSA id 209E3CED31;
        Fri, 18 Dec 2020 22:52:04 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth:btmtksdio Fixed switch and case should be at
 the same indent
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201215094730.361510-1-t.jag587@gmail.com>
Date:   Fri, 18 Dec 2020 22:44:46 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, matthias.bgg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8CBE5646-DEA5-4D74-AC92-79A5957BC189@holtmann.org>
References: <20201215094730.361510-1-t.jag587@gmail.com>
To:     Jagdish Tirumala <t.jag587@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagdish,

> Switch and case where not properly aligned
> 
> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
> ---
> drivers/bluetooth/btmtksdio.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

