Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7452E3EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505228AbgL1Oe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505214AbgL1Oey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:34:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 881F120791;
        Mon, 28 Dec 2020 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609166054;
        bh=xe0wR3KHiGn8vh4lma29Zb/h+UfPiNjDTTW1JdihMJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JoI/ME2zcugn+e8yO4HbEIs7Zg1kKglS1/RWutXAJEI7LA/goTS/Qcqy9R0gUIfnN
         WfrsyCSPTf3jiQAQ6FjKjGO9WXmZ1a5Fq6YrCZHXDsqnbKnrara+WzC4fMIhv4ZFYw
         +GX9dzbfiE3mgx7gn687DlqWnb6/QsVhmuIpJ5Fw=
Date:   Mon, 28 Dec 2020 15:24:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] usb: misc: use DEFINE_MUTEX() for mutex lock
Message-ID: <X+nqpDpLg91ZFw61@kroah.com>
References: <20201224132555.31734-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224132555.31734-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 09:25:55PM +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/usb/misc/ftdi-elan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

What changed from v1?  That always goes below the --- line.

Please fix up and send a v3.

thanks,

greg k-h
