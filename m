Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E41C5CB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgEEP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgEEP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:56:52 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14E1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:56:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so2820539qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwoyW2n1DozO1QmCmeQxHA+00Z25eF6ojz5X9aF83cY=;
        b=HSPrS7yOzgC+HwLvjrsTGcM6pb0DO2at3YJvPSCa2meteXy41ZmP4XIt1d+vymHtjR
         ovLoGiMYepV9uiaD2DcguBDIznIgBFrSVXajxSYklJlKvNRUZPViTcyUzRu4iGVi5RyS
         IO+rL60wfq+3Tgt7wmAuXrIWoS28X4VScwPVItIVFaxf3btox+eCqIWYcDdqECF7nKRq
         n2ZeSmy9fUoM3ENL0yFeIzymuu7E55DZU/Ew48Qu/RdEsCOjBJfu7X0sfPFQByRgXCYE
         WfHd3XP8X+myDc17DejH+gN/9b3JoNJ90oq/En5JAUaUsVc5WXZvMq+lAQVcKh6oQlFg
         VWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TwoyW2n1DozO1QmCmeQxHA+00Z25eF6ojz5X9aF83cY=;
        b=YTcGWkb11dGXN1cF9/iGqIzywPnBD1dEgYYs4Ryyd/hzJF88BZ27bbsTYTSlIO16Kn
         BGI/stP3MY7PuctysKIOrYhm93eliBXoN7AnJNnaGYee61b2eb2aAnCf3xcRVWl1QJyk
         ZTV8aWAG6vOAHNTRhGFbAR9OChkv3eA3iZlH59q0G089549j/PVzYqO1UPdbHCMlFrBI
         50FQatGtQfQuC2l+syqCotUtZ/1eA7v/tUSjD8Ct3yfXtSo+ucK61MHRHHPyge6sKBeo
         o68bLS1C346wQ2pcp2ov7wy4soxIKLr7+A6lb/GTwxKQj2/azGZnPJqcu3dyh8upIEHS
         XKnQ==
X-Gm-Message-State: AGi0PuZo/s/iKQxCBGbxMqAzjhO2wap5wp0E+jaUOQHeY42yKcihEXWG
        BYulkraI8AHqfSqt4mlSkQcy0C7HNYU=
X-Google-Smtp-Source: APiQypJ6+R6EfzWK8WWd6/vFhpAlNZ6km/bPEqE4h3/SCvsZnT3Q0IZzT4JjT77TAYTfRXX8xVnwXg==
X-Received: by 2002:a37:aa52:: with SMTP id t79mr1287508qke.448.1588694211049;
        Tue, 05 May 2020 08:56:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5ece])
        by smtp.gmail.com with ESMTPSA id p22sm1949582qtb.91.2020.05.05.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:56:50 -0700 (PDT)
Date:   Tue, 5 May 2020 11:56:49 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Sean Fu <fxinrong@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Use IS_ERR and PTR_ERR instead of
 PTR_ERR_OR_ZERO.
Message-ID: <20200505155649.GE12217@mtj.thefacebook.com>
References: <20200429021905.10639-1-fxinrong@gmail.com>
 <20200429040413.13942-1-fxinrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429040413.13942-1-fxinrong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:04:13PM +0800, Sean Fu wrote:
> Replace inline function PTR_ERR_OR_ZERO with IS_ERR and PTR_ERR to
> remove redundant parameter definitions and checks.
> Reduce code size.
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   47510	   5979	    840	  54329	   d439	kernel/workqueue.o
> After:
>    text	   data	    bss	    dec	    hex	filename
>   47474	   5979	    840	  54293	   d415	kernel/workqueue.o
> 
> Signed-off-by: Sean Fu <fxinrong@gmail.com>

Applied to wq/for-5.8.

Thanks.

-- 
tejun
