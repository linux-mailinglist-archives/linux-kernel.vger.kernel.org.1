Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E242B49F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgKPPvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731541AbgKPPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:51:46 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F19F20789;
        Mon, 16 Nov 2020 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605541903;
        bh=AOsTvJGjxo90oC0vyVsPKG64Xuyl9I8s1F76KHw/A0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kg68z0e6BJDOHP0elRq+EmZ0VtkA7b1k/R17qQqL17r2kk8S4EU1q0kDB8EcrieSV
         eh9YjLPtCEw2+UG9dkWfFjOdL+mjqUHkcawGjOoF368sHBSLChPqRjBJS88RWwAUDj
         Cz7tEAWTz1OJi9zQCsc0QCeUJkYnl035+CdiQGgM=
Date:   Tue, 17 Nov 2020 00:51:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] tools/bootconfig: Align the bootconfig applied
 initrd image size to 4
Message-Id: <20201117005139.062d42ec861e463a1536ef39@kernel.org>
In-Reply-To: <160553915302.90558.10717424893028416431.stgit@devnote2>
References: <160553914311.90558.426504572691633862.stgit@devnote2>
        <160553915302.90558.10717424893028416431.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 00:05:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Align the bootconfig applied initrd image size to 4. To pad the data,
> bootconfig will use space (0x20) in front of the bootconfig data,
> and expands its size and update checksum.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/bootconfig.h          |    1 +
>  tools/bootconfig/main.c             |   33 ++++++++++++++++++++++++++++-----
>  tools/bootconfig/test-bootconfig.sh |    6 +++++-
>  3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 9903088891fa..461f621047f3 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -12,6 +12,7 @@
>  
>  #define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
>  #define BOOTCONFIG_MAGIC_LEN	12
> +#define BOOTCONFIG_ALIGN	4
>  
>  /* XBC tree node */
>  struct xbc_node {
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index eb92027817a7..4b48e6a5ad1b 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -332,11 +332,13 @@ static int delete_xbc(const char *path)
>  
>  static int apply_xbc(const char *path, const char *xbc_path)
>  {
> +	const char padbuf[BOOTCONFIG_ALIGN] = { 0 };
>  	u32 size, csum;
>  	char *buf, *data;
>  	int ret, fd;
>  	const char *msg;
> -	int pos;
> +	struct stat st;
> +	int pos, pad;
>  
>  	ret = load_xbc_file(xbc_path, &buf);
>  	if (ret < 0) {
> @@ -347,12 +349,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	csum = checksum((unsigned char *)buf, size);
>  
>  	/* Prepare xbc_path data */
> -	data = malloc(size + 8);
> +	data = malloc(size);
>  	if (!data)
>  		return -ENOMEM;
>  	strcpy(data, buf);
> -	*(u32 *)(data + size) = size;
> -	*(u32 *)(data + size + 4) = csum;
>  
>  	/* Check the data format */
>  	ret = xbc_init(buf, &msg, &pos);
> @@ -387,12 +387,35 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  		free(data);
>  		return fd;
>  	}
> +
> +	/* To algin up the total size to BOOTCONFIG_ALIGN, get padding size */
> +	ret = fstat(fd, &st);
> +	if (ret < 0) {
> +		pr_err("Failed to get the stat of %s\n", path);
> +		free(data);
> +		return ret;
> +	}
> +	pad = BOOTCONFIG_ALIGN - (st.st_size + size) % BOOTCONFIG_ALIGN;

Oops, I forgot to add the footer size. This will work for 4 byte alignment,
but doesn't work 8 bytes or larger.
I'll send v2 soon.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
