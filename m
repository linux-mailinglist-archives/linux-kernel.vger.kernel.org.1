Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9998F2B8B13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgKSFmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSFmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:42:45 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCD8238E6;
        Thu, 19 Nov 2020 05:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605764564;
        bh=K3I9fEDjpyOo6fG6HF9At2f7NJvevaDoclzM+4tuFUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1GUu8vaeM1OBAw83vezwe+F/ZgjyDAH5Tpn4X9WDQBZh6U+MsdveykP257uUGy82
         ZLW+q7CpLWiHLPiospTungZIPW9kM2ldYENK22E9AXCu/U88CQzeeWMZ2vpGUS6XHr
         mMpWQvZnWOJYLtToilHLgau+BfMNV6gavwifAnPo=
Date:   Thu, 19 Nov 2020 14:42:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/4] tools/bootconfig: Fix to check the write failure
 correctly
Message-Id: <20201119144241.6e87b0db19dfd542906d1b60@kernel.org>
In-Reply-To: <160571373504.277955.1260524414275036851.stgit@devnote2>
References: <160571371674.277955.11736890010190945946.stgit@devnote2>
        <160571373504.277955.1260524414275036851.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 00:35:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix to check the write(2) failure including partial write
> correctly and try to rollback the partial write, because
> if there is no BOOTCONFIG_MAGIC string, we can not remove it.
> 
> Fixes: 85c46b78da58 ("bootconfig: Add bootconfig magic word for indicating bootconfig explicitly")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Chen Yu <yu.chen.surf@gmail.com>
> ---
>  tools/bootconfig/main.c |   27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 52eb2bbe8966..905bfaefae35 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -337,6 +337,7 @@ static int delete_xbc(const char *path)
>  
>  static int apply_xbc(const char *path, const char *xbc_path)
>  {
> +	struct stat stat;
>  	u32 size, csum;
>  	char *buf, *data;
>  	int ret, fd;
> @@ -394,16 +395,26 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  		return ret;
>  	}
>  	/* TODO: Ensure the @path is initramfs/initrd image */
> +	if (fstat(fd, &stat) < 0) {
> +		pr_err("Failed to get the size of %s\n", path);
> +		goto out;
> +	}
>  	ret = write(fd, data, size + 8);
> -	if (ret < 0) {
> +	if (ret < size + 8) {
> +		if (ret < 0)
> +			ret = -errno;
>  		pr_err("Failed to apply a boot config: %d\n", ret);
> -		goto out;
> +		if (ret < 0)
> +			goto out;
> +		goto out_rollback;
>  	}
>  	/* Write a magic word of the bootconfig */
>  	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
> -	if (ret < 0) {
> +	if (ret < BOOTCONFIG_MAGIC_LEN) {
> +		if (ret < 0)
> +			ret = -errno;
>  		pr_err("Failed to apply a boot config magic: %d\n", ret);
> -		goto out;
> +		goto out_rollback;
>  	}
>  	ret = 0;
>  out:
> @@ -411,6 +422,14 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	free(data);
>  
>  	return ret;
> +
> +out_rollback:

Oops, I forgot to set error to return value here.

I'll fix that.

Thank you,

> +	if (ftruncate(fd, stat.st_size) < 0) {
> +		ret = -errno;
> +		pr_err("Failed to rollback the write error: %d\n", ret);
> +		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
> +	}
> +	goto out;
>  }
>  
>  static int usage(void)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
