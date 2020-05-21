Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB41DCE63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 15:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEUNqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 09:46:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:49790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgEUNqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2DB1AC40;
        Thu, 21 May 2020 13:46:08 +0000 (UTC)
Date:   Thu, 21 May 2020 15:46:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521134604.GE8397@linux-b0ei>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-05-19 12:42:35, Joe Perches wrote:
> ARM may have its longest possible command line larger than the longest
> possible printk.
> 
> If necessary, emit the commend line on multiple lines.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> compiled, untested
> 
>  init/main.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index b63a3c001ac4..b3ebbbc129ae 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -826,6 +826,34 @@ void __init __weak arch_call_rest_init(void)
>  	rest_init();
>  }
>  
> +static void __init print_cmdline(char *line)
> +{
> +#ifdef CONFIG_PRINTK
> +	const char *prefix = "Kernel command line";
> +	size_t len = strlen(line);
> +
> +	while (len > PRINTK_LOG_LINE_MAX) {
> +		char *pos = line;
> +		char *last_pos = pos + PRINTK_LOG_LINE_MAX - 1;
> +		char saved_char;
> +		/* Find last space char within the maximum line length */
> +		while ((pos = memchr(pos, ' ', len - (pos - line))) &&
> +		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {
> +			last_pos = pos;
> +		}

strchr() would safe the length calculation:

		while ((pos = strchr(pos, ' ')) &&
		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {
			last_pos = pos;
		}


> +		saved_char = line[last_pos - line];
> +		line[last_pos - line] = 0;

This looks less cryptic:

		saved_char = *last_pos;
		*last_pos = '\0';

> +		pr_notice("%s: %s\n", prefix, line);
> +		prefix = "Kernel command line (continued)";
> +		line[last_pos - line] = saved_char;
> +		len -= pos - line;
> +		line += pos - line;

'pos' might be NULL when there is no ' ' in the string. What about?

		len -= last_pos - line;
		line = last_pos;
> +	}
> +
> +	pr_notice("%s: %s\n", prefix, line);
> +#endif
> +}

Plus, the code should count the prefix length when splitting the line as
reported by Sergey.

Best Regards,
Petr
