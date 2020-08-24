Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC19D24FF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHXNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgHXNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:41:04 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 06:41:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 963F6128286FD;
        Mon, 24 Aug 2020 06:24:17 -0700 (PDT)
Date:   Mon, 24 Aug 2020 06:41:03 -0700 (PDT)
Message-Id: <20200824.064103.1912127912340710662.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     johannes.berg@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netlink: remove duplicated
 nla_need_padding_for_64bit() check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <51bd2b4c5f4549488de08bdcf6daae23@huawei.com>
References: <51bd2b4c5f4549488de08bdcf6daae23@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Aug 2020 06:24:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Mon, 24 Aug 2020 11:58:24 +0000

> friendly ping :)

Networking patches must be posted to netdev@vger.kernel.org, so please
resubmit this properly.

Thank you.
