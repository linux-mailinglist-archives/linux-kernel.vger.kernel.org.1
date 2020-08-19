Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DEC24A589
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHSSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgHSSEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:04:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3794C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:04:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so1480582pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o5QWU1nEiy+Wm6gh5sFTQwgB0RXtZgwdt6tODGtZKRg=;
        b=Dm12xVmMzZ7+gsbRjbkm68z3UhSAAY6ovLHRwBvSlZRYXMn/jyVefCRwwEuid/htYs
         br88nAj9HKrAuowA12vkOzJAwRYaRkbgsNo09lWJDv7VL18k1yKtxP+qrqbV68ClR1J9
         aINuOTkBRJSvuCX+knwKWIe7bXQAL6ulo1Sg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5QWU1nEiy+Wm6gh5sFTQwgB0RXtZgwdt6tODGtZKRg=;
        b=RRCmcnoxS91evnDgYSn+nPPtfsxi1QR1BmhPeZq2CZgVWHcbbdXucDosW9PDI6TZ/A
         ER+o9xQtZNlfDJbtLvf65NlT2BsrgDDu/nTa6IIEgc/Gtkl0KBArWsCnlI1vGk2WOvZP
         sEGdC8OjZPemwTeL1hnjKLYIru6tmINdx2x+Bwhbv+Nnzlczh0qh5x2RuksEMy2bFBVT
         CrEbAE4Sql1BbiNJNuDRn88VgGy2lP6HFbX87y9zA7JyZ5AimHVxPEl7zoi/nDx0Mn0C
         e0kTdQ9pdxJ5BFe18frCsgMYxNGUikAChWH9H3Y7xJtVDI2Z6GIXFNWUM0JMlGfpVX55
         Wq6g==
X-Gm-Message-State: AOAM532gst47/JY2HLMbgbYZrvH9Zsm4Vxgmas/JORN8b5sfZXpvh69i
        Iv5mym+UCSKcKU+5D/XaDVjl6G1C2psU8Q==
X-Google-Smtp-Source: ABdhPJzcCUFsTUuuU/7fR9DIMfV1GDtBk230JWzP+wvh2sEXRmU+hodx93sL2eXCM5k81uPM4O9/vg==
X-Received: by 2002:a17:90b:46d3:: with SMTP id jx19mr5046020pjb.158.1597860267077;
        Wed, 19 Aug 2020 11:04:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm3563704pju.56.2020.08.19.11.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:04:26 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:04:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Message-ID: <202008191103.D88345E410@keescook>
References: <20200817115933.44565-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817115933.44565-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:59:33AM -0400, Miaohe Lin wrote:
> There is no need to check if this process has the right to modify the
> specified process when they are same.
> 
> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 34a842a8eb6a..342c1ce0b433 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1903,7 +1903,7 @@ static int kernel_move_pages(pid_t pid, unsigned long nr_pages,
>  	 * Check if this process has the right to modify the specified
>  	 * process. Use the regular "ptrace_may_access()" checks.
>  	 */
> -	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> +	if (pid && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>  		rcu_read_unlock();
>  		err = -EPERM;
>  		goto out;

NAK, please don't do this -- the ptrace and security hooks already do
these kinds of self-introspection checks, and I'd like to keep a central
place to perform these kinds of checks.

Is there a specific problem you've encountered that this fixes?

-- 
Kees Cook
