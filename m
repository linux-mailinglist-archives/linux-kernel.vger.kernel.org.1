Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652B91DD034
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgEUOjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 10:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgEUOjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:39:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCDC20671;
        Thu, 21 May 2020 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590071946;
        bh=AUrIYszsGcTlofI5OitFwXmvXCOlSVlZDrQb5lN3o+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=woHkGv73Kt4bS5VdJBXEs0MT6SuWBINUqq1MxivFRNo80V/vHPzCJQIQCU7fA217c
         iF7tX83CvNz9F5EKBwPScl85q2TdC7ajxjC3vVJ+P99vAV9r/l59ydpuxKYg8ynScK
         wtfaK4OeMwserxQpOSjAqRuCGvcl2eCj+jW/eJvw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A822A40AFD; Thu, 21 May 2020 11:39:03 -0300 (-03)
Date:   Thu, 21 May 2020 11:39:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: Re: [PATCH 3/4] perf util: Fix memory leak of prefix_if_not_in
Message-ID: <20200521143903.GD3898@kernel.org>
References: <20200521133218.30150-1-liwei391@huawei.com>
 <20200521133218.30150-4-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521133218.30150-4-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 21, 2020 at 09:32:17PM +0800, Wei Li escreveu:
> From: Xie XiuQi <xiexiuqi@huawei.com>
> 
> Need to free "str" before return when asprintf() failed
> to avoid memory leak.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  tools/perf/util/sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f14cc728c358..8ed777565c82 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2811,7 +2811,7 @@ static char *prefix_if_not_in(const char *pre, char *str)
>  		return str;
>  
>  	if (asprintf(&n, "%s,%s", pre, str) < 0)
> -		return NULL;
> +		n = NULL;
>  
>  	free(str);
>  	return n;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
