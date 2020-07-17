Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC85B224295
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGQRuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQRuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:50:15 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69E6206BE;
        Fri, 17 Jul 2020 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595008215;
        bh=9pY2DD1z0xxLkjfS67CXIsrvK2e0+mS1luWmj3qz4AA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AXwxv7aht+yg+/IbyG7nJlR/euljgwHDo35RsKJaMwa9/fWq2GBtYSmhMQjh+fNTm
         oCTe7AwqFV1jngBUzX2cs5h0NvltOxtZ8728lZmu7v8iZWInASteWHFLBK8Hqu72n4
         tiLnYj30N+rPtNjsr3PrKuMPJ+1HQ693a7bwz+IY=
Date:   Fri, 17 Jul 2020 10:50:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     lebon zhou <lebon.zhou@gmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix memory overwriting issue when copy an address to
 user space
Message-ID: <20200717105013.76ea6a7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAEQHRfB2f4x2r9Sk1+ixAFjUTcFQArv9wtWfjq3igGfUgZBhXw@mail.gmail.com>
References: <CAEQHRfB2f4x2r9Sk1+ixAFjUTcFQArv9wtWfjq3igGfUgZBhXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 10:31:54 +0000 lebon zhou wrote:
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

Please repoist CCing the netdev mailing list.
