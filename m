Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB17C2FBF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391405AbhASSje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391267AbhASSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:36:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:35:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2B0B91F4545D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: ubd: Fix crash from option parsing
Organization: Collabora
References: <20210119181945.2071053-1-paullawrence@google.com>
Date:   Tue, 19 Jan 2021 15:35:35 -0300
In-Reply-To: <20210119181945.2071053-1-paullawrence@google.com> (Paul
        Lawrence's message of "Tue, 19 Jan 2021 18:19:45 +0000")
Message-ID: <871regg4g8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Lawrence <paullawrence@google.com> writes:

> Below patch will cause NULL ptr dereferences if the optional filenames
> are not present.
>
> Fixes: ef3ba87cb7c9 (um: ubd: Set device serial attribute from cmdline)
> Signed-off-by: Paul Lawrence <paullawrence@google.com>

Looks good.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Totally unrelated, but it seems the original patch writes a "(null)"
string to the sysfs attribute, if no serial is defined.  I think we
should have a default serial UBDX in case the user didn't provide any.

Thanks,

> ---
>  arch/um/drivers/ubd_kern.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 13b1fe694b90..704989088f28 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -371,15 +371,15 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
>  
>  break_loop:
>  	file = strsep(&str, ",:");
> -	if (*file == '\0')
> +	if (file && *file == '\0')
>  		file = NULL;
>  
>  	backing_file = strsep(&str, ",:");
> -	if (*backing_file == '\0')
> +	if (backing_file && *backing_file == '\0')
>  		backing_file = NULL;
>  
>  	serial = strsep(&str, ",:");
> -	if (*serial == '\0')
> +	if (serial && *serial == '\0')
>  		serial = NULL;
>  
>  	if (backing_file && ubd_dev->no_cow) {

-- 
Gabriel Krisman Bertazi
