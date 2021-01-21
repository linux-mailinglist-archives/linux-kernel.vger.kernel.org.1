Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769E22FE237
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbhAUGDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbhAUDDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:03:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4121C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 19:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Tz4eh/epvuxjUlyBvUoX/h0EwPG+odHODVcBDV5o+yI=; b=ox1IJE/xGoYSa58agOz9SJz93w
        PRvid1xLoRD1Yc4gXPtg7V4L/NlIXzJN6BVeDc5TRh9COjXuvuiltCxVV0m7AJgTOi+csjMDolN4h
        O2CGx5bvwdkEloY24mh3tVbwlypWM9NJLX0cbiR4hmGzCkc7ccfom1sPCf5Euix4W98OFYpGbMNua
        49+FBtAoCFWoO/xHbmVmfmK7Wd5Ln3AaAEJt/aLgoRAubtH7sWOFX3L6bHS2/3kuZHHQXcTHDhhn1
        INJW2LY50WcznbS9viMxV3hVxfzaQEsnROPz24wtjP8PSY8DV0fLbsHe325XEtuJJmJCubq0cJHBG
        DL5NxIRA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2QF0-0007IZ-RG; Thu, 21 Jan 2021 03:02:35 +0000
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell checking
To:     ChunyouTang <tangchunyou@163.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, xndchn@gmail.com, j.neuschaefer@gmx.net,
        luca@lucaceresoli.net, naoki.hayama@lineo.co.jp,
        ebiggers@google.com, sjpark@amazon.de, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
References: <20210121020731.2316-1-tangchunyou@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47008cd9-2b87-f5b2-5fad-e8f009869dda@infradead.org>
Date:   Wed, 20 Jan 2021 19:02:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210121020731.2316-1-tangchunyou@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 6:07 PM, ChunyouTang wrote:
> From: tangchunyou <tangchunyou@yulong.com>
> 
> Increase direcly,maping,manger spelling error check

Hi,
I don't see all of those in the patch below.
What happened?

> Signed-off-by: WenZhang <zhangwen@yulong.com>
> ---
>  scripts/spelling.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index 953f4a2..ebcb27b 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -875,6 +875,7 @@ manger||manager
>  manoeuvering||maneuvering
>  manufaucturing||manufacturing
>  mappping||mapping
> +maping||mapping
>  matchs||matches
>  mathimatical||mathematical
>  mathimatic||mathematic
> 

thanks.

-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
