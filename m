Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28F31F8EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgFOGxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 02:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgFOGxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:53:10 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6622067B;
        Mon, 15 Jun 2020 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203990;
        bh=4t4BQuTpBRmFUMtKU+bffnlROhDwEnWBUjcVE+v4+VQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NMWMP0oUU538p7xvO8dF1i4bGteEnrvbG7l9o6PRF5/026GPSUxhoUEkkl+Xo/PkP
         hDLRDQKH/E10siyKmxGE37zrLkkyQTvbWpAu5Xi2PZrzvFfcT62lvdPxiQYA+VNQu9
         V16nsnk0k5sBZnIVS4SKMqeu9+F5AdExMwCRdvjM=
Date:   Mon, 15 Jun 2020 08:53:05 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Documentation: fix malformed table in
 filesystems/proc.rst
Message-ID: <20200615085305.275a7b24@coco.lan>
In-Reply-To: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
References: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 14 Jun 2020 20:33:22 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix malformed table in "proc.rst" by dropping a needless hyphen ('-').
> 
> Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
> Text in column margin in table line 29.
> 
> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Kiss <daniel.kiss@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

I submitted an identical patch on Jan, 3. 

> ---
>  Documentation/filesystems/proc.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-58-rc1.orig/Documentation/filesystems/proc.rst
> +++ lnx-58-rc1/Documentation/filesystems/proc.rst
> @@ -545,7 +545,7 @@ encoded manner. The codes are the follow
>      hg    huge page advise flag
>      nh    no huge page advise flag
>      mg    mergable advise flag
> -    bt  - arm64 BTI guarded page
> +    bt    arm64 BTI guarded page
>      ==    =======================================
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
> 



Thanks,
Mauro
