Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6119228F8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbgJOSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgJOSvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:51:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE55C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:51:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l18so2491566pgg.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4dzZ3wB+/l9v42S9FN6kIPBfKLyAk8Xfq7l5iS5T6+U=;
        b=Vagho1/6kZJ5F1IOg3Y4OF0QZJsHQMNh5YIf9Cdbp2aOm1Ore4x2Ka5X0Yq9RsAv9r
         k8RuBx32AHpVu9Ewd9TmzKeuzJy4LVbFQYuFX9FdbjXgiFoYSpJR1+KxeBPrssNy6s3e
         HiitC5SXUvhBF8qjcC46vAjm5Bti+Y4cFzGLRy7rG126uqSXV/uLuO0LFTz5RUCI4XSS
         rvf3rxE+bycYFJqAzAo9RFdPGuoN1XCBE5OyKRBD1Ym0FozcUalL9pYFbSdYoyCoAOcj
         NptAvBE5mGGxad8L8M+jzGedzDO229fKmpk6J/nAoAADz9tPLT4d3g51/OnX5bok92yM
         hEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4dzZ3wB+/l9v42S9FN6kIPBfKLyAk8Xfq7l5iS5T6+U=;
        b=BqCX+9VtQA6ISuzy7BKe2jopvoWSl3lJ971R0nMlyInEoiWfxCl3KbMrBoUMAstTJ/
         gTDqDGuTv3u4tDp0DFyh8LVTR6qczpRlp5qfn/Py7ImPrmRifWS2L5BgG547B3/cCj7X
         KCGADyzhHZRNDkPo6lkVIWCNjLBN+HcRymOF9Hea46qCXCWWOiiWGNQgQM0L/SgTQXWM
         fbkn0QB4t4eNdVMugrrsRXp67sBFLek84YiF4OBNOYtmdg9eKLFZvA3S1ldppsOHUVK6
         7VaUAhhN8F9xMECZAhaHIG+eTNJcDYF1pOilKq+ujd8PZcGTQZMaqQhs/t8L8r2jShiP
         KCNA==
X-Gm-Message-State: AOAM533012fTHNvcCpDUSUoXbIEYiomTHtfIV4UMExyAihrd//580cfU
        rboznWuoxHNkQKbDQFQECxKOfv40JLE=
X-Google-Smtp-Source: ABdhPJyA8p7L530bJJxMOtHScL/lhtNd9K6Vg5quDuN3Jw+RAF2xcqhlHPJTWmdm097qSiJ+fJvxzQ==
X-Received: by 2002:a62:d0c1:0:b029:155:2e17:ea0 with SMTP id p184-20020a62d0c10000b02901552e170ea0mr6529pfg.55.1602787883143;
        Thu, 15 Oct 2020 11:51:23 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id c12sm8083pgd.57.2020.10.15.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:51:22 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 15 Oct 2020 11:51:20 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     <akpm@linux-foundation.org>, <ngupta@vflare.org>,
        <sergey.senozhatsky.work@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zsmalloc: Rework the list_add code in insert_zspage()
Message-ID: <20201015185120.GB181691@google.com>
References: <20201015130107.65195-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015130107.65195-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:01:07AM -0400, Miaohe Lin wrote:
> Rework the list_add code to make it more readable and simplicity.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Minchan Kim <minchan@kernel.org>
