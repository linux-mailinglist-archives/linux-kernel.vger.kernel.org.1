Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD72C5ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404482AbgKZRmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404320AbgKZRmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:42:46 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A909C21D46;
        Thu, 26 Nov 2020 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412565;
        bh=nIsooK7mtEnNl1AAP8xv2CcOZOILKknXcA1/3sN/yg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fevF4clobE2Lo1+1eJC1nTYgmXG1meO0UjSUAJfT8870ZHlfUWHMTtwZHig3lwfKX
         Is5KDUZX7mi+3VG2KalaAky0f8qfl88WbMen8UEKeG0nN9jWrfolXTFaTeYUXvihAr
         oiDWQ/b5gYmtllIB0Qr7tz24vle3NPOk3cqyaNFQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DF1040E29; Thu, 26 Nov 2020 14:42:43 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:42:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 05/25] tools lib: Adopt memchr_inv() from kernel
Message-ID: <20201126174243.GH53384@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:06PM +0100, Jiri Olsa escreveu:
> We'll use it to check for undefined/zero data.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/include/linux/string.h |  1 +
>  tools/lib/string.c           | 58 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> index 5e9e781905ed..db5c99318c79 100644
> --- a/tools/include/linux/string.h
> +++ b/tools/include/linux/string.h
> @@ -46,4 +46,5 @@ extern char * __must_check skip_spaces(const char *);
>  
>  extern char *strim(char *);
>  
> +extern void *memchr_inv(const void *start, int c, size_t bytes);
>  #endif /* _TOOLS_LINUX_STRING_H_ */
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index f645343815de..8b6892f959ab 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -168,3 +168,61 @@ char *strreplace(char *s, char old, char new)
>  			*s = new;
>  	return s;
>  }
> +
> +static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
> +{
> +	while (bytes) {
> +		if (*start != value)
> +			return (void *)start;
> +		start++;
> +		bytes--;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * memchr_inv - Find an unmatching character in an area of memory.
> + * @start: The memory area
> + * @c: Find a character other than c
> + * @bytes: The size of the area.
> + *
> + * returns the address of the first character other than @c, or %NULL
> + * if the whole buffer contains just @c.
> + */
> +void *memchr_inv(const void *start, int c, size_t bytes)
> +{
> +	u8 value = c;
> +	u64 value64;
> +	unsigned int words, prefix;
> +
> +	if (bytes <= 16)
> +		return check_bytes8(start, value, bytes);
> +
> +	value64 = value;
> +	value64 |= value64 << 8;
> +	value64 |= value64 << 16;
> +	value64 |= value64 << 32;
> +
> +	prefix = (unsigned long)start % 8;
> +	if (prefix) {
> +		u8 *r;
> +
> +		prefix = 8 - prefix;
> +		r = check_bytes8(start, value, prefix);
> +		if (r)
> +			return r;
> +		start += prefix;
> +		bytes -= prefix;
> +	}
> +
> +	words = bytes / 8;
> +
> +	while (words) {
> +		if (*(u64 *)start != value64)
> +			return check_bytes8(start, value, 8);
> +		start += 8;
> +		words--;
> +	}
> +
> +	return check_bytes8(start, value, bytes % 8);
> +}
> -- 
> 2.26.2
> 

-- 

- Arnaldo
