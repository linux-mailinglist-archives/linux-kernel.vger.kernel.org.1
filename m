Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68625304434
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbhAZGZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729069AbhAYNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611582376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+lH4jVBEWj7kNZTyZRP0Sg2RcVoDFoIqR+KnfPse8w=;
        b=VlWJEC4mD8d0eDPqV39MC/zd+DpWUbl9O2WNkupCUU+kZ+pbvav0h49c2yenR8Ap8ztbjv
        bND2NFzfessU59fg4N03sDwVBuDyK9knZopZohAWBYlCNFljzZ8Yqxwx9d3fY+dHps1hz4
        7tWCIKe8KytFpt6yfYOBV2p5PD0BDlU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-5qQoq7rPNr-djYZR3Kip7Q-1; Mon, 25 Jan 2021 08:46:12 -0500
X-MC-Unique: 5qQoq7rPNr-djYZR3Kip7Q-1
Received: by mail-qv1-f71.google.com with SMTP id m1so9186884qvp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 05:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+lH4jVBEWj7kNZTyZRP0Sg2RcVoDFoIqR+KnfPse8w=;
        b=bEA6uyrwJkTbrdy3/gZYwRRxnWAcIEmHOhe1AO//qy9bM+9YTmR17Wf9Ir9obGy/Dg
         sLg9Nq27Q2UR7+fNrH4XRA+D1niVaTco9xhDz5d56tUelZTEENeNMqqnD7pWO3tdwD8z
         L3i/GZ2iKpDuJgw6awL0K4tq2dyZFltT+A/2+Fw6l2vgajeIHAeRmgjxu+8hDV8gk1pv
         fORRz/s19IwO0P3Sjbh2yudg2ZZG17BqO8LZ0QCgSCX8igHuznMS7LRUEiwHfFq9b78+
         HOatjcaTazgD3SHvV76+CSjuhKyGPy3W9vA4wMvYC5kBdT9x9Qkm4AGjHyK+1euQ+mrN
         Q4Jg==
X-Gm-Message-State: AOAM531HNnuF1Qc9YhqzdmBAVo5PSVc4jgarzCyMq3zpg5JaqByR4/9M
        8E5yKeMRudS1vh3GMTICpX1lbreR3+WalXfadWzQZawphXsh/eQaQdgW6IZwE2tM04M2AHCGk7z
        tlWE3W1SLRwF8s2Qg+lcAubiRuY95zKnzTX1hGu5d
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr708440qkn.273.1611582372375;
        Mon, 25 Jan 2021 05:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGFrUDAGOGavT1DgCTfWNXl/5gNkCr9sSWhUA52UIjWH/BAh3BdpRyQaPXiC8jDJV9kH2sQ3NHpmwBPpiZwxY=
X-Received: by 2002:a05:620a:24cd:: with SMTP id m13mr708419qkn.273.1611582372176;
 Mon, 25 Jan 2021 05:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-2-mszeredi@redhat.com>
 <20210122183141.GB81247@sequoia> <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
In-Reply-To: <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 25 Jan 2021 14:46:01 +0100
Message-ID: <CAOssrKd04WaFjM1=qyUVnxwM9k_4Mc=OvvuCeN9HvYJnq91wWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
To:     Tyler Hicks <code@tyhicks.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 2:25 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Fri, Jan 22, 2021 at 7:31 PM Tyler Hicks <code@tyhicks.com> wrote:
> >
> > On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> > > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > > filesystems (overlayfs and ecryptfs) into account.
> > >
> > > That patch fixed the overlay case, but made the ecryptfs case worse.
> >
> > Thanks for sending a fix!
> >
> > I know that you don't have an eCryptfs setup to test with but I'm at a
> > loss about how to test this from the userns/fscaps side of things. Do
> > you have a sequence of unshare/setcap/getcap commands that I can run on
> > a file inside of an eCryptfs mount to verify that the bug exists after
> > 7c03e2cda4a5 and then again to verify that this patch fixes the bug?
>
> You need two terminals:
> $ = <USER>
> # = root
>
> $ unshare -Um
> $ echo $$
> <PID>
> # echo "0 1000 1" > uid_map

NOTE:  <USER> is assumed to have uid=1000, so this and following
"1000" values need to be fixed up if it's not the case.

Thanks,
Miklos

