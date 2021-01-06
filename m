Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC92EB872
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAFDgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAFDgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:36:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C3C06134C;
        Tue,  5 Jan 2021 19:36:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o19so3619524lfo.1;
        Tue, 05 Jan 2021 19:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2snO45VnQ9DfpOQUXz5os2mTBvmAqZ+J43JJFFTkk28=;
        b=BxzymUjKVx+WjEM1RGa5cBOvn9Q5KkUj32bIVyB6xAujEHAJpCJMoYPoNehAl2jN7H
         PuwALS1bXxIoCZpV5ofFT3bysPxSxPZ02kzaPNDQHEz3ws3CSzalTEYCQKo/N3Cr75U7
         Li7jyB4gWQ/RUCB+KY9vEM1bCIGh9B0DRZiofOnl17ZU05vHn5vIPdI+ZJT6jEjtCE7J
         gJgFayYFT8IYIdiid94DZahr3+4pB0GBewn2ixGbjhp0z8HeyJgGGbxTx1TW4cZwehAs
         Z/T7DeACIHLWbHYUU4qZYo0tbD4LCd0zrrLE40M9ewoCSSvoBrn/qbRK7ui/rpYg+zdr
         ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2snO45VnQ9DfpOQUXz5os2mTBvmAqZ+J43JJFFTkk28=;
        b=Qofh7R4lbyDMwU4B7ij51B2iw+D+VfgIl/+xQmDoJlvkhPAmpPCwMSi4VGdtt5iMLJ
         lCfKQfsGWdRLctGRsqyIiTZhKS2EEXd4IPi7MAwK0ynaxuXxnW6gJnFgCJP7deAQyqd2
         7WJuNJcPydssvVYlj37P+YWq9NNVT91BB6u/wxpyAYc0UJSq+2qFGZwIpIEBEoWugTLU
         ySQkgAnK+jTFRbRbEgKQvrmk+kIDbxDmXFII5fD+xgCQD1AVwIu/xYAq6BZkeKLuwI4J
         2P6nwyq/2gVgHu/iq4hjZyY1mvuz622ssD8wJtVgf68Zk2e53CnyV8kxsgpTpmB9ZkeP
         FZgg==
X-Gm-Message-State: AOAM530SlO/4osO/W8BJt++jdEAZiEwgEOVoVIaoExzEbvohck3M7yJ9
        HfOGUHoZ06+gHhoyt25ID+YrYvbYOvUWsz+rH4I=
X-Google-Smtp-Source: ABdhPJwAoJvTQAyXXm5os8FCgE/dnwkr4Z6fBn2DAwhxeExEsV64TG0r0pOfaFH+aARaxG2E+EzzkxiWgCAEiOa5g4c=
X-Received: by 2002:ac2:5ff1:: with SMTP id s17mr1114188lfg.139.1609904164760;
 Tue, 05 Jan 2021 19:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20210105041630.1393157-1-daeho43@gmail.com> <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
 <6c8e6561-8a5d-010f-3d7c-8c051b4027e6@huawei.com>
In-Reply-To: <6c8e6561-8a5d-010f-3d7c-8c051b4027e6@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 6 Jan 2021 12:35:53 +0900
Message-ID: <CACOAw_wCh_Zh83SgRU2z_NR1OztKZ4b85JFkxWWhV3D6TGQCew@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix null page reference in redirty_blocks
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daehojeong@google.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Markus Elfring <Markus.Elfring@web.de>,
        Colin Ian King <colin.king@canonical.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the notice~

2021=EB=85=84 1=EC=9B=94 6=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 10:04, C=
hao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Daeho,
>
> FYI
>
> https://www.spinics.net/lists/kernel/msg3595944.html
>
> On 2021/1/5 20:04, Markus Elfring wrote:
> >> Fixed null page reference when find_lock_page() fails in
> >> redirty_blocks().
> >
> > I suggest to choose an other imperative wording for this change descrip=
tion.
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?id=3D36bbbd0e234d817938bdc521=
21a0f5473b3e58f5#n89
> >
> >
> >> v2: changed error value and break the loop when error occurs
> >
> > I propose to use a return statement instead of a break in the second if=
 branch
> > for this function implementation.
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?id=3D36bbbd0e234d817938bdc52121a0f5=
473b3e58f5#n481
> >
> > Regards,
> > Markus
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > .
> >
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
