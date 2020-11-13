Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB72B1B21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMM1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:27:39 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328FF20797;
        Fri, 13 Nov 2020 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605270458;
        bh=3DqEsTqU/ewk6HSai4Q5r2yx5IbzcKRcZ6W1l1RMXss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPnXw11+OgtW2DyEF8XAKEhZRxV3NcNkvLoMgFrJsVGI9G5ThLhRqJiiS9CAtMA/P
         NKvE94yM30hvYHobDqLIlfymbZxDWSjwJqGl9AlAhezDzttN7orgLPuw6b1okAWMWz
         FEmWg2GHMbYLCkRJBI15mEXlgljMeKHTL24d2lek=
Date:   Fri, 13 Nov 2020 13:28:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/2] checkpatch: document the function renaming and
 deprecation around devm_ioremap_resource
Message-ID: <X6578xy9K8MM44Cz@kroah.com>
References: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
 <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:11:57AM +0100, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this can also be squashed into the respective patches instead.

Hm, how?  Please just resend the series, or just provide a changelog
text for this patch and I'll be glad to take it that way.

thanks,

greg k-h
