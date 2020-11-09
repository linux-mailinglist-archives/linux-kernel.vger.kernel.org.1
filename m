Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4FA2AB24D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgKIITu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:19:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036EAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/+pVnwRzluxmz3TmG2luhsgumgNRGviTRulmW19OhNQ=; b=uF6oxDrVBLquRtT3Y6K1gr3UcP
        r7Y/Vrm7i5G35T0Frh5w7LvJeNyFYFdMTcmrNx1LfHzwEg1AbJ0ods9y2REQaTTwpOKRqcv2RkYzS
        knKDinPkP+A38eowpl6Pvhe8T7tJ+M9SwjkgSS94270PsWcfI8k6zpW5u+qPDycnuO1ftLPfQq21M
        aBvh2WArgQe0dGa9P2AsDdY/10IWb/CxKUm6eAWs7qGdB3ZL5ETOZmv+sqWOAnNw8iGO06yh8iMjX
        UMc7gmtp7YpBrsH0d2rAz7isDVjzyFjOS4gSpN122G0PdGs5+g4GVdc4OgZFDhn9dZIQHu9GZBlzn
        TZOp2vXA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc2Ow-0002de-8Y; Mon, 09 Nov 2020 08:19:46 +0000
Date:   Mon, 9 Nov 2020 08:19:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: export device_is_bound() to fix build
 failure
Message-ID: <20201109081946.GA7720@infradead.org>
References: <20201106153744.22661-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106153744.22661-1-sudipm.mukherjee@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:37:44PM +0000, Sudip Mukherjee wrote:
> When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> is unable to find device_is_bound(). The error being:
> ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> 	undefined!
> 
> Export the symbol so that the module finds it.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 148e81969e04..a796a57e5efb 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
>  {
>  	return dev->p && klist_node_attached(&dev->p->knode_driver);
>  }
> +EXPORT_SYMBOL(device_is_bound);

Everything else in this file uses EXPORT_SYMBOL_GPL, so I don't see why
this would be special.

That being said a good rationale of why it is a good idea to use this in
drivers is also required.
