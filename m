Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86912E6A41
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgL1TGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgL1TGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:06:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB79C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:05:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t6so6056119plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nNHgMYMSl1T1flIbEXTrRstXDK+xUu5CMiBZATNaKPI=;
        b=CPMj2KmdkJkjGvpQOSyTJDZ+0plrJ139rHCKFOjONnG814XwSSDH5pcQBjaB848SMk
         CVbMQW4f5PHESVVUZFLUY1EdrrPb4onL90ofKQ2r2JUHJWAc4CjjEZyp5ZDUlnLDmfW/
         9UWxDtvgavlRcbwfx41v45yh5V3obJLogopQoOiSjsVZ42r19Z9Ts9peVht+5+voeuGV
         1a+9AKz45czhENI1lVPojjYUMYfgC4ffMw8einans7Gisd0Ael8fgTd0a4CpFX4osx+G
         Y4yEOqTuGuA+lCCV3sncPbRzRshc49XC8dLOTZG1JDpLC9jc8e1a52ewIpWNKegahAJf
         wqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nNHgMYMSl1T1flIbEXTrRstXDK+xUu5CMiBZATNaKPI=;
        b=GZiLyXrXEwWcUwO6rtKvZjBDe7hqxyfnTAkx66//0F+V/6hXctPiSwjLrxXctQdLAh
         xftNLyiAqIatusC2+aqTCQiaFiwI8YavDUF8jV3i8U/GS4HzbXCTqgqVUnQdpz7irJ3t
         ELSVLzeDvRoBEem+nxAxnr87Gs2d+JSZMxFUwTrSgjkj+wZLm9HhtnYOLslzNGfRSC29
         vOub246G441mUDjpMzlV+eMXZnSAxG4NoenPIVIiGDkB1DKMM2sqs9k3ycDMi8HUXPsY
         +ABQsRzR30ewIvGuIiQiJTmvWU4HfONPAFNicT1L8G0hVrrf6rgo0ZeCCmBg5nXM7fhv
         FBaA==
X-Gm-Message-State: AOAM530nJsEUI2C7w9me26HpfXZM3ohEi9v7qxqWXVL7+H8EdNrAIGYB
        BKnsilknktI4XdmKc0LUkoZ3bg==
X-Google-Smtp-Source: ABdhPJwXQBU9nA1t1lenYtgEIGoGje36pRidoFolj1KhQv+2XQaYmSGQEcyADwrS7Gwmo8lW0VsCAQ==
X-Received: by 2002:a17:902:c195:b029:db:c725:24d1 with SMTP id d21-20020a170902c195b02900dbc72524d1mr45910150pld.28.1609182354783;
        Mon, 28 Dec 2020 11:05:54 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id o129sm35262730pfg.66.2020.12.28.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:05:53 -0800 (PST)
Date:   Mon, 28 Dec 2020 11:05:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Jann Horn <jannh@google.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slub: Consider rest of partial list if acquire_slab()
 fails
In-Reply-To: <20201228130853.1871516-1-jannh@google.com>
Message-ID: <9b9ef131-d563-3987-88a1-1962477b2894@google.com>
References: <20201228130853.1871516-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020, Jann Horn wrote:

> acquire_slab() fails if there is contention on the freelist of the page
> (probably because some other CPU is concurrently freeing an object from the
> page). In that case, it might make sense to look for a different page
> (since there might be more remote frees to the page from other CPUs, and we
> don't want contention on struct page).
> 
> However, the current code accidentally stops looking at the partial list
> completely in that case. Especially on kernels without CONFIG_NUMA set,
> this means that get_partial() fails and new_slab_objects() falls back to
> new_slab(), allocating new pages. This could lead to an unnecessary
> increase in memory fragmentation.
> 
> Fixes: 7ced37197196 ("slub: Acquire_slab() avoid loop")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: David Rientjes <rientjes@google.com>

Indeed, it looks like commit 7ced37197196 ("slub: Acquire_slab() avoid 
loop") stopped the iteration prematurely.
