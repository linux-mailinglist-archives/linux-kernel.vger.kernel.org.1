Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580A82AEDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKKJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:31:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKKJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:31:32 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339D520656;
        Wed, 11 Nov 2020 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605087092;
        bh=nzE6zgfrSaIu72HcJOxYlC217Peb9TxG4rcqPuzDH74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XAfaKwkM0Eu882+3F8gRr6coNKxsDNnESKwedPDsjXaBRIQ/xDfoesJ31B354V82h
         8OBbaC7oQjEDZwdp/no9ORCs8pCz9slsf9XWl4JQMHH3Z8+Cv51yWup0gI5z4jdhp0
         wNdKNtnrCbS7nHcfl7BxDWG2MWZYA0gUkGqjewmg=
Date:   Wed, 11 Nov 2020 18:31:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luo Meng <luomeng12@huawei.com>
Cc:     <jbacik@fb.com>, <ast@kernel.org>, <linux-kernel@vger.kernel.org>,
        stable@kernel.vger.org
Subject: Re: [PATCH] fail_function: remove a redundant mutex unlock
Message-Id: <20201111183129.3c58ca0c381e30d05b1392c8@kernel.org>
In-Reply-To: <20201110084245.3067324-1-luomeng12@huawei.com>
References: <20201110084245.3067324-1-luomeng12@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luo,

On Tue, 10 Nov 2020 16:42:45 +0800
Luo Meng <luomeng12@huawei.com> wrote:

> Fix a mutex_unlock() issue where before copy_from_user() is
> not called mutex_locked.

Oops, thank you for the fix.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Luo Meng <luomeng12@huawei.com>
> ---
>  kernel/fail_function.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 63b349168da7..b0b1ad93fa95 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -253,7 +253,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
>  
>  	if (copy_from_user(buf, buffer, count)) {
>  		ret = -EFAULT;
> -		goto out;
> +		goto out_free;
>  	}
>  	buf[count] = '\0';
>  	sym = strstrip(buf);
> @@ -307,8 +307,9 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
>  		ret = count;
>  	}
>  out:
> -	kfree(buf);
>  	mutex_unlock(&fei_lock);
> +out_free:
> +	kfree(buf);
>  	return ret;
>  }
>  
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
