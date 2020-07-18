Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE12247DA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 03:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGRBnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 21:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:43:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5CFC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 18:43:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3EB2611E45914;
        Fri, 17 Jul 2020 18:43:07 -0700 (PDT)
Date:   Fri, 17 Jul 2020 18:43:06 -0700 (PDT)
Message-Id: <20200717.184306.746700973177455464.davem@davemloft.net>
To:     lebon.zhou@gmail.com
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix memory overwriting issue when copy an address to
 user space
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAEQHRfB2f4x2r9Sk1+ixAFjUTcFQArv9wtWfjq3igGfUgZBhXw@mail.gmail.com>
References: <CAEQHRfB2f4x2r9Sk1+ixAFjUTcFQArv9wtWfjq3igGfUgZBhXw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 17 Jul 2020 18:43:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lebon zhou <lebon.zhou@gmail.com>
Date: Fri, 17 Jul 2020 10:31:54 +0000

> When application provided buffer size less than sockaddr_storage, then
> kernel will overwrite some memory area which may cause memory corruption,
> e.g.: in recvmsg case, let msg_name=malloc(8) and msg_namelen=8, then
> usually application can call recvmsg successful but actually application
> memory get corrupted.
> 
> Fix to return EINVAL when application buffer size less than
> sockaddr_storage.
> 
> Signed-off-by: lebon.zhou <lebon.zhou@gmail.com>

Please post networking fixes to netdev@vger.kernel.org

Thank you.
