Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B62CAD90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgLAUn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLAUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:43:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:42:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f23so7151100ejk.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RBtUKeaPvU/GzP+jMS3Dsfo2rIt9YBehMmbHfwGd7A=;
        b=TqhVp2wuukokz3jQZaxuijfGTg+Cyjvo8mdtdphab3ayx20SLvi+f40TsI25kmNJeL
         5M2h1btbRcDdel8DD9g99aMFTOgPjufRoT+EAKc/IvZnOuthenykWAdJLoYk0R/AMnzc
         K3phAD+e/oP8ciIYw9uLyiviA2Opl7uz1mGiZTCXW6KNWaaKWvJDMnRH412k7nAhGIvi
         LWMYa9mqdQDpXUMm7q1C4JZCnxUAu/9zDzN9f8eWCdw3l2y8vrFW2JrLMjGgkHvsEbY/
         yVTXH2NGH0EKQdqJ6YQ7eenVmrU7rvYcu2VsIyB2QYSgs9eiMcblah5Mn7uDjxkqsjnu
         NpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RBtUKeaPvU/GzP+jMS3Dsfo2rIt9YBehMmbHfwGd7A=;
        b=VWBSDjEEcYaI7+YLPKFn1XQVAM6hbWjPEkJZ8kHAeHVvBNucOfbkxsCkSzJzZE5DxT
         vlq/1Bb7QPUUtnjQyEWTd4QD0Ii7DrWtt/XcNX8n1kqT+uodRoRnY0FmCyqc00kHeQkE
         qyRu7rN457navK7Ycdh5uH3KzaBx49et3bKdkwkcVo9Etz9lSwg6rDAkaVJe4P99yfkx
         dYdXUL+7yXCHz9q/ENT4CLSyvNj4X6danEM7dEEB6lO/t4oOdkioN749DvfTQqZjrWtu
         wR30LVAyJj5shYGL77ZRAL9DSXhQSgxYXStnANedHgz/POIBAjxe7tfqHwgCpUcC5hgi
         hQHQ==
X-Gm-Message-State: AOAM530t0fr+bw7tt0W9j1D6r/dC1T9t51wVDFcb+Jc0X1cLyiNBCUb+
        PPcdlKmNmT+tVQ/HlmjLf2UB3/1eA4n02BjsPQTwBg==
X-Google-Smtp-Source: ABdhPJw6elyMIoCPQlMD7L22PrIxSIlxVRceE737acKSgpuGoNsk6wo48ZXOON51AoZrJvlkpaizVjpKm2+u57GQA3g=
X-Received: by 2002:a17:906:c51:: with SMTP id t17mr4830318ejf.523.1606855363156;
 Tue, 01 Dec 2020 12:42:43 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org>
In-Reply-To: <20201201022412.GG4327@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Dec 2020 12:42:39 -0800
Message-ID: <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
Subject: Re: mapcount corruption regression
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > Kirill, Willy, compound page experts,
> >
> > I am seeking some debug ideas about the following splat:
> >
> > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > mapping:0000000000000000 index:0x0 pfn:0x121a12
>
> Mapcount of -1024 is the signature of:
>
> #define PG_guard        0x00000400

Oh, thanks for that. I overlooked how mapcount is overloaded. Although
in v5.10-rc4 that value is:

#define PG_table        0x00000400

>
> (the bits are inverted, so this turns into 0xfffffbff which is reported
> as -1024)
>
> I assume you have debug_pagealloc enabled?

Added it, but no extra spew. I'll dig a bit more on how PG_table is
not being cleared in this case.
