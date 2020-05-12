Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EDC1CFEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 22:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbgELUFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 16:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgELUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:05:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101BC061A0C;
        Tue, 12 May 2020 13:04:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2328412836EE4;
        Tue, 12 May 2020 13:04:58 -0700 (PDT)
Date:   Tue, 12 May 2020 13:04:57 -0700 (PDT)
Message-Id: <20200512.130457.1412393753257936462.davem@davemloft.net>
To:     christian.brauner@ubuntu.com
Cc:     arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/3] sparc64: enable HAVE_COPY_THREAD_TLS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200512171527.570109-2-christian.brauner@ubuntu.com>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
        <20200512171527.570109-2-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 May 2020 13:04:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 19:15:25 +0200

> +sys_vfork:
> +	flushw
> +	ba,pt	%xcc, sparc_vfork
> +	add	%sp, PTREGS_OFF, %o0

Please follow the convention of indenting an extra space before
instructions in the delay slot of branch instructions.

> +	ba,pt	%xcc, sparc_fork
> +	add	%sp, PTREGS_OFF, %o0

Likewise.

>  sys_clone:
>  	flushw
> -	movrz	%o1, %fp, %o1
> -	mov	0, %o3
> -	ba,pt	%xcc, sparc_do_fork
> -	 add	%sp, PTREGS_OFF, %o2
> +	ba,pt	%xcc, sparc_clone
> +	add	%sp, PTREGS_OFF, %o0

Likewise.
