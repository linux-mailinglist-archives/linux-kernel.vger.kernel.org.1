Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F234D28F8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgJOSso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgJOSso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:48:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE607C061755;
        Thu, 15 Oct 2020 11:48:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c6so2091900plr.9;
        Thu, 15 Oct 2020 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ggw3I3pAynGZgxB+jlnK76lpD++hJM0MLWyGtUL7d20=;
        b=oJ4C3bwpBD0qOgcpxlqBF7rs3447We2XBaam2CDdVM7ASljXHA9Y6eyySbcrSHEEop
         ugQxo65cA0/YnFAUJlHvKsh3OJ+ZkLFwNWcdKwpK7qH2JEy8BRI5jnS5ShpKGRp5z9OG
         QLUnpiramNrxuxcLR9suBU47BM/kjJiu83lp4XOVm1uOeIu8WI9NfH15ggAyoilw45G6
         L2R9EAT9fzusxiD2DxCV78GWrl0UcLfzb1bqnH5ijsXyjZ8N+BdNhlh2Uv8yz3qBbfGr
         nctWvcJHFJRwWBAQ5P9iHi6kUB759tRSHVR/i+H9vsLbHjjA+oQew3seOCTpuKH/A2Sf
         hiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ggw3I3pAynGZgxB+jlnK76lpD++hJM0MLWyGtUL7d20=;
        b=d+jiAE4/6VTE7zNQ6C76Yd3uPkwWEO7fHm12hTzShnRtlV4F0gUXWoRI9Ad+AqC2UA
         Hg5qtVHJUdePcT5wgEsmOXt+4vZTEnMnunhQzvYdMpdAIc/XNXQ80mwqhzIbUyqk5Dvp
         NyxiQCb3THEpspk9vJkQqA6Za+7ynYa7zI+7d4ui96umEk6rGCO4olzMTBKNdI1pqCtD
         Uq3H3wURLBxCQDyXRnVwWOhv4Kl49CpGRRwMFxjT+n7QBlPodQZVO+aHhNqvWFWP13uB
         77cRS3ac57uRGyWiDr6/G74MeiH3+NsLYpieFfhia43Ie+PSsC0hQvG8xWZSMY+XEZBv
         u8VA==
X-Gm-Message-State: AOAM531nyrtDktnwR6tItlVC7Xlm6H6ICMBdByOG1vqielzk44E8cEaR
        xhPchxKTgMpiiI7xebFo3us=
X-Google-Smtp-Source: ABdhPJy7lMQDrU/UXhqFoaHHLUjKN6vCPXC2gDHjCG6rUmQ9qUGSVEopO+cluDuMIWo14qlAsrPkpw==
X-Received: by 2002:a17:902:d909:b029:d3:d52c:b98b with SMTP id c9-20020a170902d909b02900d3d52cb98bmr116513plz.54.1602787723434;
        Thu, 15 Oct 2020 11:48:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id x1sm5187pjj.25.2020.10.15.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:48:41 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 15 Oct 2020 11:48:39 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: Re: [PATCH v4] zram: add restriction on dynamic zram device creation
Message-ID: <20201015184839.GA181691@google.com>
References: <1602482640-48978-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602482640-48978-1-git-send-email-wang.yi59@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:04:00PM +0800, Yi Wang wrote:
> From: zhanglin <zhang.lin16@zte.com.cn>
> 
> Add max_num_devices to limit dynamic zram device creation to prevent
>  potential OOM
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Acked-by: Minchan Kim <minchan@kernel.org>
