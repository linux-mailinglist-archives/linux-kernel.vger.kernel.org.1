Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65CC2AEF06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKKKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:54:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50029 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKKKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:54:50 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3B3A3CECFC;
        Wed, 11 Nov 2020 12:01:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH][next] Bluetooth: btrtl: fix incorrect skb allocation
 failure check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201110123915.3356601-1-colin.king@canonical.com>
Date:   Wed, 11 Nov 2020 11:54:45 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0DA7A8C1-07AA-4342-A16A-FEB5C5825C76@holtmann.org>
References: <20201110123915.3356601-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

> Currently the check for a failed bt_skb_alloc allocation is incorrectly
> checking using IS_ERR and this can lead to a null pointer dereference. Fix
> this by checking for a null pointer return using the !skb idiom.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: 1996d9cad6ad ("Bluetooth: btrtl: Ask 8821C to drop old firmware")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/btrtl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

