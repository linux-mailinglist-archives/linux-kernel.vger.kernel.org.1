Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206C729D694
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgJ1WQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbgJ1WQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:16:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:16:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b2so606456ots.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ShTERb1GS0+jwgJku6Cb1kl4S5GvzvEW11gOp8nfImg=;
        b=I7dTm5l3EqjRPY3FAPCat1chzLEyU//v9ieO0WCYcjY6khjwdtllePuW/FIn87yL8m
         eSdNMQfaV9+TZeOGMHLs7cBPPweEZ+LDpVwE7B2emqhseRgwN0v/lzYgvAvxuh+kLNjF
         YulCxKo4qyedRbeW8QuA9XbHlOM1WUVw6YyeNX9kNYZie5pigvqOBUsuA8g5n6fFmsKz
         iYQbyo4LmjXs6+Umqy1CbSJoddo5Kk+wA0rNoDgVlt5NSb5E9QSAdgecN+DoXdeBNtat
         M74jSpdZe/WbZnBJEI+35Oa4Q/g//jGbDwKZLR/gjoJgC3IRoN+5v6OzdbvwOnoTJjmg
         StAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ShTERb1GS0+jwgJku6Cb1kl4S5GvzvEW11gOp8nfImg=;
        b=OtMi7wqnuxGWfkoq+wUcMsDEFv6xXrhvluykD8BkRO+yjJY+JtTEnOy96yiyZFPugx
         EtkVsWVjW0RyYQ0EQOhAhfx9uLdS1SomEiOLaCkx75N7lqrYg4JdJKPC7IGknuPorIAb
         1Iw1jOUEeUR3OQoGJ1K2mtuIEDWQUJbzEvQX0Shd6luzehmmV3nHlXNrQ80tilcTu5+f
         JR3a4YCXy190PUJzNjv4gzMUSkXZDQA9LyZB8O0DnuvmTJ/8XWg4hgMgS3K5NzFdnud2
         Q4LasQwpwkqVFKNVOZJ5bS2jqQiX8HTFZbYMz5Kp7VuVgt3BnhIQGPdtL5L2HtUidqSW
         DR4A==
X-Gm-Message-State: AOAM533Nkd6OlvNntWyO5pRO2qNv0yqWs9WhWtwi19MsZNdM26CM+Dwt
        nnOZO5ZoQMaYSwQpn5UYaAVcFqLRhc9+Pw==
X-Google-Smtp-Source: ABdhPJxOM0r28xsKidRRKl17uenS4qar4leRy3gwT2rnOsNhfmxHebPvclYiE3adCxgMApj6s03Lbw==
X-Received: by 2002:a9d:4047:: with SMTP id o7mr5788266oti.49.1603898676960;
        Wed, 28 Oct 2020 08:24:36 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s186sm2651059oih.34.2020.10.28.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:24:36 -0700 (PDT)
Date:   Wed, 28 Oct 2020 10:24:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 resend] qcom-geni-se: remove has_opp_table
Message-ID: <20201028152434.GA24428@builder.lan>
References: <08ec1ee1d4252a266956abb5f1e0e0026d753564.1603867487.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ec1ee1d4252a266956abb5f1e0e0026d753564.1603867487.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28 Oct 01:46 CDT 2020, Viresh Kumar wrote:

> has_opp_table isn't used anymore, remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thank you Viresh.

> 
> ---
>  include/linux/qcom-geni-se.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index f7bbea3f09ca..ec2ad4b0fe14 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -48,7 +48,6 @@ struct geni_icc_path {
>   * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
>   * @icc_paths:		Array of ICC paths for SE
>   * @opp_table:		Pointer to the OPP table
> - * @has_opp_table:	Specifies if the SE has an OPP table
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -59,7 +58,6 @@ struct geni_se {
>  	unsigned long *clk_perf_tbl;
>  	struct geni_icc_path icc_paths[3];
>  	struct opp_table *opp_table;
> -	bool has_opp_table;
>  };
>  
>  /* Common SE registers */
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
