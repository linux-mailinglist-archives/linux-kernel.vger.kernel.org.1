Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DF2244AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGQT4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 15:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:56:22 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C4C0619D2;
        Fri, 17 Jul 2020 12:56:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E8C7011E4592D;
        Fri, 17 Jul 2020 12:56:21 -0700 (PDT)
Date:   Fri, 17 Jul 2020 12:56:21 -0700 (PDT)
Message-Id: <20200717.125621.1899442297143438402.davem@davemloft.net>
To:     usuraj35@gmail.com
Cc:     kuba@kernel.org, linux-decnet-user@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: decnet: af_decnet: Simplify goto loop.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200716191645.GA4953@blackclown>
References: <20200716191645.GA4953@blackclown>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 12:56:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Upadhyay <usuraj35@gmail.com>
Date: Fri, 17 Jul 2020 00:46:45 +0530

> Replace goto loop with while loop.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>

Applied to net-next.
