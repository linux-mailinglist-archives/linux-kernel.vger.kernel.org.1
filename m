Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA132A82BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgKEPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKEPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:55:18 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8FDC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:55:18 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a65so1561200qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A3JA9WEFpRuCAbhY2DBNk/bNA/HrXMr9AT46oTgaBJc=;
        b=iE2JW9bLmeyDb8+yOQGwPSMgBWXGejaZMqGA4cvyWkomZy8WrhWPWjVl/6AlmObyKl
         iUvEVobpJggmpeNwPzM0+B4lsSQYI0RGUFGlU+GaKYmNYjeL7RlgXRaOU5vu7BpLmKLz
         b6d5uerULC4QbQ4GTFrYFH9vVziu7NUf2IOv/Gqw+8Yi0bHtTQ2zd7xuJsn5ieVGqJ2/
         8bSXkOZyKtBcrYstoI8nMWWG9zuCuNjvIPHMT/g+lWlruh+BRNpQUCAGXi18LnRPKpgz
         W1KIdVcHHWs2RqTY3NHosrKq8wStbQjj0A16XDgRpYAQMnPZifnI/1QB6PdcMzllpXjs
         ruhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3JA9WEFpRuCAbhY2DBNk/bNA/HrXMr9AT46oTgaBJc=;
        b=fB5QDGyKKl4Vezf/CTXV2y9LUg8WcKhsoZ6JffFJ58MhtzgTWgnS978xRRLNFuJuQq
         h7b6NcSttcDpveMFod+FMfKOyVRpv9KbNaflNh6UiMGXgVyMuHYKzhaGohneBqrPmhF7
         sCSy6/qHMphCw+1FynAWs4/YObVVKsVL0dduxHx0LeIEkc3eqBlpgqdKtqti1GxM2rjK
         H6qF5Ox7H/TGKlk53TyshfVcZN0G7R2dYegI4eK6GIz9TOOimUG+cT6TgK7nPuPMMfVO
         Lx1LlFGfyKLu1FWHZOF74yR7c09WIayIsbE2Oj+0tgTQIwcFeQR2UNQqIqpZk0VnBXiL
         BOgw==
X-Gm-Message-State: AOAM533J3i0aI9UD03+6ebo2FiZ7M/o+psvGjN6lQmLihP4bUWPLkZh9
        QLglywqC9JGDkOC2G3yllzpZ/g==
X-Google-Smtp-Source: ABdhPJwcraIqbJ3b5alyPraU5Bj9UQ/pjTE9hZ55uU+SAxXYsxTVO0mKKnn9bGpqnpigK5ac/u/Spw==
X-Received: by 2002:a37:4ca:: with SMTP id 193mr2715271qke.346.1604591717689;
        Thu, 05 Nov 2020 07:55:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc05])
        by smtp.gmail.com with ESMTPSA id k15sm1133883qtq.11.2020.11.05.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:55:16 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:53:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hui Su <sh_def@163.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201105155331.GE744831@cmpxchg.org>
References: <20201104142516.GA106571@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104142516.GA106571@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:25:16PM +0800, Hui Su wrote:
> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
> 
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
