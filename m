Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155001C6601
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 04:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEFCvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 22:51:08 -0400
Received: from ozlabs.org ([203.11.71.1]:39119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgEFCvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:51:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49H1Ld6Wwmz9sT5; Wed,  6 May 2020 12:51:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 43c8a496fa37187b54f7df71fb8262acc6bf6200
In-Reply-To: <1588154448-56759-1-git-send-email-wangxiongfeng2@huawei.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, <geoff@infradead.org>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ps3: Move static keyword to the front of declaration
Message-Id: <49H1Ld6Wwmz9sT5@ozlabs.org>
Date:   Wed,  6 May 2020 12:51:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 10:00:48 UTC, Xiongfeng Wang wrote:
> Move the static keyword to the front of declaration of 'vuart_bus_priv',
> and resolve the following compiler warning that can be seen when
> building with warnings enabled (W=1):
> 
> drivers/ps3/ps3-vuart.c:867:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>  } static vuart_bus_priv;
>  ^
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43c8a496fa37187b54f7df71fb8262acc6bf6200

cheers
