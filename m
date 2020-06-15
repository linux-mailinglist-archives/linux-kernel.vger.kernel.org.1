Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379C21F914C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgFOIY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgFOIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:24:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58817C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:24:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o26so10831868edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhrHsoF+IuuCWsNYTt36CnOUPKOXLNanHzXXw538ijY=;
        b=Uy4iXrsdKb9Jk+JDiX/Chl9qMKx9QpugSWS5NkriaPMVcmD97vURwhir28xYpfpmqh
         SPDMoEWcuI4fT1IewSfOaVTFRjIgC0ZgI+aTtHVa8Bt1v7S6TEeRQHOUatH5LzhwpGJ+
         6YojzNXVz6UCsvtK15ZaCT6yZnZ3E7q4SDk9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhrHsoF+IuuCWsNYTt36CnOUPKOXLNanHzXXw538ijY=;
        b=BYACubktYF99B1cFWyx7D8uIKVrHLYmKsVU6bjcvpqxh4iphb35lHnZk5zYCVybnBe
         iGA7oiWYKYkPz+90ZBDwhepRfesEOj/TBDsQsD6w0J/GUyHqLM49I0PKHXfZH+V6EstA
         NhbytcNkvdEemiTCIDW/YSBOt/eDMG6Nkru/FGSmslFQZADOrRoHggD4QugXbz8anw+z
         ZJM6XjpK11uwqni1MYqSLSUKKYXiIm0buQVEyydprIEy/KgbmtWrKqJvFbw19sqHRn02
         XPAZfSykzHAoYd752KnOVRbXjKXXWoHBUIGIMmmEnA9tBZFcyK52B4TOBd/CAnSCoOao
         DInQ==
X-Gm-Message-State: AOAM530N2IgFbOB9rhamJ3Q/+IPQsj+4xpSDyjcrbo4IcKtFOviQKoO5
        0lAJfclqbeVcEOpm9WYmBS/Jg3zo9BY0haPfOMPHfA==
X-Google-Smtp-Source: ABdhPJyTYfl7L17Ro5jQwnBv2wTKOxjN4zvQSKG7SGBI4x6Y1v+nhySmXXUUI9zXVpw1KDpsuc+QcQbm++UqGImgmT8=
X-Received: by 2002:a50:d785:: with SMTP id w5mr22156433edi.212.1592209493931;
 Mon, 15 Jun 2020 01:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk> <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Jun 2020 10:24:42 +0200
Message-ID: <CAJfpegv28Z2aECcb+Yfqum54zfwV=k1G1n_o3o6O-QTWOy3T4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 8:53 AM Amir Goldstein <amir73il@gmail.com> wrote:

> > I also looked at normal filesystem lower and hugetlbfs upper.  Yes, overlayfs
> > allows this.  This is somewhat 'interesting' as write() is not supported in
> > hugetlbfs.  Writing to files in the overlay actually ended up writing to
> > files in the lower filesystem.  That seems wrong, but overlayfs is new to me.

Yes, this very definitely should not happen.

> I am not sure how that happened, but I think that ovl_open_realfile()
> needs to fixup f_mode flags FMODE_CAN_WRITE | FMODE_CAN_READ
> after open_with_fake_path().

Okay, but how did the write actually get to the lower layer?

I failed to reproduce this.  Mike, how did you trigger this?

Thanks,
Miklos
