Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529F2CE14F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgLCWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgLCWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:05:08 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1718C061A54
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:04:21 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id l10so906039oom.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4YCLxQL4vZEXb1u6jH6YjMbpDto6nNiHo0QnmRk7W9k=;
        b=VLH8hevNwNB8U/fmW2bxkA8b2+H+e2QrxYo/ka2+x6h/D4O1qDXlEl0m8t/G7/7DIL
         ctg6ukbw8rnndQoGFSGwC0WhNQyBwtCv5ak3gYkAYev0CkS1VaUiQ3azsRSSSel+KyKP
         fY8hIOIYsNpsGGUOkwLu02BdZyxtDprxf2WTVFsQT5TAgbZ6vrfR9zQEd/F/GU1aVuOP
         EvoPMpCrjwQpj7Gb5ejNvKy99gicaWJX3jaMEE66phljmsBjWyTM3t0PHJlH7DNo6S4W
         pDnH+7nLsF3GH5/7JPfxPDDQh4gCaOupMz39ZPNKuH60+3Vg8NnHXb8HdavrFFsS+B6k
         vRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4YCLxQL4vZEXb1u6jH6YjMbpDto6nNiHo0QnmRk7W9k=;
        b=XDhASCiaIxSJUBpYaLanRqaTAf6319KPSMPka/VrAu3HEby99cS/xXqRaa+9g8A9HJ
         od4TuPcy6BoUUqIays17PU9hssDpo41ZeZKNKuPZRAYzuoU9Wx50na7a17ZvN8eettTm
         cp1QaIWkq3RHt4YqMsIjSTE3Gg7iJSKaGaP9HUyLdkaekr7fvkksNvuwTW1J95K79zaO
         zZ+ZYP36/JuPfFCOc7aHJZmxDru+wsEuR720p0mYRQYBkREmDKV/UFcE0E/TL7Eq6j8q
         9Hi8Hj8ftbWbyXg2nQA2xY6dTGcuSve7kisKEnhCbIJtT6nD4wh1JCo4RYjxD6vsIvmk
         RMww==
X-Gm-Message-State: AOAM533IIfie+t9iyAKhCRUMAaI3yqCYw1/YN05p3NAY/GkG6gKD8eOq
        NlaVxQZSu6cCf6CJrlnXvnUraw==
X-Google-Smtp-Source: ABdhPJxB2NFOv6D3zsYFN6XwPNVyyjM2gNw86QtwdEDwQiaWnibkXM4bneaneATEQYleZoku8pxBxg==
X-Received: by 2002:a4a:dc49:: with SMTP id q9mr1018936oov.85.1607033060919;
        Thu, 03 Dec 2020 14:04:20 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 186sm204276oof.16.2020.12.03.14.04.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2020 14:04:19 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:04:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
cc:     m.szyprowski@samsung.com, qcai@redhat.com, dchinner@redhat.com,
        hannes@cmpxchg.org, hch@lst.de, hughd@google.com, jack@suse.cz,
        kirill.shutemov@linux.intel.com, mm-commits@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, william.kucharski@oracle.com,
        willy@infradead.org, yang.shi@linux.alibaba.com
Subject: Re: + mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch
 added to -mm tree
In-Reply-To: <20201126054713.GmEiU5MZ_%akpm@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2012031348120.12944@eggly.anvils>
References: <20201126054713.GmEiU5MZ_%akpm@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: mm-truncateshmem-handle-truncates-that-split-thps-fix-fix
> has been added to the -mm tree.  Its filename is
>      mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch

Andrew, Stephen,

This lot is proving to be a work in progress,
the current state breaks booting on 32-bit, livelocks trinity,
and breaks shmem in more ways than I can quickly explain.
Please revert (in reverse order):

mm-truncateshmem-handle-truncates-that-split-thps.patch
mm-truncateshmem-handle-truncates-that-split-thps-fix.patch
mm-truncateshmem-handle-truncates-that-split-thps-fix-fix.patch
mm-filemap-return-only-head-pages-from-find_get_entries.patch

(I don't think there's any problem with that last patch, but
assume that it relies on ..split-thpfs.patch being in already.)

Thanks,
Hugh
