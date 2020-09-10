Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E46D265117
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 22:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgIJU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:29:30 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96055C061573;
        Thu, 10 Sep 2020 13:29:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2FB0C134A572B;
        Thu, 10 Sep 2020 13:12:40 -0700 (PDT)
Date:   Thu, 10 Sep 2020 13:29:26 -0700 (PDT)
Message-Id: <20200910.132926.656288861136010890.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     steffen.klassert@secunet.com, willemb@google.com,
        mstarovoitov@marvell.com, kuba@kernel.org,
        mchehab+huawei@kernel.org, antoine.tenart@bootlin.com,
        edumazet@google.com, Jason@zx2c4.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: Correct the comment of dst_dev_put()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200910084153.52078-1-linmiaohe@huawei.com>
References: <20200910084153.52078-1-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 10 Sep 2020 13:12:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Thu, 10 Sep 2020 04:41:53 -0400

> Since commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
> invalidate dst entries"), we use blackhole_netdev to invalidate dst entries
> instead of loopback device anymore.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied, thanks.
