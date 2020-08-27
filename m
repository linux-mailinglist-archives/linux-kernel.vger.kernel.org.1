Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD5254765
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgH0Otu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgH0N5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:57:18 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DAC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:49:49 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f75so4897051ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ummG6Am4WVVHwG6OsEcF+5DXkgqqBrieiDmLqcZ52gg=;
        b=i2xtwAqsurDUjdtcPOaRrUkN3kpRZdtKTDcjz9HwCGEOxQ6uuUwwioX2ctbvc+wVAg
         +yIMBIVx4k5ydmaIA9+tRqrgESalSpR4HUJeavh/6+Z6tCm5LqgyImSd2vkjqiCjv0i/
         +6uLeOZI/DQgZjzXsYQeAHPmy35xX0EdHohzYOUyUox6E65KaArNi4HMiwvJ4k44Z61m
         1jj6+YKH+IbuKTnNTTYDGnWG5gtcgWxE/NmKF5V2XVaOu+5mig9Gz8SswY2+rgZCbn2D
         J4sE12JGv+dI7ZhKQKveG/+f0eQ5+zgP+N7m8entyPNUh5ztEe9hGXqr6UnmXdFWHAaO
         8A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ummG6Am4WVVHwG6OsEcF+5DXkgqqBrieiDmLqcZ52gg=;
        b=szqC+ee0rlEev3LTqrbqbl33cLpfA9YVOpBTTuWJxF9/3Q43dGitKBly6oN8kfCdzM
         p2wFO6zFelJg3d92gU0OhB8qruPq2CL2SNrYx5rmsWR98efjzFDTv3WXM8SxxhmA8e9h
         HpPnR7mrHNG1ttYqOYw+kuh/fxkg6BGWSZ0vD/J3LunK15IGdBjJIUe18U2jdsI9z0OD
         wx+a/qq81Wr6enKZM/tS6UihIRS30KLa/MOW3HoDUJVMX9QLZpaeTovAixBMIsgSaoEQ
         Fkucm78cfNW8SxiKPEHvl+GEINi756hZm/UqUelssjeb6dgFcJGA5jBvkYGxLVf0o/OT
         O/vA==
X-Gm-Message-State: AOAM531I687KU2I4pdBQYwZXxwPxhWeokgnj7LBYw0kfLRhTVmaz9Gy2
        /mVROaW2FqFKUjTW2HVg7vGdTw==
X-Google-Smtp-Source: ABdhPJxg8EFdtE5lch9P7WZZq4szMfYAPC4FnMVG1t1FuT14x/ja8mX6J3/sRpVLkRSFUHuqrwmpSg==
X-Received: by 2002:a92:1b84:: with SMTP id f4mr17224386ill.180.1598536187325;
        Thu, 27 Aug 2020 06:49:47 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k2sm1230975ioj.2.2020.08.27.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:49:46 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20200827134044.82821-1-sgarzare@redhat.com>
 <20200827134044.82821-3-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <206a32b6-ba20-fc91-1906-e6bf377798ae@kernel.dk>
Date:   Thu, 27 Aug 2020 07:49:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827134044.82821-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 7:40 AM, Stefano Garzarella wrote:
> @@ -6414,6 +6425,19 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  	if (unlikely(sqe_flags & ~SQE_VALID_FLAGS))
>  		return -EINVAL;
>  
> +	if (unlikely(ctx->restricted)) {
> +		if (!test_bit(req->opcode, ctx->restrictions.sqe_op))
> +			return -EACCES;
> +
> +		if ((sqe_flags & ctx->restrictions.sqe_flags_required) !=
> +		    ctx->restrictions.sqe_flags_required)
> +			return -EACCES;
> +
> +		if (sqe_flags & ~(ctx->restrictions.sqe_flags_allowed |
> +				  ctx->restrictions.sqe_flags_required))
> +			return -EACCES;
> +	}
> +

This should be a separate function, ala:

if (unlikely(ctx->restricted)) {
	ret = io_check_restriction(ctx, req);
	if (ret)
		return ret;
}

to move it totally out of the (very) hot path.

>  	if ((sqe_flags & IOSQE_BUFFER_SELECT) &&
>  	    !io_op_defs[req->opcode].buffer_select)
>  		return -EOPNOTSUPP;
> @@ -8714,6 +8738,71 @@ static int io_unregister_personality(struct io_ring_ctx *ctx, unsigned id)
>  	return -EINVAL;
>  }
>  
> +static int io_register_restrictions(struct io_ring_ctx *ctx, void __user *arg,
> +				    unsigned int nr_args)
> +{
> +	struct io_uring_restriction *res;
> +	size_t size;
> +	int i, ret;
> +
> +	/* We allow only a single restrictions registration */
> +	if (ctx->restricted)
> +		return -EBUSY;
> +
> +	if (!arg || nr_args > IORING_MAX_RESTRICTIONS)
> +		return -EINVAL;
> +
> +	size = array_size(nr_args, sizeof(*res));
> +	if (size == SIZE_MAX)
> +		return -EOVERFLOW;
> +
> +	res = memdup_user(arg, size);
> +	if (IS_ERR(res))
> +		return PTR_ERR(res);
> +
> +	for (i = 0; i < nr_args; i++) {
> +		switch (res[i].opcode) {
> +		case IORING_RESTRICTION_REGISTER_OP:
> +			if (res[i].register_op >= IORING_REGISTER_LAST) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			__set_bit(res[i].register_op,
> +				  ctx->restrictions.register_op);
> +			break;
> +		case IORING_RESTRICTION_SQE_OP:
> +			if (res[i].sqe_op >= IORING_OP_LAST) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			__set_bit(res[i].sqe_op, ctx->restrictions.sqe_op);
> +			break;
> +		case IORING_RESTRICTION_SQE_FLAGS_ALLOWED:
> +			ctx->restrictions.sqe_flags_allowed = res[i].sqe_flags;
> +			break;
> +		case IORING_RESTRICTION_SQE_FLAGS_REQUIRED:
> +			ctx->restrictions.sqe_flags_required = res[i].sqe_flags;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	ctx->restricted = 1;
> +
> +	ret = 0;

I'd set ret = 0 above the switch, that's the usual idiom - start at
zero, have someone set it to -ERROR if something fails.

-- 
Jens Axboe

