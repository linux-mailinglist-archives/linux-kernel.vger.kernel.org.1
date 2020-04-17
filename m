Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92F1AD772
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgDQHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgDQHb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:31:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7600214AF;
        Fri, 17 Apr 2020 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587108719;
        bh=Xu2I5aZjH5oCRoZlSX0jTLjTnHV7Btp7OW+Qlox4bw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NQv4ii3zEJJUkiNAcRvLlILh/ZUXhtvjy3E/Jy9XVTt+mhswR1vzuZkxFFYWqzSR
         sqcNa8h0OkEZ0UQxF+onFISch4A21EkHpvR8dxixL4+6iKtcED3tBC3xnaffQnIhSM
         MrrpNYBk7f7oANym37qrW/txJeb4vKAVqtLjP0kk=
Date:   Fri, 17 Apr 2020 08:31:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] samples/hw_breakpoint: make sample_hbp static
Message-ID: <20200417073155.GA10812@willie-the-truck>
References: <20200417073542.42721-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417073542.42721-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 03:35:42PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> samples/hw_breakpoint/data_breakpoint.c:24:19: warning: symbol
> 'sample_hbp' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  samples/hw_breakpoint/data_breakpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
> index 418c46fe5ffc..37c4f0ea8e53 100644
> --- a/samples/hw_breakpoint/data_breakpoint.c
> +++ b/samples/hw_breakpoint/data_breakpoint.c
> @@ -21,7 +21,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/hw_breakpoint.h>
>  
> -struct perf_event * __percpu *sample_hbp;
> +static struct perf_event * __percpu *sample_hbp;
>  
>  static char ksym_name[KSYM_NAME_LEN] = "jiffies";
>  module_param_string(ksym, ksym_name, KSYM_NAME_LEN, S_IRUGO);

Acked-by: Will Deacon <will@kernel.org>

Will
