Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABB254BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgH0RPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 13:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726093AbgH0RPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598548500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GrVYnBCf9kRNkO91LHLOEFgKkaeauQRklIlZEj330sM=;
        b=Ri4LrgrUiWUy7pWn5QkBEFJGmQXaOIE16nj+4brQ4RNiyJIJR8t7+GTmKYS70VgL4sFo7w
        3T8NJNusXRS3fYMH4IG+dR2OXLO0eSyYkq1ixGfw+/x0AqN0U3HlSd0JlMimCAsoqA2nOO
        gyxuI5I8hN0KbQGe6b94QtuNI2MmDi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-TWlJB8AvNcWZABSKUagUMQ-1; Thu, 27 Aug 2020 13:14:59 -0400
X-MC-Unique: TWlJB8AvNcWZABSKUagUMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FA2D425D6;
        Thu, 27 Aug 2020 17:14:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 826CC610AF;
        Thu, 27 Aug 2020 17:14:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200827161824.GC31016@nautica>
References: <20200827161824.GC31016@nautica> <20200810164044.GA31753@lst.de> <1851200.1596472222@warthog.procyon.org.uk> <447452.1596109876@warthog.procyon.org.uk> <667820.1597072619@warthog.procyon.org.uk> <1428311.1598542135@warthog.procyon.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1442568.1598548486.1@warthog.procyon.org.uk>
Date:   Thu, 27 Aug 2020 18:14:46 +0100
Message-ID: <1442569.1598548486@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> wrote:

> Should I submit patches to you or wait until Linus merges it next cycle
> and send them directly?
> 
> I see Jeff's ceph patches are still in his tree's ceph-fscache-iter
> branch and I don't see them anywhere in your tree.

I really want them to all go in the same window, but there may be a
requirement for some filesystem-specific sets (eg. NFS) to go via the
maintainer tree.

Btw, at the moment, I'm looking at making the fscache read helper support the
new ->readahead() op.

David

