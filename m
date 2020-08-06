Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF323DD28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgHFREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgHFRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2AC0A8887;
        Thu,  6 Aug 2020 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZGg2qVzn0hLzJGuPtNgIsWGMBLZdqXuiz8IcBFNPWs4=; b=UaC0GNh60hEnWVu1sJAg3Gl+eM
        beqy9kN6ieq1fKLRJUJrKSI8XyqLZ9lNo6HEMu/lqWG1m60+vfuLAqw2dHO52pbIBmjgRLyZgrU+F
        SQpmb8DNXByCxAM/BU8Ts4qO5g1oc73jDBnJmRQLaRLlfuA47MD549OazIOkH6XTKpBR6ePUSnzbn
        a8JkUNrISBLWNrCnK2AgQzNV03hXcc69OahYgHmhy5PFtaiMCXm4JjZaKdXoqoYY0xFtVCQhZ34G4
        bwcUprnSLAGl48jdlJN+tRuXdHj2IwnMxQ6dIC40hXIVeBKgyd7JaOnUmpbVGeXx1UnHPOzUbmGMq
        yIAXkftg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3ggn-0005Iu-0j; Thu, 06 Aug 2020 14:16:13 +0000
Subject: Re: [PATCH][next][V2] staging: wfx: fix a handful of spelling
 mistakes
To:     Colin King <colin.king@canonical.com>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806104701.46123-1-colin.king@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d822037-d8f8-cbac-6df2-fe7296ad4d32@infradead.org>
Date:   Thu, 6 Aug 2020 07:16:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104701.46123-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 3:47 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are various spelling mistakes in comments and error messages.
> Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: add in some more fixes as spotted by Randy Dunlap
> 
> ---
>  drivers/staging/wfx/data_rx.c | 2 +-
>  drivers/staging/wfx/data_tx.c | 2 +-
>  drivers/staging/wfx/debug.c   | 6 +++---
>  drivers/staging/wfx/hif_rx.c  | 2 +-
>  drivers/staging/wfx/hif_tx.c  | 4 ++--
>  drivers/staging/wfx/main.c    | 2 +-
>  drivers/staging/wfx/main.h    | 2 +-
>  drivers/staging/wfx/sta.c     | 2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)

> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 11dfa088fc86..4263f912760b 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -384,7 +384,7 @@ int wfx_probe(struct wfx_dev *wdev)
>  	err = wfx_sl_init(wdev);
>  	if (err && wdev->hw_caps.capabilities.link_mode == SEC_LINK_ENFORCED) {
>  		dev_err(wdev->dev,
> -			"chip require secure_link, but can't negociate it\n");
> +			"chip require secure_link, but can't negotiate it\n");

			      requires

>  		goto err0;
>  	}

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

