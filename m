Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB47E1BAC19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgD0SPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbgD0SPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:15:01 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01EC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:15:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6EEB815D49823;
        Mon, 27 Apr 2020 11:15:00 -0700 (PDT)
Date:   Mon, 27 Apr 2020 11:14:59 -0700 (PDT)
Message-Id: <20200427.111459.2101842326845678002.davem@davemloft.net>
To:     chentao107@huawei.com
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: bcm54140: Make a bunch of functions static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200425084944.152130-1-chentao107@huawei.com>
References: <20200425084944.152130-1-chentao107@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Apr 2020 11:15:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChenTao <chentao107@huawei.com>
Date: Sat, 25 Apr 2020 16:49:44 +0800

> Fix the following warning:
> 
> drivers/net/phy/bcm54140.c:663:5: warning:
> symbol 'bcm54140_did_interrupt' was not declared. Should it be static?
> drivers/net/phy/bcm54140.c:672:5: warning:
> symbol 'bcm54140_ack_intr' was not declared. Should it be static?
> drivers/net/phy/bcm54140.c:684:5: warning:
> symbol 'bcm54140_config_intr' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

The appropriate mailing list for networking changes is netdev@vger.kernel.org
so please resubmit this there.

Thank you.
