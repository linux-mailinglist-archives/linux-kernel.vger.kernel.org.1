Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDA1D7275
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgERIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 04:03:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57289 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgERIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:03:38 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 182A8CECE3;
        Mon, 18 May 2020 10:13:21 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Enable WBS support for wcn3991
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200514131338.v2.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
Date:   Mon, 18 May 2020 10:03:36 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, bgodavar@codeaurora.org,
        alainm@chromium.org, mka@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8BFF0708-07AF-4034-8FEF-C1D95975404B@holtmann.org>
References: <20200514131338.v2.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

> WCN3991 supports transparent WBS (host encoded mSBC). Add a flag to the
> device match data to show WBS is supported.
> 
> This requires the matching firmware for WCN3991 in linux-firmware:
>        1a8b0dc00f77 (qca: Enable transparent WBS for WCN3991)
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v2:
> - Rename struct to qca_capabilities and fix enum naming
> 
> drivers/bluetooth/hci_qca.c | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

