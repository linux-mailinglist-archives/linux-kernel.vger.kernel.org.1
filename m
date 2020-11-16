Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD562B5518
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgKPXed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgKPXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:34:32 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ACEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:34:32 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so18785468qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cPVCiyGZ0YXakzcwLs9vqbnkWYk9Qn+nVEI9cr2D7zo=;
        b=PoPubdQ6tV6RbWrR4gtqCHNCZeRW5zXEwVw98XDhQ/FijORrs8ALOcb9btqcWRG+el
         K8PYS2PPGRGRFq9IO/LrTamhAPNmPm1iOfzUB0yXpfzX5GUEhv3o6eoUct4zGv5kjags
         YlZdRPWlqC/Th8z2cDLsMBgolMzj7TKsq9XnMruGpfCWEBEJwdWH7KAC2hbmxgA0qS0i
         H7nZOH/x69xZ1MIrmrgb+ZQoZ5djoZoGXMigZAZnw4w/4OKuZXG3qZm8XnZ47MxMDLS8
         m4vs6N/NosNxkb9YERcC4CvVH8fdiB2gLz0O5Vp3yCmucUS7+vaSzCdiDYkdxEnqPvNc
         VGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cPVCiyGZ0YXakzcwLs9vqbnkWYk9Qn+nVEI9cr2D7zo=;
        b=TpwIjKRPNtw0xp/ti1+4lp+knjYbIk47YU6xNwC5RBBhvlSu+CHBSVYYO+2CWijIxv
         1m761k68sumRj87FgP5huPA+Vs13/Z/GHqnvaCXiQgsNdyls1iSu2mOE/j+pwG2tZ2/t
         +m3S8E6vdDGa19+cPbiXLJmYQ/2MMn+B6gqb/TKUM01VBmkLAp91fh4MulnZhQB1ImVD
         UjxjKKuAoRsTW2F8g6YbxW1ohwXyK4AEXO+WhdOZjZnY59kHQi9hweCsSZzPVs6deKn6
         bEm7XLqAez7SAYgG9aZhmea+tTIykZuqdQP/gAaMiOYtzlQS0m+AWMtQaIr93IW/A8n9
         CAVA==
X-Gm-Message-State: AOAM5302Ob+zpC074UoM/nw+cyJJE5LNevNAZ+rorHSkjt0/52M3zd3t
        6k0nMTb3RX9nksT5YbGCMw==
X-Google-Smtp-Source: ABdhPJxYSGhfeW1O7Gm4JucDKng6Rduw+9rYdLlcME9/TXIVX3UUZfwgzGIcGrK71c4sqTWlLURC1w==
X-Received: by 2002:a37:9d16:: with SMTP id g22mr17549202qke.62.1605569671789;
        Mon, 16 Nov 2020 15:34:31 -0800 (PST)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id p73sm13611736qka.79.2020.11.16.15.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 15:34:30 -0800 (PST)
Subject: Re: [PATCH 1/2] tools/bootconfig: Align the bootconfig applied initrd
 image size to 4
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <160553914311.90558.426504572691633862.stgit@devnote2>
 <160553915302.90558.10717424893028416431.stgit@devnote2>
From:   Woody Suwalski <terraluna977@gmail.com>
Message-ID: <ebdf162b-88f8-8b05-1fd9-454daaf4d941@gmail.com>
Date:   Mon, 16 Nov 2020 18:34:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101 Firefox/60.0
 SeaMonkey/2.53.4
MIME-Version: 1.0
In-Reply-To: <160553915302.90558.10717424893028416431.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> Align the bootconfig applied initrd image size to 4. To pad the data,
> bootconfig will use space (0x20) in front of the bootconfig data,
> and expands its size and update checksum.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   include/linux/bootconfig.h          |    1 +
>   tools/bootconfig/main.c             |   33 ++++++++++++++++++++++++++++-----
>   tools/bootconfig/test-bootconfig.sh |    6 +++++-
>   3 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 9903088891fa..461f621047f3 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -12,6 +12,7 @@
>   
>   #define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
>   #define BOOTCONFIG_MAGIC_LEN	12
> +#define BOOTCONFIG_ALIGN	4
>   
>   /* XBC tree node */
>   struct xbc_node {
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index eb92027817a7..4b48e6a5ad1b 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -332,11 +332,13 @@ static int delete_xbc(const char *path)
>   
>   static int apply_xbc(const char *path, const char *xbc_path)
>   {
> +	const char padbuf[BOOTCONFIG_ALIGN] = { 0 };
>   	u32 size, csum;
>   	char *buf, *data;
>   	int ret, fd;
>   	const char *msg;
> -	int pos;
> +	struct stat st;
> +	int pos, pad;
>   
>   	ret = load_xbc_file(xbc_path, &buf);
>   	if (ret < 0) {
> @@ -347,12 +349,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
>   	csum = checksum((unsigned char *)buf, size);
>   
>   	/* Prepare xbc_path data */
> -	data = malloc(size + 8);
> +	data = malloc(size);
>   	if (!data)
>   		return -ENOMEM;
>   	strcpy(data, buf);
> -	*(u32 *)(data + size) = size;
> -	*(u32 *)(data + size + 4) = csum;
>   
>   	/* Check the data format */
>   	ret = xbc_init(buf, &msg, &pos);
> @@ -387,12 +387,35 @@ static int apply_xbc(const char *path, const char *xbc_path)
>   		free(data);
>   		return fd;
>   	}
> +
> +	/* To algin up the total size to BOOTCONFIG_ALIGN, get padding size */
> +	ret = fstat(fd, &st);
> +	if (ret < 0) {
> +		pr_err("Failed to get the stat of %s\n", path);
> +		free(data);
> +		return ret;
> +	}
> +	pad = BOOTCONFIG_ALIGN - (st.st_size + size) % BOOTCONFIG_ALIGN;
> +
>   	/* TODO: Ensure the @path is initramfs/initrd image */
> -	ret = write(fd, data, size + 8);
> +	ret = write(fd, data, size);
>   	if (ret < 0) {
>   		pr_err("Failed to apply a boot config: %d\n", ret);
>   		goto out;
>   	}
> +
> +	if (pad != BOOTCONFIG_ALIGN) {
> +		/* Write padding null characters */
> +		ret = write(fd, padbuf, pad);
> +		if (ret < 0) {
> +			pr_err("Failed to write padding: %d\n", ret);
> +			goto out;
> +		}
> +		size += pad;
> +	}
> +	ret = write(fd, &size, sizeof(u32));
> +	ret = write(fd, &csum, sizeof(u32));
> +
>   	/* Write a magic word of the bootconfig */
>   	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
>   	if (ret < 0) {
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index d295e406a756..baed891d0ba4 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -9,6 +9,7 @@ else
>     TESTDIR=.
>   fi
>   BOOTCONF=${TESTDIR}/bootconfig
> +ALIGN=4
>   
>   INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
>   TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
> @@ -59,7 +60,10 @@ echo "Show command test"
>   xpass $BOOTCONF $INITRD
>   
>   echo "File size check"
> -xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
> +total_size=$(expr $bconf_size + $initrd_size + 9 + 12 + $ALIGN - 1 )
> +total_size=$(expr $total_size / $ALIGN)
> +total_size=$(expr $total_size \* $ALIGN)
> +xpass test $new_size -eq $total_size
>   
>   echo "Apply command repeat test"
>   xpass $BOOTCONF -a $TEMPCONF $INITRD
>
Typo in the comment line 391: algin

Woody

