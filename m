Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512932D9E54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502508AbgLNR5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502252AbgLNR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:57:26 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B5EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:56:45 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id w13so32374707lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n/xl4by6+eYZFV8jX1Ip9klc0UXtRF7DjSdo0OyWa/w=;
        b=hP9aflRoAJ61k2p4avc/qYNUA2xAkRKfYdFRCKKTiXdM2FNBxQS6nOfc4VWxBxSbv4
         A8bk5sgKX76NK34bp52OYxtvMC0dwnc+ISbEBr4QVbVWpW2cSisxRRmZ1j6b8xlCQZwb
         GVnK/5ZrzoRmldqy7DGTSoLdYHONXoe6FoEYbPInGSLeuIhoIVMcOYtdfAyrN1WLxVIR
         8iaYwB0s6vxUGOV9Akh4TfobmGlkjuFClzXlvfyz/gx7Lg0FJRn4LRu/I+q4K9jrkXWT
         B29HcliA0o05YSv9l9xb+3IJdYOAAzFjXplv36NTrSr+YwtYtLUkvloUIZC+xh2C0YqS
         UKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/xl4by6+eYZFV8jX1Ip9klc0UXtRF7DjSdo0OyWa/w=;
        b=kMe9r5DcQ3nG1lYahh3hv2i8uNHhMomuh0sN2CXSMR4nUAdWOEdUdV1jgxxe1UxNep
         jAa7QCUYh4Wa3tXTE77JNsbKUJkrHE+zFY5CZjWrU2RGLlBM702hZHcvzk+sCFJ2mj1O
         mzGMPIQg4gNmUssejcXknQA4UKmhh1kDB2XXH9pDACcAO/Y6FOTsLD81j+BoHKzSwKUF
         5ov/6jHBx8t6L55uozHlFemoepalJQSo5vkQkC8yIabcktEFrAgh3SQ1HSfw5PZglCGM
         ouHsXYj3CJTV3RuCk7LhoFUqWHoyuD+o/N/gE5fYUvGchppxRjNahHW5X6wygq5DH/jv
         /y3Q==
X-Gm-Message-State: AOAM532QyjjNlhRl5ai9WPw5i4M1xP2zJbr9xIQ0TvavNXsMqDOj06AD
        qyuzfCobFGDd73xazgFsXxk=
X-Google-Smtp-Source: ABdhPJzRsjXCHsoBhA0/V84jQrcsqboEiVjrUBPEahPtLUl6Nc2PWaWTtx/pi12wRoGzAJpdn+3jog==
X-Received: by 2002:a05:651c:101:: with SMTP id a1mr8855332ljb.277.1607968603168;
        Mon, 14 Dec 2020 09:56:43 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id b5sm2180283lfg.13.2020.12.14.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:56:42 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 14 Dec 2020 18:56:40 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
Message-ID: <20201214175640.GA20756@pc638.lan>
References: <20201213180843.16938-1-longman@redhat.com>
 <20201213183936.GA20007@pc636>
 <20201213215134.GI2443@casper.infradead.org>
 <20201214151128.GA2094@pc638.lan>
 <20201214153746.GK2443@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214153746.GK2443@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 03:37:46PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 14, 2020 at 04:11:28PM +0100, Uladzislau Rezki wrote:
> > On Sun, Dec 13, 2020 at 09:51:34PM +0000, Matthew Wilcox wrote:
> > > If we need to iterate the list efficiently, i'd suggest getting rid of
> > > the list and using an xarray instead.  maybe a maple tree, once that code
> > > is better exercised.
> >
> > Not really efficiently. We need just a full scan of it propagating the
> > information about mapped and un-purged areas to user space applications.
> > 
> > For example RCU-safe list is what we need, IMHO. From the other hand i
> > am not sure if xarray is RCU safe in a context of concurrent removing/adding
> > an element(xa_remove()/xa_insert()) and scanning like xa_for_each_XXX().
> 
> It's as RCU safe as an RCU-safe list.  Specifically, it guarantees:
> 
>  - If an element is present at all times between the start and the
>    end of the iteration, it will appear in the iteration.
>  - No element will appear more than once.
>  - No element will appear in the iteration that was never present.
>  - The iteration will terminate.
> 
> If an element is added or removed between the start and end of the
> iteration, it may or may not appear.  Causality is not guaranteed (eg
> if modification A is made before modification B, modification B may
> be reflected in the iteration while modification A is not).
>
Thank you for information! To make use of xarray it would require a migration
from our current vmap_area_root RB-tree to xaarray. It probably makes sense   
if there are performance benefits of such migration work. Apparently running
the vmalloc benchmark shows a quite big degrade:

# X-array
urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=31 single_cpu_test=1
Run the test with following parameters: run_test_mask=31 single_cpu_test=1
Done.
Check the kernel ring buffer to see the summary.

real    0m18.928s
user    0m0.017s
sys     0m0.004s
urezki@pc638:~$
[   90.103768] Summary: fix_size_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 1275773 usec
[   90.103771] Summary: full_fit_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 1439371 usec
[   90.103772] Summary: long_busy_list_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 9138051 usec
[   90.103773] Summary: random_size_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 4821400 usec
[   90.103774] Summary: fix_align_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 2181207 usec
[   90.103775] All test took CPU0=69774784667 cycles

# RB-tree
urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=31 single_cpu_test=1
Run the test with following parameters: run_test_mask=31 single_cpu_test=1
Done.
Check the kernel ring buffer to see the summary.

real    0m13.975s
user    0m0.013s
sys     0m0.010s
urezki@pc638:~$ 
[   26.633372] Summary: fix_size_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 429836 usec
[   26.633375] Summary: full_fit_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 566042 usec
[   26.633377] Summary: long_busy_list_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 7663974 usec
[   26.633378] Summary: random_size_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 3853388 usec
[   26.633379] Summary: fix_align_alloc_test passed: 1 failed: 0 repeat: 1 loops: 1000000 avg: 1370097 usec
[   26.633380] All test took CPU0=51370095742 cycles

I suspect xa_load() does provide O(log(n)) search time?

--
Vlad Rezki
