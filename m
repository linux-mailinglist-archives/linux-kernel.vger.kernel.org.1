Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE03129EDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgJ2ODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJ2OCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:02:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82BC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:02:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so3540798ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7lEvOV/HbcXu0PIxvGw2SLLt11jclvnvIAXpPg76WxU=;
        b=rSU47uiN+XY2DRlhPzcq7v3YHqplBYOB704H2vL/6EQS4gR1nu2YF0tQlpFXM42713
         yrahp6CxpAQIS8TroyeGlfDKA/pr43mbGZP9oDd5M6l+D/oAqhYPBYXjXrrENK692Arp
         bnWtQ6za577s/l7Q5EnfMS5ZqHUJGgec+jX1GHu3KXuVe1wF/TUg56hZvEjzlMznn7yp
         +TQXPOZExcoFGZSHf/DmCHrgf2QoYaQ3XEQMunoriLbnJydl+ePxI2MHyRETfRoOiRxn
         /iWEftMTCrfnResNfZnGKtPARBxXPEMrQdrejIfFHSnF9dGNMJF33nSuTu+G4qLqSscq
         udoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7lEvOV/HbcXu0PIxvGw2SLLt11jclvnvIAXpPg76WxU=;
        b=ufQRHR7A/MbGxdwbg6P/yP/wxD43kLh6nvVtSPG4fIY4gZwIVVcpQuqLQqG13AGtMr
         JQK5zkLCDuzZlC9QxsIr3ublErtsWWHUzwTQJXjH8gPIHmGg2iYKKRT6IfJjso+yJ6Eh
         Bchg9tpKU/G+WS0371CY8MSGIPPznv1mUJzjl+TU06nayvRlLoMs5Duyi62PiRN7SQge
         93VwUiaFFGttJYftTalDbi5zifk+9+zmry4Ijo66tlWTzMekIJ+3P1JTV3/U34cH48yi
         P+lyaqJQQHBllgxKj88vm4TXwi6bK8R29c60kNAqXzOvK/JiUv1KuW5OOvRrfmwdTLu8
         cy+A==
X-Gm-Message-State: AOAM530ECqwNOOMlpraUS42tzxQlpLNWCi8q94n82wDi9BZp1e6niFwc
        BOdz8P933NY1Cs4qqWt7JGBinQ==
X-Google-Smtp-Source: ABdhPJya/H8X75lH17Bg09izCpK/ATiN2lerZxEU0QS+HfbvG2/ezU47Y8rna+vH9/OZd1gnxxAOMw==
X-Received: by 2002:a02:c952:: with SMTP id u18mr3567152jao.139.1603980124869;
        Thu, 29 Oct 2020 07:02:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id l4sm2128970ioj.41.2020.10.29.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:02:03 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:00:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Subject: Re: [PATCH v20 05/20] mm/thp: Simplify lru_add_page_tail()
Message-ID: <20201029140020.GF599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-6-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1603968305-8026-6-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:50PM +0800, Alex Shi wrote:
> Simplify lru_add_page_tail(), there are actually only two cases possible:
> split_huge_page_to_list(), with list supplied and head isolated from lru
> by its caller; or split_huge_page(), with NULL list and head on lru -
> because when head is racily isolated from lru, the isolator's reference
> will stop the split from getting any further than its page_ref_freeze().
> 
> So decide between the two cases by "list", but add VM_WARN_ON()s to
> verify that they match our lru expectations.
> 
> [Hugh Dickins: rewrite commit log]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Mika Penttilä <mika.penttila@nextfour.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
