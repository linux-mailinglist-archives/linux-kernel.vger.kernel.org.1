Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103871DBADB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgETRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:13:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51252 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgETRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:13:20 -0400
Received: from marcel-macbook.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 778F6CED0C;
        Wed, 20 May 2020 19:23:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix uninitialized access to hdev
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200520093206.1.I1a56163c173e14d1cc7a8b639147466171525eab@changeid>
Date:   Wed, 20 May 2020 19:13:17 +0200
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E8200AE2-ACBD-4A0D-B268-B6354194B254@holtmann.org>
References: <20200520093206.1.I1a56163c173e14d1cc7a8b639147466171525eab@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> hdev is always allocated and not only when power control is required.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> drivers/bluetooth/hci_qca.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

