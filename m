Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C6E2A82F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgKEQDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:03:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFDEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:03:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b18so1604920qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8sMzOkuVIKSSynXxhymn5UNvyr2Xt2G2oYLu65q+w0=;
        b=o6eQCtymAbLJ9k8MEolD6+v4cJheRMpNSLY/KM9ynEo1dkyFF8ujnDK/UiiIwxg101
         I11o04f0LoZgCqasTnyOADdN6Ex9PtUfh5GEHaDWJWoU/x5Y5I+k05MRX8gmGfjDw3Al
         AfCtocIdzeWKNWWvocWyhm5kS2s7roEUGpX10nYQiPyj1xxi2Gn6AaUeTEnk4wb+hjyp
         zC3kgsH12qYoLCFCqhqa42BGspBJISTBB5haijzoRk0gtCUUonJZKcyw5bxDWngGvGqv
         5OA/AGzbpgRMkjDqrwVTcbG5HBhTehWx1RchRs8TBaa+NajucjybummSft2/CMEZj4hU
         HQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8sMzOkuVIKSSynXxhymn5UNvyr2Xt2G2oYLu65q+w0=;
        b=pvswge1g66LmpcXlVpX9WRpqhSfxdlW1WNJErwO2d4bpnSYzFlyl7Tr4xwEwPyYiRf
         kGsbWCQXzCDD+J2rQ3/gV4Rt1JML4oJsaSjIvsjASBVSeVqHmp1TZCaKkFdYkWCLkVd6
         hCpSteekdEp4APw5M+p0vSVNrWNWAPGKkgRURjOcYMPwEbAN9UV4qVFy5y+tfFG4iCXX
         UvxU/R8xHq9YYT56X2W5qGRFtT5ZZMs4JvnHcNCsJM+SRwIG3fVBV4WUpB62YgIOuOPh
         7GnKHsA5rB8CHk+0eqRVLyQzqoN/U1pazVoKG856Rplb/kIxdRHydA/nSJBkv1u4jZdK
         K8wg==
X-Gm-Message-State: AOAM5310KNe2cxcCWZi2Tn5m/1cJYcrhXRrYDMSx73cqhlNB8ncPiKOP
        MAuCgoz9VRK1IFyFkuJObO24HA==
X-Google-Smtp-Source: ABdhPJy/MHkUw7vIpAC/f5YRU6V+AJHo7ERjGFnF2pRn8BKOyYjV9tec9pYIvMNQtaoawZEqN+aaeQ==
X-Received: by 2002:a37:7e82:: with SMTP id z124mr2674936qkc.107.1604592201652;
        Thu, 05 Nov 2020 08:03:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc05])
        by smtp.gmail.com with ESMTPSA id w45sm1187599qtw.96.2020.11.05.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:03:20 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:01:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: always do TTU_IGNORE_ACCESS
Message-ID: <20201105160135.GF744831@cmpxchg.org>
References: <20201104231928.1494083-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104231928.1494083-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:19:28PM -0800, Shakeel Butt wrote:
> Since the commit 369ea8242c0f ("mm/rmap: update to new mmu_notifier
> semantic v2"), the code to check the secondary MMU's page table access
> bit is broken for !(TTU_IGNORE_ACCESS) because the page is unmapped from
> the secondary MMU's page table before the check. More specifically for
> those secondary MMUs which unmap the memory in
> mmu_notifier_invalidate_range_start() like kvm.
> 
> However memory reclaim is the only user of !(TTU_IGNORE_ACCESS) or the
> absence of TTU_IGNORE_ACCESS and it explicitly performs the page table
> access check before trying to unmap the page. So, at worst the reclaim
> will miss accesses in a very short window if we remove page table access
> check in unmapping code.

We also miss accesses that happen right after the unmap :-) Seems
completely fine to make page_referenced() the time of last call.

> There is an unintented consequence of !(TTU_IGNORE_ACCESS) for the memcg
> reclaim. From memcg reclaim the page_referenced() only account the
> accesses from the processes which are in the same memcg of the target
> page but the unmapping code is considering accesses from all the
> processes, so, decreasing the effectiveness of memcg reclaim.
> 
> The simplest solution is to always assume TTU_IGNORE_ACCESS in unmapping
> code.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
