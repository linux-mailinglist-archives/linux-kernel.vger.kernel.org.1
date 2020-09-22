Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24D4274466
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgIVOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIVOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=qPU+VkiAtrh9esT3iO20fW52J3A3GHhpnB60GUHwf68=; b=SFmRfPJ9/dvlfvXgOxtAr9mg5C
        MnmmwdR+bXxSrzm/ccW4w0NwLH+lgAU3F0hJ/9Zhvi4Sr2N2B4hrGkGEF23sFjUIZo9F79TbMbbuF
        OQDdXyXJmFpPx3vvBm9tryVl3ZjXXt7dg3R7r6EIgPwkP+c4HMbqiK9uMBMR1wyyTv1SK15hbBBNE
        1mX+Af3wVNhJAaEm8DZSwAGMHtkPtLY5jNdduklhSbpUGXV/nahB3EkduJpkTni4jL7FD1lff/g+s
        bqCPa62AypKsxo4RGkGeFYuQ78onk6/scC01YR6JAcrJSMuwhfYXyVKDdK4/qmZ1wG0XFvIKAlYWc
        8SDAdiiQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKjPw-0007MD-LA; Tue, 22 Sep 2020 14:37:17 +0000
Subject: Re: [PATCH] scripts: increase error-prone spell checking
To:     Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        David Hildenbrand <david@redhat.com>,
        SeongJae Park <sjpark@amazon.de>, Xiong <xndchn@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1600773524-3158-1-git-send-email-wangqing@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff5dbd13-86c1-89f6-2741-19dd49fdadcf@infradead.org>
Date:   Tue, 22 Sep 2020 07:37:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600773524-3158-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/20 4:18 AM, Wang Qing wrote:
> Increase direcly,ununsed,manger spelling error check
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  scripts/spelling.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index f253681..91ab82b
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -1534,3 +1534,6 @@ writting||writing
>  wtih||with
>  zombe||zombie
>  zomebie||zombie
> +direcly||directly
> +ununsed||unused
> +manger||manager
> \ No newline at end of file
> 

Uh, that file was in alphabetical order. Please try to keep it that way.

-- 
~Randy

