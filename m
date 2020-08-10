Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BFE24114C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHJUCE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Aug 2020 16:02:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47813 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHJUCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:02:03 -0400
Received: from marcel-macpro.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 20EF2CED43;
        Mon, 10 Aug 2020 22:12:03 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 3/3] drivers/clk/clk-asm9260.c
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <bdab839e-1aba-5b0f-e5de-52ddebc8b9ed@gmail.com>
Date:   Mon, 10 Aug 2020 22:01:58 +0200
Cc:     YourName <argoz1701@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        mturquette@baylibre.com, linux-ide@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-clk@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B73FCD9B-842F-440C-8BF1-16C9F415A341@holtmann.org>
References: <20200810005941.20581-1-argoz1701@gmail.com>
 <bdab839e-1aba-5b0f-e5de-52ddebc8b9ed@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> From: Daniel <argoz1701@gmail.com>
> 
>  Full name needed here.
> 
>> ---
>> drivers/ata/acard-ahci.c  |  6 +++---
>> drivers/bluetooth/bfusb.c |  5 ++---
>> drivers/clk/clk-asm9260.c | 12 ++++++------
>> 3 files changed, 11 insertions(+), 12 deletions(-)

please don’t intermix patches for different subsystems. And have a proper commit message explaining what is changed.

Regards

Marcel

