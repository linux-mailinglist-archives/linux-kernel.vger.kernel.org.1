Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4672B8177
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgKRQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKRQEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:04:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40FC20756;
        Wed, 18 Nov 2020 16:04:38 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:04:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/4] tools/bootconfig: Fix to check the write failure
 correctly
Message-ID: <20201118110437.36e84496@gandalf.local.home>
In-Reply-To: <160571373504.277955.1260524414275036851.stgit@devnote2>
References: <160571371674.277955.11736890010190945946.stgit@devnote2>
        <160571373504.277955.1260524414275036851.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
> +	if (ftruncate(fd, stat.st_size) < 0) {

If the first write fails (doesn't modify the initrd), and then this fails,
you will show a message of: "may be corrupted. Recommend to rebuild", when
that would not be the case. Should a test of the size be done again, to see
if it is already the same?

out_rollback:
	old_size = stat.st_size;
	if (stat(fd, &stat) < 0) /* Shouldn't happen, it worked once before */
		goto print_error;

	if (old_size < stat.st_size)
		if (ftruncate(fd, old_size) < 0)
			goto print_error;

	goto out;

print_error:

> +		ret = -errno;
> +		pr_err("Failed to rollback the write error: %d\n", ret);
> +		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
> +	}
> +	goto out;
>  }
>  
>  static int usage(void)

-- Steve
