Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574C61DD930
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 23:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgEUVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgEUVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:14:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB73EC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:14:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so4062887pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZZ5vGtImoL01xyzR64KCWDKUfIuis772xDEHmF3ldI=;
        b=B1edwXeQk42Z1UZf7gfSthKXb4bIu1l9sihaGaa2vq6i4vtytY9bF5qGzoIrZtPfQZ
         2fc1l3wCb6wiviHILp6lflGHUcIiulV00r1Ba3iJ7MdKuH2TB63+4Oojgy/ZExBIxvPi
         9W8NbphL55tG1O+Q+rdZWeUa5k2IvGMec5tmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZZ5vGtImoL01xyzR64KCWDKUfIuis772xDEHmF3ldI=;
        b=gqc8pvogOQmjOH0rcRh+MlYbVletlNU84f67pIvGCEdHZ9u6IAnRmaFU9ffm3NXJ8H
         curPwCiheqGQ87BxQMjkhtQiUshiHZaZWkzAP4z012MI1mmab6IqYNSEhIQ7hWL7iFeu
         Lhyp0EUG6T/taLcMmft8RmefVdpj+bVUEb38yGdurw+lwxYrRw4d6mSIIlqz8foCNxEe
         YxmLNoiLZoc+XOy6h58ceD3UazvGPJdr55ObVq7cV6S5GGGadJC9JQeagesUomM37SZs
         EcQuYnmpDgoTUU/ZfobfkAbnjwWG4dhCigtdLYFxsveyDw0kbToY4lcEV2Qfe1+3VfBN
         Hbew==
X-Gm-Message-State: AOAM5325ruJBLG5USAwuLamFHo5dBg5SqrJpD2LGd1+DrY17UpfOJDLS
        ja9RMhrQ0LpsxeT6vp2M62HQJU7ljFYuxg==
X-Google-Smtp-Source: ABdhPJz5ZgIVwn633Wd8ontnJLCwdyIuRN7Je5MIDycy8URZX6MgTMECk1Rzp83xOtKruPX7kkcYfA==
X-Received: by 2002:a62:760e:: with SMTP id r14mr644628pfc.92.1590095650015;
        Thu, 21 May 2020 14:14:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm5377315pje.47.2020.05.21.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:14:09 -0700 (PDT)
Date:   Thu, 21 May 2020 14:14:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 8/9] kallsyms: Hide layout
Message-ID: <202005211409.3C314DF@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
 <20200521165641.15940-9-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521165641.15940-9-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 09:56:39AM -0700, Kristen Carlson Accardi wrote:
> This patch makes /proc/kallsyms display alphabetically by symbol
> name rather than sorted by address in order to hide the newly
> randomized address layout.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> ---
>  kernel/kallsyms.c | 138 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 16c8c605f4b0..558963b275ec 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -25,6 +25,7 @@
>  #include <linux/filter.h>
>  #include <linux/ftrace.h>
>  #include <linux/compiler.h>
> +#include <linux/list_sort.h>
>  
>  /*
>   * These will be re-linked against their real values
> @@ -446,6 +447,11 @@ struct kallsym_iter {
>  	int show_value;
>  };
>  
> +struct kallsyms_iter_list {
> +	struct kallsym_iter iter;
> +	struct list_head next;
> +};
> +
>  int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>  			    char *type, char *name)
>  {
> @@ -660,6 +666,121 @@ int kallsyms_show_value(void)
>  	}
>  }
>  
> +static int sorted_show(struct seq_file *m, void *p)
> +{
> +	struct list_head *list = m->private;
> +	struct kallsyms_iter_list *iter;
> +	int rc;
> +
> +	if (list_empty(list))
> +		return 0;
> +
> +	iter = list_first_entry(list, struct kallsyms_iter_list, next);
> +
> +	m->private = iter;
> +	rc = s_show(m, p);
> +	m->private = list;
> +
> +	list_del(&iter->next);
> +	kfree(iter);
> +
> +	return rc;
> +}
> +
> +static void *sorted_start(struct seq_file *m, loff_t *pos)
> +{
> +	return m->private;
> +}
> +
> +static void *sorted_next(struct seq_file *m, void *p, loff_t *pos)
> +{
> +	struct list_head *list = m->private;
> +
> +	(*pos)++;
> +
> +	if (list_empty(list))
> +		return NULL;
> +
> +	return p;
> +}
> +
> +static const struct seq_operations kallsyms_sorted_op = {
> +	.start = sorted_start,
> +	.next = sorted_next,
> +	.stop = s_stop,
> +	.show = sorted_show
> +};
> +
> +static int kallsyms_list_cmp(void *priv, struct list_head *a,
> +			     struct list_head *b)
> +{
> +	struct kallsyms_iter_list *iter_a, *iter_b;
> +
> +	iter_a = list_entry(a, struct kallsyms_iter_list, next);
> +	iter_b = list_entry(b, struct kallsyms_iter_list, next);
> +
> +	return strcmp(iter_a->iter.name, iter_b->iter.name);
> +}
> +
> +int get_all_symbol_name(void *data, const char *name, struct module *mod,
> +			unsigned long addr)
> +{
> +	unsigned long sym_pos;
> +	struct kallsyms_iter_list *node, *last;
> +	struct list_head *head = (struct list_head *)data;
> +
> +	node = kmalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	if (list_empty(head)) {
> +		sym_pos = 0;
> +		memset(node, 0, sizeof(*node));
> +		reset_iter(&node->iter, 0);
> +		node->iter.show_value = kallsyms_show_value();
> +	} else {
> +		last = list_first_entry(head, struct kallsyms_iter_list, next);
> +		memcpy(node, last, sizeof(*node));
> +		sym_pos = last->iter.pos;
> +	}
> +
> +	INIT_LIST_HEAD(&node->next);
> +	list_add(&node->next, head);
> +
> +	/*
> +	 * update_iter returns false when at end of file
> +	 * which in this case we don't care about and can
> +	 * safely ignore. update_iter() will increment
> +	 * the value of iter->pos, for ksymbol_core.
> +	 */
> +	if (sym_pos >= kallsyms_num_syms)
> +		sym_pos++;
> +
> +	(void)update_iter(&node->iter, sym_pos);
> +
> +	return 0;
> +}
> +
> +static int kallsyms_sorted_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +	struct list_head *list;
> +
> +	list = __seq_open_private(file, &kallsyms_sorted_op, sizeof(*list));
> +	if (!list)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(list);
> +
> +	ret = kallsyms_on_each_symbol(get_all_symbol_name, list);
> +	if (ret != 0)
> +		return ret;
> +
> +	list_sort(NULL, list, kallsyms_list_cmp);
> +
> +	return 0;
> +}
> +
>  static int kallsyms_open(struct inode *inode, struct file *file)
>  {
>  	/*
> @@ -704,9 +825,24 @@ static const struct proc_ops kallsyms_proc_ops = {
>  	.proc_release	= seq_release_private,
>  };
>  
> +static const struct proc_ops kallsyms_sorted_proc_ops = {
> +	.proc_open = kallsyms_sorted_open,
> +	.proc_read = seq_read,
> +	.proc_lseek = seq_lseek,
> +	.proc_release = seq_release_private,
> +};
> +
>  static int __init kallsyms_init(void)
>  {
> -	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> +	/*
> +	 * When fine grained kaslr is enabled, we need to
> +	 * print out the symbols sorted by name rather than by
> +	 * by address, because this reveals the randomization order.
> +	 */
> +	if (!IS_ENABLED(CONFIG_FG_KASLR))
> +		proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> +	else
> +		proc_create("kallsyms", 0444, NULL, &kallsyms_sorted_proc_ops);
>  	return 0;

Since this is compile-time selected, instead of the separate name and
test here, how about just redefine kallsyms_open initializer instead?

#ifdef CONFIG_FG_KASLR
...sorting routines...
static int kallsyms_open(struct inode *inode, struct file *file)
{ ... sorted version ... }
#else
static int kallsyms_open(struct inode *inode, struct file *file)
{ ... normal version ... }
#endif

(And then just move the comment to the sorted open version.)

-- 
Kees Cook
