Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803F12FF956
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbhAVAUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhAVAUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:20:06 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:19:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq1so2688345pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YgRLzR8Yh3ek6+gQaBwYODzkqTl3oflQWDK0M++F9ug=;
        b=TR3dU+rfpeRY/horkoiqCndqMMncc8oT3QWlZfehrai9O6rInUY9l6iscX+Ze5RdCR
         Ibbmux+TzqRJu4XzYcEsxyX1cF4YyXOUcyDKk039HKy7Z45TCIFGNT/zHBCJ4d0Fzua7
         z62NQCtA90B/9ApTMdb7d8z+5tsBNP0LfZhd4awAKvBWKnawv5zXaQR22HKC803OU/XF
         iNWB63hEh/7dZOz6e8xO1/hk4aitY1C4HQVWD2EAr/pR1pWC7Hh6iaOerb6Rc0DHhC75
         3DSicXr7ck3VL9f6v9eYlkp8oeoWV6TyG4/LEQ9fe8nzPRKZxj2OkKUZiQt6JD2zmeA/
         +5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YgRLzR8Yh3ek6+gQaBwYODzkqTl3oflQWDK0M++F9ug=;
        b=FS201gYXMmI597MrXc0HZJmrEW1ei+gzpglpinn3y4p8ItpwaHu5nOYTlMSQdURp5D
         SxW3vgLBqsc7n82L1vOev03glBZLDffJiVKgVqXpMlK74jJqhF7YfhKRViiyFZIeeXuB
         4GtEdifOhkmlPV6iKBJDjhS8KLXBqVVeVwGeZxb6bxfyTdbNsBhakvtwW3k2TN7QPaDW
         d3VgGFIoFb2LD4Py4EeBOmY4GbZeBmkFgbWN8IWEKo2pnslzbAr4PNi2VIX7tCpvvdtr
         2JDmswHr0Ja4cCO6td+5B9s33npqe3ChDvSxR7zBC6CwF4f14iH7KRsmLbQSVVSFqVSi
         IJYg==
X-Gm-Message-State: AOAM5339N6pq5bReWevfKqgCTDnRZG0ZJ9sqSLcIUN1u77nEiXvq8a2/
        ql0iaTMyeZO/PGNoJUHOcJ4=
X-Google-Smtp-Source: ABdhPJxJDQVa82L2EkVDtQ9Nha5fEFq0tOFK18ZUqO6n9AEzV/3N3bkjNwi2PVoqQFSya6f23YHKcA==
X-Received: by 2002:a17:90a:31cb:: with SMTP id j11mr2260753pjf.6.1611274765792;
        Thu, 21 Jan 2021 16:19:25 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2144:1799:e940:1da6])
        by smtp.gmail.com with ESMTPSA id y12sm6785415pfp.166.2021.01.21.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 16:19:24 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 21 Jan 2021 16:19:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     vjitta@codeaurora.org
Cc:     glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, ylal@codeaurora.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH v5 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
Message-ID: <YAoaCqvRHILKp3w6@google.com>
References: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610963802-11042-1-git-send-email-vjitta@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:26:41PM +0530, vjitta@codeaurora.org wrote:
> From: Yogesh Lal <ylal@codeaurora.org>
> 
> Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.
> 
> Aim is to have configurable value for  STACK_HASH_SIZE,
> so depend on use case one can configure it.
> 
> One example is of Page Owner, default value of
> STACK_HASH_SIZE lead stack depot to consume 8MB of static memory.
> Making it configurable and use lower value helps to enable features like
> CONFIG_PAGE_OWNER without any significant overhead.

The description could be improved to prevent confusing.
CONFIG_PAGE_OWNER works only if page_owner=on via kernel parameter
on CONFIG_PAGE_OWNER configured system.
Thus, unless admin enable it via command line option, the stackdepot
will just waste 8M memory without any customer.

> 
> Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
Reviewed-by: Minchan Kim <minchan@kernel.org>
