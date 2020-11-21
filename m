Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F042BC24A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 22:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgKUVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 16:40:19 -0500
Received: from mail.alarsen.net ([144.76.18.233]:50576 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgKUVkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 16:40:18 -0500
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:40e7:424f:4d36:7fd2])
        by joe.alarsen.net (Postfix) with ESMTPS id 416CC2B80439;
        Sat, 21 Nov 2020 22:40:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1605994817; bh=2awW3mgEqEV/daRfAclvkh4F9k5IYVwtCGHMH+2xswA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9IIOyeh5ch0CHB6+neZeJD2/OMi1kd0Cwyf+sYChpcGdb0BlK4ijPOABsMZmjX68
         Y05zXsrG6FOq+aJKDCImjWb2Z/PFFnMBcccu6IuGqmBUrCE18mGhQtQN24FJOB0SH9
         qvjZtMAhIwYKN3h2xRJcxh5CTdUfxEQ4kUPPjc/0=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 1DE6F27C0929;
        Sat, 21 Nov 2020 22:40:17 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] qnx4_match: do not over run the buffer
Date:   Sat, 21 Nov 2020 22:40:17 +0100
Message-ID: <2474566.rpppqFFLNx@alarsen.net>
In-Reply-To: <20201120212120.2502522-1-ztong0001@gmail.com>
References: <20201120212120.2502522-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2020-11-20 22:21 Tong Zhang wrote:
> the di_fname may not terminated by '\0', use strnlen to prevent buffer
> overrun
> 
> ---
>  fs/qnx4/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..c0e79094f578 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -40,7 +40,7 @@ static int qnx4_match(int len, const char *name,
>  	} else {
>  		namelen = QNX4_SHORT_NAME_MAX;
>  	}
> -	thislen = strlen( de->di_fname );
> +	thislen = strnlen( de->di_fname, QNX4_SHORT_NAME_MAX );

that should be
+	thislen = strnlen( de->di_fname, namelen );
otherwise the length of a filename would always be limited to QNX4_SHORT_NAME_MAX (16) characters.

>  	if ( thislen > namelen )
>  		thislen = namelen;

These two lines can be dropped now, as the result of strnlen() cannot exceed namelen anyway.

Cheers
Anders


