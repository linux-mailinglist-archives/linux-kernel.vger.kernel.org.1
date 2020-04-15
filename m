Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019771AB404
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 01:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgDOXEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 19:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387937AbgDOXEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 19:04:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC6F20768;
        Wed, 15 Apr 2020 23:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586991880;
        bh=55qAwhO0WzZi7LtNMraWynM8BWS2Jzp4KBDWiaLriyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zL+Lb3SetfXpJ1/3b5i2NIrMtw3EomzLT2OldikQWOTfL9K+64V4uQEvlC6G0GNRi
         ya1Iu/dc5hdW0Z5y0tTCBJyw2xUHQf8ov+8RobpU+ii90Q177oZSGZZfjonjfTVZA/
         iw+EvQqes52ioJy350hn9Yx4b4cQNcnfuXN0tqIg=
Date:   Wed, 15 Apr 2020 16:04:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/usercopy: fix warning Comparison to bool
Message-Id: <20200415160439.256c89d4cb67b76d4119935d@linux-foundation.org>
In-Reply-To: <1586835724-45738-1-git-send-email-zou_wei@huawei.com>
References: <1586835724-45738-1-git-send-email-zou_wei@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 11:42:04 +0800 Zou Wei <zou_wei@huawei.com> wrote:

> fix below warnings reported by coccicheck
> 
> mm/usercopy.c:304:5-18: WARNING: Comparison to bool
>
> ...
>
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -301,7 +301,7 @@ __setup("hardened_usercopy=", parse_hardened_usercopy);
>  
>  static int __init set_hardened_usercopy(void)
>  {
> -	if (enable_checks == false)
> +	if (!enable_checks)
>  		static_branch_enable(&bypass_usercopy_checks);
>  	return 1;
>  }

My initial reaction is "fix coccicheck".  There's nothing wrong with
that code?

