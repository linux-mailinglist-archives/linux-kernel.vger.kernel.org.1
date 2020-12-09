Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C72D4B91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbgLIUUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgLIUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:20:42 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 12:20:02 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so4011935ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXNuciZGAoMUd/SECQlzOKmimQYdL/sit6tT9G5FsLo=;
        b=Q4GredAdgUUiXIbnr4HhP9p4y/6aHiGOTj9T+SVRf3kx4jQtzCfwRvKnAkHYEBZcWE
         ee3uqdHPp5k4JKb79Y5S6kmR/D4Q8upV/TIaPHuo+cxp4w8Oydj91Gxcl5tUuo7jtpaC
         KXfE7t6+r2NUrtdhqQE0bu2sWsOhFqtqL0B2CfN8vZnUCOMLZS2YQZ+qAs/dXQ+eYEi7
         +Py9L7vzjcQn5Av1sENWe5rJZydVY3MRfw/QlMLb6QKyq5OhAFqelIG3UrmT6v7vIZId
         kjPTp3aik1B619eE8Q/U0xq5arI3NIWjhKvCG34pgak0WPwVbCwyzsi5BZbPZl63GqaI
         DFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXNuciZGAoMUd/SECQlzOKmimQYdL/sit6tT9G5FsLo=;
        b=Eo+zYFdN+WVaPeKO0qiTBF2zOOAr5RpQhAr16vK2PysvJJ/cYRjJ0s7Ba0Wry/W6D+
         WlB5O/+JOv7OrWf12zW7J13ul2zK02GyVuMeO6WvFaYadfPnjTpV6lx4/+Jjoviyz48H
         DOzR0GIbyn+SFgjNdiE98rWzptIg1S2ETM3pZTHRTlrE8QR3aOYOI3cZ5KxlQY+jOaL3
         HBZGAe1swCqbAY9/mKwRfQSos9S+ALnlLWqWYuCgfJshAfTQXuTC07vMEsLEdBwTXtga
         ttHJvaMgaheRhBxg6y91bFahn5P4J1B3OEHB37nqxf5QdfhWhBYneGZaZ/TuDRSpCeo7
         3yAA==
X-Gm-Message-State: AOAM531kws74xvvZ466EFbLGA+ykDkcz6DhLoncfvQfkz9FT5jQLoGsG
        Mb2qReLCF/TBJ1vCJuvJEDJzhH68KFbB37D0bym7uA==
X-Google-Smtp-Source: ABdhPJyjaG7i4wtncjlxdho8e69LLSxKEMKXMhbjmbkgJwA1jMQgUCys7NV0tdXd1OBOdnz8985W3plWWreMWFhRiwc=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr3603934ejc.472.1607545200188;
 Wed, 09 Dec 2020 12:20:00 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com> <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org> <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
 <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com> <20201209040312.GN7338@casper.infradead.org>
 <CAPcyv4iD0eprWC_kMOdYdX-GvT-72OjZB-CKA9b5qV8BwNQ+6A@mail.gmail.com> <20201209201415.GT7338@casper.infradead.org>
In-Reply-To: <20201209201415.GT7338@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 12:19:57 -0800
Message-ID: <CAPcyv4h6mxo3vOU9r6ZcC1jUL_FCCEjmJ8dfmgYccNVJrGi3hQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:14 PM Matthew Wilcox <willy@infradead.org> wrote:
[..]
> If we put in into a separate patch, someone will suggest backing out the
> patch which tells us that there's a problem.  You know, like this guy ...
> https://lore.kernel.org/linux-mm/CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com/

...and that person, like in this case, will be told 'no' and go on to
find / fix the real problem.
