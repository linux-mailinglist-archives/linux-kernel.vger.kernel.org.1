Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD10B304F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhA0DMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:12:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390638AbhAZTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611688268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhSDWdgO45oMOw4U14ZD4IpWy4LqGlGQzgyJ+NX3F9s=;
        b=PKFkldKYoJmzAYl28A5f1X0tODSPYnLzvOpooZGKWxtaUSXfOK3QTEPYlAQX2I1r41pB3p
        S8W8Y3o0GGcI4uI2w91VgU2HXBU7ZvQ+m1ntBVa4G6Ep7EtklFj1s0I3Z/mjU6FNXCvPUp
        4NyAS5dupBZ1QVyr9TvCHzYS4lCOwhE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-QeAKOKXmMyq_D-t53wH5Fw-1; Tue, 26 Jan 2021 14:11:04 -0500
X-MC-Unique: QeAKOKXmMyq_D-t53wH5Fw-1
Received: by mail-ed1-f70.google.com with SMTP id w4so9840632edu.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhSDWdgO45oMOw4U14ZD4IpWy4LqGlGQzgyJ+NX3F9s=;
        b=EFWYH/DkcWEZoRimwlICbk+2+tP7WJlemIb6lHo5gZ0SJxau+8bih6V8dmqKbtNSVV
         hP/nxwcPVNbuJqVQP3g8KvFzCBwuoamZCLY7vvOq59rKn1tE4NqOaxRGjYHX3YPqFHvx
         rU3vlNq068qMadYVntlzMG/RgMXIhN7TUmVQwxDwyfgekLu42/Deszss9KUA9n6UXkcX
         igXkIvcYt3X2+Y4fDIDYbSnx9ybLy+XC15P/PnBFBYIM+oOcD0kZXkIn1w9M/R703jGq
         ZJKfKLG0KC+yFtCatVBdWr1MCHSi8IZZnasBq5g6pLR9pyTx5lx39di/cXEWs0IbbKBA
         JVgQ==
X-Gm-Message-State: AOAM531yutghSFPYoV4Id4fX5uKSKYcV9pcAAB3YURNtivfCM9FEY3CD
        /ohvScG9xWBYUHLvBXVLvEKoubfUuRM+f+cm2Nkc7H47VDBAPY7+dCT0yFBW9QQgZrwH+6NHgyV
        YGVJiDIaOFTINjnicdOicgVNkEk3ct5tHlxNJJocM
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr5760863edv.211.1611688263262;
        Tue, 26 Jan 2021 11:11:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9khL2OyLeDGiHbXxhgFxEoiQEWhWSGq0ZEPFvGyzCXtwZceNpjSLzAw970dmzg8NCnH9M4SKeWZSU2be3AaE=
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr5760842edv.211.1611688263103;
 Tue, 26 Jan 2021 11:11:03 -0800 (PST)
MIME-Version: 1.0
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161064956.2537118.3354798147866150631.stgit@warthog.procyon.org.uk>
 <20210126013611.GI308988@casper.infradead.org> <D6C85B77-17CA-4BA6-9C2C-C63A8AF613AB@oracle.com>
In-Reply-To: <D6C85B77-17CA-4BA6-9C2C-C63A8AF613AB@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 26 Jan 2021 14:10:26 -0500
Message-ID: <CALF+zOm++OzAebR4wu+Hdf8Aa8GpXZu8Am9eVajVUiDMBJE63w@mail.gmail.com>
Subject: Re: [PATCH 32/32] NFS: Convert readpage to readahead and use
 netfs_readahead for fscache
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs <linux-cachefs@redhat.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:25 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 25, 2021, at 8:36 PM, Matthew Wilcox <willy@infradead.org> wrote:
> >
> >
> > For Subject: s/readpage/readpages/
> >
> > On Mon, Jan 25, 2021 at 09:37:29PM +0000, David Howells wrote:
> >> +int __nfs_readahead_from_fscache(struct nfs_readdesc *desc,
> >> +                             struct readahead_control *rac)
> >
> > I thought you wanted it called ractl instead of rac?  That's what I've
> > been using in new code.
> >
> >> -    dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
> >> -             nfs_i_fscache(inode), npages, inode);
> >> +    dfprintk(FSCACHE, "NFS: nfs_readahead_from_fscache (0x%p/0x%p)\n",
> >> +             nfs_i_fscache(inode), inode);
> >
> > We do have readahead_count() if this is useful information to be logging.
>
> As a sidebar, the Linux NFS community is transitioning to tracepoints.
> It would be helpful (but not completely necessary) to use tracepoints
> in new code instead of printk.
>

The netfs API has a lot of good tracepoints and to be honest I think we can
get rid of fscache's rpcdebug, but let me take a closer look to be
sure.  I didn't use rpcdebug much, if at all, in the latest rounds of debugging.



>
> >> +static inline int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
> >> +                                         struct readahead_control *rac)
> >> {
> >> -    if (NFS_I(inode)->fscache)
> >> -            return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
> >> -                                                nr_pages);
> >> +    if (NFS_I(rac->mapping->host)->fscache)
> >> +            return __nfs_readahead_from_fscache(desc, rac);
> >>      return -ENOBUFS;
> >> }
> >
> > Not entirely sure that it's worth having the two functions separated any more.
> >
> >>      /* attempt to read as many of the pages as possible from the cache
> >>       * - this returns -ENOBUFS immediately if the cookie is negative
> >>       */
> >> -    ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
> >> -                                     pages, &nr_pages);
> >> +    ret = nfs_readahead_from_fscache(&desc, rac);
> >>      if (ret == 0)
> >>              goto read_complete; /* all pages were read */
> >>
> >>      nfs_pageio_init_read(&desc.pgio, inode, false,
> >>                           &nfs_async_read_completion_ops);
> >>
> >> -    ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
> >> +    while ((page = readahead_page(rac))) {
> >> +            ret = readpage_async_filler(&desc, page);
> >> +            put_page(page);
> >> +    }
> >
> > I thought with the new API we didn't need to do this kind of thing
> > any more?  ie no matter whether fscache is configured in or not, it'll
> > submit the I/Os.
>
> --
> Chuck Lever
>
>
>

