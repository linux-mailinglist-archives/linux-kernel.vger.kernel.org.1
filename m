Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8A25387A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZTqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:46:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD10C061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:46:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so1577416pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lIC466wcHw5fR4eYEVc57sBZjLUX/gzzPPg8yLp1ZZU=;
        b=WFkrzFpr1SUiFaPbGhhpAKHAmVxv3wzkj4tDR+4PHOR9/MlIRPYJGnmI664QGeO/Cx
         jh56BsF4d4+yUYLb3tteEQtrETtrsW7Vukw+0hQQ46Y1kVm7YzGQ12QR8x1BVWPj5ZyL
         5rDrqojD9sPXkIKEP7O2wCAa1fCxfWjqV9Rc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIC466wcHw5fR4eYEVc57sBZjLUX/gzzPPg8yLp1ZZU=;
        b=Wdx47mLvK05/gnGEaqypFyPvtlKQdrsY7wFuV+hH+17NvcJ2VO2VVkAHVPx63n7dEC
         IbojhoSVlbvTszk/1CwyijSKRvXGGj6pSFQG6cNAdrV5Lc5vYDp4okNvh3LT95JgGBW/
         NkOCrqwAw8yHTeDORt8AQmD2R/KReulYvHRSeJPEX5lv2Uhm7iCWOdtzlGz0OYzl4lnz
         VRnddvqPi68Fn5LKE5nAjsoZvNqFYhjL8sZ6wc4o9PdBy+xERdx8LTgQwxTi9+uczOuD
         k+fFyFT2jxoawRsKP9Cw1pYOk8/mo9o1tOPpBXuJwc5C8jgDu/M/XP3eSgmrVy6yO23z
         wpLQ==
X-Gm-Message-State: AOAM530VQKXU9+2mgG7rNvJNC39prwO3fmcBir1uxmvmA/fLAFVbRI2C
        fayWmJNLMks/FxyheIFBnjWilA==
X-Google-Smtp-Source: ABdhPJzfdv5XUXwJl1UOhKF/pH+9I5ADCLKzvf0FKe3PbEuFazJPlW1HymFX95ObV8KRL+rwcPkouA==
X-Received: by 2002:a62:5212:: with SMTP id g18mr8576508pfb.8.1598471186120;
        Wed, 26 Aug 2020 12:46:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ds19sm2262912pjb.43.2020.08.26.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 12:46:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:46:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH v4 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <202008261245.245E36654@keescook>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813153254.93731-3-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:32:53PM +0200, Stefano Garzarella wrote:
> +/*
> + * io_uring_restriction->opcode values
> + */
> +enum {
> +	/* Allow an io_uring_register(2) opcode */
> +	IORING_RESTRICTION_REGISTER_OP,
> +
> +	/* Allow an sqe opcode */
> +	IORING_RESTRICTION_SQE_OP,
> +
> +	/* Allow sqe flags */
> +	IORING_RESTRICTION_SQE_FLAGS_ALLOWED,
> +
> +	/* Require sqe flags (these flags must be set on each submission) */
> +	IORING_RESTRICTION_SQE_FLAGS_REQUIRED,
> +
> +	IORING_RESTRICTION_LAST
> +};

Same thought on enum literals, but otherwise, looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
