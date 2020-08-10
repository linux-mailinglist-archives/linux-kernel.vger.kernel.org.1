Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA91C24110D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 21:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHJTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 15:37:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38577 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727991AbgHJTh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597088247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwOnUO3qnuP34cA5hoah52OJNOZjjOKPyNMz1o/AUDU=;
        b=cQ01r3OfkGWgtNEX/UYakqNMAkmnytVB9efKGdxz+FaLUXNx8vs/UiAOK2T4rwmh+fSFyU
        +3c3bhrRueq4nV4R05ba74jBrmBHgH3YB1N/jAWa4ZbFMMHCFcdQtsCOlz0aspI5guKIeC
        b0F6PeMjLzmmMGdkIf4slNLkzcjjv30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-7cwZ3q4hMfitOoj3aLxf9A-1; Mon, 10 Aug 2020 15:37:25 -0400
X-MC-Unique: 7cwZ3q4hMfitOoj3aLxf9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50A9519200C5;
        Mon, 10 Aug 2020 19:37:24 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.10.115.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0835F1E9;
        Mon, 10 Aug 2020 19:37:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BCA4422036A; Mon, 10 Aug 2020 15:37:17 -0400 (EDT)
Date:   Mon, 10 Aug 2020 15:37:17 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 18/20] fuse: Release file in process context
Message-ID: <20200810193717.GF455528@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-19-vgoyal@redhat.com>
 <CAJfpegs1CtPMaVmbDc__N0Fc3FkNEe=vQOkrr8RKiiS6NqTyHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs1CtPMaVmbDc__N0Fc3FkNEe=vQOkrr8RKiiS6NqTyHA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:29:13AM +0200, Miklos Szeredi wrote:
> On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > fuse_file_put(sync) can be called with sync=true/false. If sync=true,
> > it waits for release request response and then calls iput() in the
> > caller's context. If sync=false, it does not wait for release request
> > response, frees the fuse_file struct immediately and req->end function
> > does the iput().
> >
> > iput() can be a problem with DAX if called in req->end context. If this
> > is last reference to inode (VFS has let go its reference already), then
> > iput() will clean DAX mappings as well and send REMOVEMAPPING requests
> > and wait for completion. (All the the worker thread context which is
> > processing fuse replies from daemon on the host).
> >
> > That means it blocks worker thread and it stops processing further
> > replies and system deadlocks.
> 
> Is this reasoning specific to DAX?  Seems to me this is a virtio-fs
> specific issue.

Hi Miklos,

I am looking at this patch closely and maybe we don't need it, given
current code.

Reason being that looks like for virtiofs now we set ctx->destroy=true
and that sets fc->destroy. And if that's set, we don't schedule async req
in fuse_release_common();

fuse_release_common() {
  fuse_file_put(ff, ff->fc->destroy, isdir);
}

And if we don't schedule async file put, we don't run the risk of
blocking worker thread in evict_inode() with DAX enabled.

I ran blogbench multiple times with this patch reverted and I can't
reproduce the deadlock.

So we can drop this patch for now. If need be I will fix it as
post merge patch.

Thanks
Vivek

