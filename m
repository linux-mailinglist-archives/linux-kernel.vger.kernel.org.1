Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFD2FF6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbhAUVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbhAUVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:07:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D689C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=9nroUsjiC2AUgaHn+ypKp7GnsR1m3gAlAmmdunHNdrw=; b=MQuna/m4ftAv/5SyQ9QaH1ohXJ
        UBM8oIhH7BKF6TmCSM/etkHW+PLgiDC5yeLoc3XJYKa1syRlJalLrvcFzGHZMMRLLCSaEWU5yUPlk
        GUTkLjETy9fhGaPIZaYe4vZ1vxjsvW2Req/MaRG7bQJSBdWmkdIs8+t+kkKd9KeXxNTGD2SIdgnNu
        pTywmBTl5uhj5dPtUQAboa4HccVLFyjfcLRXAERzrnZnO9Ig39A4pyuMUTQSybMgwLor2ycnfnO1g
        41x1zEXzsHTaY+d8RkgwZ3b6pRs4YHXa18yLoOpGz50h1EQu8jadGp7JYNTAiSQ3IW32/odLGEzP5
        0mISDtqg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2hAd-00008b-8J; Thu, 21 Jan 2021 21:07:11 +0000
Subject: Re: [PATCH] scripts: LOL what a patch! change Linus to Linux
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        torvalds@linux-foundation.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210121143014.8913-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <215566f1-b016-b42d-089f-bcf09240e9cf@infradead.org>
Date:   Thu, 21 Jan 2021 13:07:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210121143014.8913-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 6:30 AM, Bhaskar Chowdhury wrote:
> s/Linus/Linux/
> 
> ...how dare I?? :)
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Hi,

You missed a second occurrence of that a few lines later.

However, it is correct as is. It means the kernel tree
that Linus maintains -- sometimes known as mainline.

> ---
>  scripts/patch-kernel | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/patch-kernel b/scripts/patch-kernel
> index 033d5916797d..314e80c252c0 100755
> --- a/scripts/patch-kernel
> +++ b/scripts/patch-kernel
> @@ -7,7 +7,7 @@
>  # e.g.
>  #   scripts/patch-kernel . ..
>  #      Update the kernel tree in the current directory using patches in the
> -#      directory above to the latest Linus kernel
> +#      directory above to the latest Linux kernel
>  #   scripts/patch-kernel . .. -ac
>  #      Get the latest Linux kernel and patch it with the latest ac patch
>  #   scripts/patch-kernel . .. 2.4.9
> --
> 2.30.0
> 


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
