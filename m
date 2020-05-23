Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635961DFBD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgEWX3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 19:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbgEWX3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 19:29:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F82C061A0E;
        Sat, 23 May 2020 16:29:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C2021286F383;
        Sat, 23 May 2020 16:29:06 -0700 (PDT)
Date:   Sat, 23 May 2020 16:29:05 -0700 (PDT)
Message-Id: <20200523.162905.39796274385909426.davem@davemloft.net>
To:     yangtiezhu@loongson.cn
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixuefeng@loongson.cn
Subject: Re: [PATCH] net: Fix return value about
 devm_platform_ioremap_resource()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1590145401-27763-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590145401-27763-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 May 2020 16:29:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Fri, 22 May 2020 19:03:21 +0800

> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Applied, thanks.
