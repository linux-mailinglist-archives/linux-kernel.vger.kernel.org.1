Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF16B244822
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHNKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 06:35:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47424 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:35:30 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k6X3M-00050T-G5; Fri, 14 Aug 2020 10:35:16 +0000
Date:   Fri, 14 Aug 2020 12:35:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     oleg@redhat.com, ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Convert to use the preferred fallthrough macro
Message-ID: <20200814103515.tobuao5kd42lcryn@wittgenstein>
References: <20200814083932.4975-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814083932.4975-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 04:39:32AM -0400, Miaohe Lin wrote:
> Convert the uses of fallthrough comments to fallthrough macro.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

This matches what we have documented in:

Documentation/process/deprecated.rst
Documentation/process/coding-style.rst

I'm going to reference that info in the commit message.

Applied, queueing for post rc1.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 6f16f7c5d375..27505ca5be2d 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -851,7 +851,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
>  			 */
>  			if (!sid || sid == task_session(current))
>  				break;
> -			/* fall through */
> +			fallthrough;
>  		default:
>  			return -EPERM;
>  		}
> -- 
> 2.19.1
> 
