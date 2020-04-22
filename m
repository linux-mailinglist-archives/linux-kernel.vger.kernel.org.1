Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900F1B355F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDVC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbgDVC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:58:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE9C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 19:58:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR5ay-0081rv-85; Wed, 22 Apr 2020 02:58:40 +0000
Date:   Wed, 22 Apr 2020 03:58:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ide: Use memdup_user() as a cleanup
Message-ID: <20200422025840.GJ23230@ZenIV.linux.org.uk>
References: <1587524381-120136-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587524381-120136-1-git-send-email-zou_wei@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:59:41AM +0800, Zou Wei wrote:

>  	if (taskout) {
>  		int outtotal = tasksize;
> -		outbuf = kzalloc(taskout, GFP_KERNEL);
> -		if (outbuf == NULL) {
> -			err = -ENOMEM;
> -			goto abort;
> -		}
> -		if (copy_from_user(outbuf, buf + outtotal, taskout)) {
> -			err = -EFAULT;
> -			goto abort;
> -		}
> +		outbuf = memdup_user(buf + outtotal, taskout);
> +		if (IS_ERR(outbuf))
> +			return PTR_ERR(outbuf);
>  	}
>  
>  	if (taskin) {
>  		int intotal = tasksize + taskout;
> -		inbuf = kzalloc(taskin, GFP_KERNEL);
> -		if (inbuf == NULL) {
> -			err = -ENOMEM;
> -			goto abort;
> -		}
> -		if (copy_from_user(inbuf, buf + intotal, taskin)) {
> -			err = -EFAULT;
> -			goto abort;
> -		}
> +		inbuf = memdup_user(buf + intotal, taskin);
> +		if (IS_ERR(inbuf))
> +			return PTR_ERR(inbuf);

That smells like a leak - what happens if both taskin and taskout are
non-zero at the same time?  <looks>  actually, both parts are leaking -
there's
        req_task = memdup_user(buf, tasksize);
        if (IS_ERR(req_task))
                return PTR_ERR(req_task);
shortly prior to that, so both of your failure exits are leaking.
