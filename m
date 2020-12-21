Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4042DFFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLUSaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgLUSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:30:07 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E7C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:29:27 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id m145so2451307vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ELvVP/n7i2Ng8CC0EnLp4ayJVNwTBu02YrgJ6HOBfI=;
        b=Tug0cZ8xodGcLA6XrK1J62WOD0AFD+2EYA9zmnHmG9EqNzovb17oRPYvt+RvXtKgMy
         tzOCS/sQ4cIovEVeGeeeEnu8cL9ynAAg2/hn7tF9BwSlcdimIr6HlCeCBWMy/XHUEad4
         pO9Q06bNGwS32LRqcLYmEvMRO87k8JHjeClA8pDqVoEDE+vil/liKF6DLBG925YCRNSJ
         miZ8BiHQQZXoRe/OAAMonIBs6iJ1WXX1WX8fjIOr2zIDu2VPLZbOb8F7+eeOXuaFKQXv
         QinAiLF9b2BlEUu8FJJu96RHnLb3mFi1Nwk8fZ9czlzmwp36g85DwYS3fVVshBbiHDr3
         No/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6ELvVP/n7i2Ng8CC0EnLp4ayJVNwTBu02YrgJ6HOBfI=;
        b=ejCp5TEcvhfsHqUxVDcgoushyBhmbZmWQg34Rgfbj83n6PzkYJVUEQ8rn29b4EwcNz
         csRVHmUCrKm8m64pM+yRq7oxP2MpRIWcGL9gjxT02tAKUy9T5KrGBZXjNgTgxmqvRbLS
         l6tzW381TLAsCfPAW7wQvWXCluoCehaTFd5qOq5T2GU5SDsrDLWAzOnD9ErTgCEvOGnK
         KKp1P01mLi+a22UOnFA2IGhws0YnqOzeX3bTOWgbm0aRW8tSA6yQQlcqY+p0jgOZ3pqw
         o7F8xGqhOpjRHbsdFL1O4sy0I8GABuf2ZS2mqAHTUidA6OLEx5mncmo0wrJfU2jncaDx
         yoSw==
X-Gm-Message-State: AOAM533cgNlu36A/QNvkr9MApvgJFbtYRiHn2bzdfsVyGXEdt7jwCCu/
        YYl47Z6DMlyXcVeSabk7GvqXeX5YgvU=
X-Google-Smtp-Source: ABdhPJxRZ43tgS5mMc74Xg3iU6JsNHFSQnk7OKCTSgQ4piFfUEKfnH5s904NdbY8+9sahMeYSmWglg==
X-Received: by 2002:aa7:8708:0:b029:19e:924:345a with SMTP id b8-20020aa787080000b029019e0924345amr16127731pfo.54.1608568908259;
        Mon, 21 Dec 2020 08:41:48 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id s10sm17234713pgg.76.2020.12.21.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:41:47 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Dec 2020 08:41:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: replace if (cond) BUG() with BUG_ON()
Message-ID: <X+DQSQMzXCvty6bW@google.com>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 11:26:25AM +0800, Alex Shi wrote:
> coccinelle reports some warning:
> WARNING: Use BUG_ON instead of if condition followed by BUG.
> 
> It could be fixed by BUG_ON().
> 
> Reported-by: abaci@linux.alibaba.com
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
