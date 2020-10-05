Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247F7283561
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJEMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgJEMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:07:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80335C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:07:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 184so1881655lfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fYR1Nmn/SpWkgpyX+uei+ZKAH5DyVucsvO+KSbfsU+A=;
        b=JzPQYsYeztLvHWehT5mOujyQmFO+RKC98pQTTUK86iCZTx0iwmgGXMmFoC+WdHDwSI
         hHMTgbULsnIx2OKc/BGWAowEQBDGjHiWwcGCP9M6VrOzh+WZLQGiOfgWN8IDaL+Kow1p
         yJL5ygNjJ4GvVfUBSCERc7bnzQoX8/7BiyWYg82zKH63X1QZjX1Gevr1u6mJG2iqub+w
         ENn3DtTGrbqS13bl0YQcoMonrD2ljqPdT8WQgQ7FHhan6U6V/xiyd9jsIMBCAZnlAnJp
         JaEh/tzXEXoo4P/BgJOaaJmtNMV7HmU6fPH5auX2RPa4GyzsRaRxPVvb/NY2jNXpINoe
         EbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fYR1Nmn/SpWkgpyX+uei+ZKAH5DyVucsvO+KSbfsU+A=;
        b=Q1QZymi6urCOiujoLaRBu5FVTnYemJwrgSii7wOx/2rOcL2/sm35yw4iUwLoj+6ADC
         VSTdv93NP7ZUECcyAmYr9V5+FY+cR6BdSkL5uBEjD3zqvs9Po+cuc9QDyrB0BgjH6YwW
         eWzENPOfo5QRsPb7f7XfSG4rdlkAoBQczdULpY7RKneR+7iQgeNNIZ+dyYthpFA/5rx5
         c8uM1+J3FOT0FmlyAE7u++m0Ml7oXRbrDpGoj0gYg2+YVx5se4E1HB8ZbPdwZy3eOkdj
         jZDQgjb+ljHwZqLGVW9pet5/7qgc70FIPS7jx+UYALngEkuGk0cisagl+YI6MdGAzT5g
         BB9Q==
X-Gm-Message-State: AOAM53105lEr2VLtMsopMWwZZ1Kp3z/WpmGoDoXWgbMXZd2kY+9RrG8M
        b1ELLboW7CkzhjWmTafQ8y5/6A==
X-Google-Smtp-Source: ABdhPJzo4PTRFoa6ALXvF1Wbiv/N8HVQluFWZRMTGVTg0gR7ClpeuW2hai2T2NHeK1tm7ybpD2BlfQ==
X-Received: by 2002:ac2:5a44:: with SMTP id r4mr3685000lfn.159.1601899654951;
        Mon, 05 Oct 2020 05:07:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p18sm543265ljn.127.2020.10.05.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:07:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 18CD6103B11; Mon,  5 Oct 2020 15:07:35 +0300 (+03)
Date:   Mon, 5 Oct 2020 15:07:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Remove src/dst mm parameter in copy_page_range()
Message-ID: <20201005120735.hx55z63vlmgr5jhy@box>
References: <20201002192647.7161-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002192647.7161-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:26:47PM -0400, Peter Xu wrote:
> Both of the mm pointers are not needed after commit 7a4830c380f3 ("mm/fork:
> Pass new vma pointer into copy_page_range()").
> 
> Jason Gunthorpe also reported that the ordering of copy_page_range() is odd.
> Since working at it, reorder the parameters to be logical, by (1) always put
> the dst_* fields to be before src_* fields, and (2) keep the same type of
> parameters together.
> 
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
