Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D03234EB9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 01:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGaXu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 19:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:50:58 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC68C06174A;
        Fri, 31 Jul 2020 16:50:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B5E0A11E58FA8;
        Fri, 31 Jul 2020 16:34:12 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:50:57 -0700 (PDT)
Message-Id: <20200731.165057.1709367540726800070.davem@davemloft.net>
To:     gustavoars@kernel.org
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH][next] net/sched: cls_u32: Use struct_size() helper
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200730160314.GA30990@embeddedor>
References: <20200730160314.GA30990@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 Jul 2020 16:34:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Thu, 30 Jul 2020 11:03:14 -0500

> Make use of the struct_size() helper, in multiple places, instead
> of an open-coded version in order to avoid any potential type
> mistakes and protect against potential integer overflows.
> 
> Also, remove unnecessary object identifier size.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied, thank you.
