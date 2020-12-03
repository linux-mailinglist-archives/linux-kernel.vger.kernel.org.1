Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE33A2CCB02
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgLCAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCAdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:33:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA45C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HkJPuzIoEoRGMQkqrWbbHFz0fNY4zMWL9EeMXnbMdug=; b=wI5pPKqT0k+5hom7VojgGQ6Vu8
        CrillD9e/74ZE1emJUdcTZeaalQn/V6Z0jxFIAV9cK1cxy+vYs0oUDtnN94T9SHniNiErUdv8yoli
        rSQZUOpVm0loZ28oZDKt2IzxZZmDllVKA3A4fU04D8QtgU7UUBFsysS1hUDFHF/FCJjxuO8kKrKqk
        JvKNGwAixicon0sDBtYRZleJ7Zv0A0Fr16yOiMREu6wHq8zSUfzJsrF4LH4K4E4Lj9R4GIGR3zS0y
        7B7vO+w1NsDs+nbtI0hSX/1MI+pkLS8jJ+pR4ZjFYcf2eX6oXRt2oqOajv02YS87O6Hz63uXhyrYl
        7TpQ+YnA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkcXi-00008r-KM; Thu, 03 Dec 2020 00:32:18 +0000
Subject: Re: [PATCH] Documentation: fix typos in process/kernel-docs.rst
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
References: <20201202074938.GA35075@spblnx124.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e95ab716-6574-2a1f-ba61-3d4970b67640@infradead.org>
Date:   Wed, 2 Dec 2020 16:32:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202074938.GA35075@spblnx124.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 11:49 PM, Andrew Klychkov wrote:
> Fix two typos in kernel-docs.rst
> 
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/process/kernel-docs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 64786e5..22d9ace 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -90,7 +90,7 @@ On-line docs
>        :Date: 2008
>        :Keywords: patches, review process, types of submissions, basic rules, case studies
>        :Description: This paper gives several experience values on what types of patches
> -        there are and how likley they get merged.
> +        there are and how likely they get merged.
>        :Abstract:
>          [...]. This paper examines some common problems for
>          submitting larger changes and some strategies to avoid problems.
> @@ -328,7 +328,7 @@ On-line docs
>          block devices, hardware interrupts, scsi, DMA, access to user memory,
>          memory allocation, timers.
>        :Description: A guide designed to help you get up to speed on the
> -        concepts that are not intuitevly obvious, and to document the internal
> +        concepts that are not intuitively obvious, and to document the internal
>          structures of Linux.
>  
>      * Title: **Dynamic Kernels: Modularized Device Drivers**
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
