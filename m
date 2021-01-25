Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D230246D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbhAYLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbhAYLEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:04:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0EC061797
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 03:03:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a1so11853341wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5N3+ddZ+UprxFCv5SFv09Xet+R2UhwSGKGhfnHT8k88=;
        b=oNjWfI52xwCta/21UEjtxGJae3VHH5Lx8WGtrM54mHMHg1P6pFuFOaoFvmzXy44aBF
         Ofp9tVM3HnfZrr8rYgsvffl9Gq2Y9D5lCx1WNXbH1aIvMaD5qcAU+0q9b1dWfb4q/G6r
         Eblfhk4nDEfEMfBllM6Uooq04sHoD2mLNUZQhL86Y4gCg8cyEvJgLk7xkQCCujiGgM6m
         m7pQEPIaWNU/f5T93mb0BXX7feS/Nu5c4JlrNwauNTb6K4FHSHedfqsfX5NmYG3xyhnE
         HyNN4qEnIRQQN0XazwQRehcXe6mXsjaZAL1siO84rw5r5lSvsR/4oerdAnpoT0QOkfGm
         MCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5N3+ddZ+UprxFCv5SFv09Xet+R2UhwSGKGhfnHT8k88=;
        b=i8XRrA+G2Cd4+noliH982NmVcj/U9uD4jK0BzvoIzG+o326wCBImmv1NweXErl3z4o
         5B7nEmo6ZVWyUOVE/5yy4GvrQF01rhnVH+nJnbhzi1b8sosCTfcO0jV9sQaA78YhWtMf
         jhSoPTikPeeb/5Qah28Id+lAc5SYurMr01DV+hgaSEMPUlPyee/Pw9LzU6VokpF7o9Cg
         d022sOHOBrdCRBU6rfl+WurvJGQRchnNKk0DJKPw+QmG5a5pUibkHz6hFdK5S81AH8RV
         Qt0dxXCpGyysz9t+UP+7NjFeAOvkJOBmZd7T8A1duzbzNZJ1hTZFl8ZV1VMILWZibRsi
         DtTA==
X-Gm-Message-State: AOAM530ncnGDzLcfderB3gbyd6HVeiGEXuWRRjCJ5l+b6Otr0O5ULSeV
        8pkYPf1HPHpFM8LtcdFUazC1YA==
X-Google-Smtp-Source: ABdhPJwDr2YD7GGrjCIrhOnJUkrCd7lT1tjnHOw/JYV8oNb54ZWWO7PSkbN63E7dMdh0oKM1VwtarA==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr266235wrm.143.1611572594151;
        Mon, 25 Jan 2021 03:03:14 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d26sm1212479wrb.47.2021.01.25.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:03:13 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:03:11 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] kgdb: use new API for breakpoint tasklet
Message-ID: <20210125110311.pmqddpkh2c247tmx@maple.lan>
References: <20210123184237.6970-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123184237.6970-1-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 07:42:37PM +0100, Emil Renner Berthing wrote:
> This converts the kgdb_tasklet_breakpoint to use the new API in
> commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
> 
> The new API changes the argument passed to the callback function, but
> fortunately the argument isn't used so it is straight forward to use
> DECLARE_TASKLET() rather than DECLARE_TASKLET_OLD().

This patch overlaps with a more ambitious patch from Davidlohr.
Perhaps you can join in with the other thread since the discussion
there is unresolved. See:
https://lkml.org/lkml/2021/1/14/1320


Daniel.


> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  kernel/debug/debug_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index af6e8b4fb359..98d44c2bb0a4 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1090,13 +1090,13 @@ static void kgdb_unregister_callbacks(void)
>   * such as is the case with kgdboe, where calling a breakpoint in the
>   * I/O driver itself would be fatal.
>   */
> -static void kgdb_tasklet_bpt(unsigned long ing)
> +static void kgdb_tasklet_bpt(struct tasklet_struct *unused)
>  {
>  	kgdb_breakpoint();
>  	atomic_set(&kgdb_break_tasklet_var, 0);
>  }
>  
> -static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
> +static DECLARE_TASKLET(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
>  
>  void kgdb_schedule_breakpoint(void)
>  {
> -- 
> 2.30.0
> 
