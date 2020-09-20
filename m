Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F9A2711E3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 05:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgITDD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 23:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITDD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 23:03:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF8C061755
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 20:03:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y17so10339355lfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWV/jsMUMksMZE27IZI8c4rRP2TN1WctCnXiq3Scruw=;
        b=r7dyFO6BZvkU1+jZ3ktulb7Olj5XZq+xHJP4KheRGVnYhJmpsqxmFJdChSY2NdWG5Y
         bfFTyOcXPEqjm4OtdeP+MZE5vFy4GfVmaLZJWAWU9L7KlgWx+vc2K1YT+NTTrASnvlW4
         ASdVbrFSBXkh6uWPsAXEaABL1wKgAUA05cc1hYdIyGHsIEMxZ5WrxAiqzj9cwpwUwdCL
         Htgf508DYtqP1ypux+vGuq0cshOyiiSmWyZJfS0csD1Ie8vGK+xRJUGq2tcADIvmADGo
         6PJvySufLgKB+O2wpJb2+TSVolkxR+Upyp8lEW/YBr0oJ4Rso/7CtSpVuaZWYId4e6lg
         pBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWV/jsMUMksMZE27IZI8c4rRP2TN1WctCnXiq3Scruw=;
        b=sWMHwJlGuTiGF75zdHGYh72C8peUKA8Tgwtn8tswyIzyCnyRVw8FWb6FXWT8ccGU/S
         8d+YDt09h4homLh8TH7IYD0/6A0tNffN1QG5bf/EiSniNax7kNExOyS4Q+NUmVgbiU3L
         pMCoRnUI3WLyvxomKQipF4a8TFFn+eX4FxSoJkge1I70X4Y6pAUsOzfrskoLNMnsWEwI
         c1toRqfnBFJvrUvIyxaVE0ijldFtoO+nrgA0WtIaMX1rcXuINRDPivm9wFJQeglr9+h+
         IlFpQFh8NgWW7gkQKpYgoXqPRP0d9ifrld/yaQihfhXiwvSrieBAc4ReFsZsgatuMNia
         Fkfw==
X-Gm-Message-State: AOAM531CvwE/tCaIaz0d7RiFspgV+MLva9W1wEcR+XcLhL/MzL+IT7lC
        /pQxZ4lNFpp5VHn+XIcbGtRLRByBgq/LDRqQJbs=
X-Google-Smtp-Source: ABdhPJzbxewgfIRd7dFM6aMH8nUIu+ubY3i/ED1st8W1cGiDchus/yhoowbwxNgeMctJTsfy+YU3hHPueP3NVVxWv5Y=
X-Received: by 2002:ac2:43d5:: with SMTP id u21mr15328758lfl.135.1600571034789;
 Sat, 19 Sep 2020 20:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200916100232.GF18329@kadam> <20200917065706.409079-1-jhubbard@nvidia.com>
 <20200917074054.GO18329@kadam>
In-Reply-To: <20200917074054.GO18329@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 20 Sep 2020 08:33:43 +0530
Message-ID: <CAFqt6zYFjGTJ=KUjHd5jf-ri5tCmo4HOLP1j3nsELFgcoEoLHQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: protect unpin_user_pages() against npages==-ERRNO
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, alex.bou9@gmail.com,
        gustavoars@kernel.org, Ira Weiny <ira.weiny@intel.com>,
        linux-kernel@vger.kernel.org, madhuparnabhowmik10@gmail.com,
        mporter@kernel.crashing.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 1:11 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Sep 16, 2020 at 11:57:06PM -0700, John Hubbard wrote:
> > As suggested by Dan Carpenter, fortify unpin_user_pages() just a bit,
> > against a typical caller mistake: check if the npages arg is really a
> > -ERRNO value, which would blow up the unpinning loop: WARN and return.
> >
> > If this new WARN_ON() fires, then the system *might* be leaking pages
> > (by leaving them pinned), but probably not. More likely, gup/pup
> > returned a hard -ERRNO error to the caller, who erroneously passed it
> > here.
> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >
> > Hi Dan,
> >
> > Is is OK to use your signed-off-by here? Since you came up with this.
> >
>
> Yeah.  That's fine.

Do we need a similar check inside unpin_user_pages_dirty_lock(),
when make_dirty set to false ?
