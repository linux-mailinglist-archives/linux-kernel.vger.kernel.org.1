Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770DC225A87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGTIze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 04:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgGTIzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:55:33 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2A520773;
        Mon, 20 Jul 2020 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595235332;
        bh=OTz0b1zn56xSY338F25IC4hm9bfR0uECcJXvYiLKvto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJK+zoweDui39cr8zOV1cV8a5UQPn9Yp1Is4uhuV0B27Lu5Hf6uSKI/MCNJXqt7PL
         6BQU27VWwQHFTir8kPyk7svquXOJoBWNul6pUcHhlP6r0TyGNXMiSUU2pL1KY2bZh1
         NiQcdKmk4W8SiGfOxk0QcKRmBJnYWyATOeAJUJoA=
Date:   Mon, 20 Jul 2020 10:55:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: linux/moduleparam.h: drop duplicated word in a
 comment
Message-ID: <20200720085529.GA25857@linux-8ccs>
References: <e6006b9e-48dd-5b79-b676-eab2fc71c718@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e6006b9e-48dd-5b79-b676-eab2fc71c718@infradead.org>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Randy Dunlap [17/07/20 16:36 -0700]:
>From: Randy Dunlap <rdunlap@infradead.org>
>
>Drop the doubled word "the" in a comment.
>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>---
> include/linux/moduleparam.h |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- linux-next-20200714.orig/include/linux/moduleparam.h
>+++ linux-next-20200714/include/linux/moduleparam.h
>@@ -108,7 +108,7 @@ struct kparam_array
>  * ".") the kernel commandline parameter.  Note that - is changed to _, so
>  * the user can use "foo-bar=1" even for variable "foo_bar".
>  *
>- * @perm is 0 if the the variable is not to appear in sysfs, or 0444
>+ * @perm is 0 if the variable is not to appear in sysfs, or 0444
>  * for world-readable, 0644 for root-writable, etc.  Note that if it
>  * is writable, you may need to use kernel_param_lock() around
>  * accesses (esp. charp, which can be kfreed when it changes).

Applied, thanks!

Jessica
