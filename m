Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D138D2D6C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbgLJXs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389435AbgLJXrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:47:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22975C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:46:57 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id v29so5799357pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=w62UaTHJLS+mblskAiHfL/RNuF/h3TtiJ3G/QJC1Q/k=;
        b=AfDQzRQtuuI6VnkwDh6ZHqDgcnWpA99zCSIZXsc4++1NxvYd3GAt1Waql4zakPyseD
         3MkjCjq/jc+b4tqDSH3mU7+c7kroTPnLCcnGC+xqwwxwuHC0OaeFXhxdyRM3zHRPox78
         2dyZakhG0xofHTKUpNMW7y6X4sSrls6wv/sn85q4zbxSZSax+MoW37KnU7caSygibQSo
         Z4GmX3GzVep59dYy1sNbk7+rFL2NSGqqAdr0Lyyj4rEiFY/VkqtnnQCjotvdh8pHAUCP
         792FSqtSm+B3uI1h/JfkoPEUtRFoRYT4EtjTno1vGD3cSQk/IE1n1cCTt6qMdI/M64wI
         6Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=w62UaTHJLS+mblskAiHfL/RNuF/h3TtiJ3G/QJC1Q/k=;
        b=e2naAfHa7yOMglubALC+YoAO2E12y7G2iT8Fvk6p5JPvMbw0whKZgST9dW/87Kpm2U
         V5W2vZtXrbu4WQ8D950/FRJcKvwsVr+Prq4J7ROjAytQcULL7XhugPm9fTMMN8dzwueo
         oA8UqeobtRbrZsWFue10kBH92VyzAbE/209uGNLb8WNrocXB+WkFHSy3mr4TpxhNnSPu
         EwCOLBs0Nz3wFmtTJmXLfWX/nAeuaJ9XFi+sSQME5TfUfr50kqI/e4u8VYjQQ+cYSU75
         p9qzkD3jfF0Y2FbGo4/77C54yHV5olOgYG/doovmXtiGglAW3cEznYHHBXkXDYA3uPUs
         Ekyg==
X-Gm-Message-State: AOAM531UFGZYk5CCfmC6CW0kNvXz6h3pdRyM6E489pL+Ty52Okak8SW8
        mIVWz+TkpFdofZE8pU4PbUjOtiLDL/ERLg==
X-Google-Smtp-Source: ABdhPJyoXbsQaBYhneRdviEqrD1XTA+RUq/yp7oHNKys5BzY3M4lMP6otOolWpqr72EtFNqKLsz8zQ==
X-Received: by 2002:a17:90a:cb8d:: with SMTP id a13mr10124105pju.155.1607644016547;
        Thu, 10 Dec 2020 15:46:56 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a31sm1875631pgb.93.2020.12.10.15.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:46:55 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:46:55 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm, slab, slub: clear the slab_cache field when freeing
 page
In-Reply-To: <20201210160020.21562-1-vbabka@suse.cz>
Message-ID: <56e5c740-2eaa-daa5-3df9-369f4d8be34a@google.com>
References: <20201210160020.21562-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020, Vlastimil Babka wrote:

> The page allocator expects that page->mapping is NULL for a page being freed.
> SLAB and SLUB use the slab_cache field which is in union with mapping, but
> before freeing the page, the field is referenced with the "mapping" name when
> set to NULL.
> 
> It's IMHO more correct (albeit functionally the same) to use the slab_cache
> name as that's the field we use in SL*B, and document why we clear it in a
> comment (we don't clear fields such as s_mem or freelist, as page allocator
> doesn't care about those). While using the 'mapping' name would automagically
> keep the code correct if the unions in struct page changed, such changes should
> be done consciously and needed changes evaluated - the comment should help with
> that.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>
