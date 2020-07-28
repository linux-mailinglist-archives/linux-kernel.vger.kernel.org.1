Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA05523099B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgG1MKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:10:47 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622DE2065E;
        Tue, 28 Jul 2020 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595938247;
        bh=GvoIoaKjka0iyuegACVxoZ0+HYUPFjnL7RFPFQArroY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3SMB2zhxsJV8FWjF8d2Vk99xrzjg/Bz/XUaMizrlD9mftTc/lm6aJk366pd9aUFI
         3mbjuJYJxFTnh6gXXJ97UMTQB4qhYV45T79DPu8wDFkmuGcOBhgNt5sW9SthDL7KwE
         TEiDBJBoYo+EpyFt6IhZwbDBGTJpQ4S6XSvPrsGw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 17B7C404B1; Tue, 28 Jul 2020 09:10:45 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:10:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked
 in jvmti_agent.c
Message-ID: <20200728121045.GC40195@kernel.org>
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 24, 2020 at 06:07:06PM +0800, Wang ShaoBo escreveu:
> Function jvmti_write_code called by compiled_method_load_cb may return
> error in using fwrite_unlocked, this failure should be captured and
> warned.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index 88108598d6e9..a1fe6aa16b6d 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>  	struct jr_code_load rec;
>  	size_t sym_len;
>  	FILE *fp = agent;
> -	int ret = -1;
> +	int ret;
>  
>  	/* don't care about 0 length function, no samples */
>  	if (size == 0)
> @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
>  	rec.code_index = code_generation++;
>  
>  	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
> -	fwrite_unlocked(sym, sym_len, 1, fp);
> +	if (ret)
> +		goto error;
> +	ret = fwrite_unlocked(sym, sym_len, 1, fp);
> +	if (ret)
> +		goto error;
>  
> -	if (code)
> -		fwrite_unlocked(code, size, 1, fp);
> +	if (code) {
> +		ret = fwrite_unlocked(code, size, 1, fp);
> +		if (ret)
> +			goto error;
> +	}
>  
>  	funlockfile(fp);
> -
> -	ret = 0;
> -
> -	return ret;
> +	return 0;
> +error:
> +	funlockfile(fp);
> +	return -1;
>  }
>  
>  int
> -- 
> 2.17.1
> 

-- 

- Arnaldo
