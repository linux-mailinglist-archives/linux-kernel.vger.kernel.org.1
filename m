Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986C82FDFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 04:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404791AbhATX4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388772AbhATVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:34:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B556C06179E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:32:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so43949edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy03dF3U+DdU29KwUgMMYGmrbbY7SP87DkKAZuPL0sg=;
        b=hZY0Bu6psfLVvy9vBw9vYwmhADIx4HY4AFoFCBUMKBTiw3o4PHN806aCJ0yOUFnUrl
         rIqP1IeJ4iFGTKpZyOIFN3EIX1798ctkRrlTCXVKENyKFcjlZ/3Vt/vKy5wLjSJkvnhA
         hagcXfye/nVHrJbuLPy9tKXSIIluYPmZ4LSmK2E6CF2pXz6LFw7ite1r3nBFV1SM7rHc
         j2KB9MzG+rYD5zZbNBkW8Xdfxf8v9VuU3jfpmb7XbzI60sTvPuqmQtWPyL9SHTp3v0To
         3Hxvts1KnPh9PM+NUdy22QkCnLlXfXOsBymJCWIrJNA9kEpoVMKYFj3NDTFTAeNyFDqN
         LoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy03dF3U+DdU29KwUgMMYGmrbbY7SP87DkKAZuPL0sg=;
        b=lynNjKGxJDMDLPLZ54RgItiNbzwhQlIXHswltI1/vceyieIzzN+/d4JG/bgt6OIe+O
         jWp+GzONKH7iBuz+WHJb8EtbXd29y/b24c/L35m4QC5IfjpCk041RnXorHSvM8vcu0gd
         OsbiE4wibgz9pR8gTDaGgNec1aDkm5WbwsxTj74FjjQf+7oTQMK8o7i0DXnmjLk7Y9/F
         UjfWloJsJ6V7wngz7i4OdOk9Pf+wDlgh70YtaC3/AK0HuhFSuiauFPk1m5/Hr/O09DsW
         URVNzlXDZoDqPOHPWzevi5j9otYup3S2a23Ssmp24VYs4ET4H1EM4VnXQcF1Lh2kBXzg
         G8WA==
X-Gm-Message-State: AOAM530pjNrMb8Ox820eaM7fPoOpLKGpO3/gGkDXPxADrAMpoKw9tkxT
        8hhDavPYZE73vzEr+dHrCoxDC6SOK2GfjCGG5sekkw==
X-Google-Smtp-Source: ABdhPJxQmsRC/TtuePXG7qhj6Wd6K1Wif7/2CXrV4cjnoKMmuUcbGVUKCl28MC4GDEpy5BmXRk/ZXPlRujDEUqHL+B4=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr8861057edv.116.1611178338373;
 Wed, 20 Jan 2021 13:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20210120014333.222547-10-pasha.tatashin@soleen.com> <202101210158.5wK9errH-lkp@intel.com>
In-Reply-To: <202101210158.5wK9errH-lkp@intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 16:31:42 -0500
Message-ID: <CA+CK2bAFuuFhTbrCOC5X2fhGJGX8c_Bp0xn5uxuF4iBY0XQHEg@mail.gmail.com>
Subject: Re: [PATCH v6 09/14] mm/gup: migrate pinned pages out of movable zone
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    h8300-linux-ld: arch/h8300/kernel/entry.o: in function `resume_kernel':
>    (.text+0x29e): undefined reference to `TI_PRE_COUNT'
>    h8300-linux-ld: mm/gup.o: in function `.Llt6':
> >> gup.c:(.text+0x79e): undefined reference to `zero_pfn'

is_zero_pfn() is defined outside CONFIG_MMU, but uses zero_pfn, which
is declared in memory.c which is compiled with CONFIG_MMU.
