Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC81A1B0C55
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgDTNNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:13:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39897 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbgDTNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587388430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYew2ybNbEYlxnWhOLAX8rprgalSjY8htLDKj7llLh0=;
        b=hYlw2D1tV44WpLt5dXs6nFhk03CyswctRpY8v7IMRCIJydF0IJihJiFE3j8Gl1M1Z5hKkf
        RYfmrjxWC1E21Q6hqCCoPSVVNIiyqQF3ysUVW6BFkXmDWI7lCfrO74eQo+EoQDm9xgYRwm
        PDZdszXjI9u2GH7EAT2+B1Tq4XobJMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-8q1U0xdCNU2fff9u2tmIGQ-1; Mon, 20 Apr 2020 09:13:45 -0400
X-MC-Unique: 8q1U0xdCNU2fff9u2tmIGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80352149C1;
        Mon, 20 Apr 2020 13:13:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BDD510013A1;
        Mon, 20 Apr 2020 13:13:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87imhvj7m6.fsf@cjr.nz>
References: <87imhvj7m6.fsf@cjr.nz> <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <927453.1587285472@warthog.procyon.org.uk>
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
Subject: Re: What's a good default TTL for DNS keys in the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1136023.1587388420.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Apr 2020 14:13:40 +0100
Message-ID: <1136024.1587388420@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Alcantara <pc@cjr.nz> wrote:

> >> For SMB3/CIFS mounts, Paulo added support last year for automatic
> >> reconnect if the IP address of the server changes.  It also is helpfu=
l
> >> when DFS (global name space) addresses change.
> >
> > What happens if the IP address the superblock is going to changes, the=
n
> > another mount is made back to the original IP address?  Does the secon=
d mount
> > just pick the original superblock?
> =

> It is going to transparently reconnect to the new ip address, SMB share,
> and cifs superblock is kept unchanged.  We, however, update internal
> TCP_Server_Info structure to reflect new destination ip address.
> =

> For the second mount, since the hostname (extracted out of the UNC path
> at mount time) resolves to a new ip address and that address was saved e=
arlier
> in TCP_Server_Info structure during reconnect, we will end up
> reusing same cifs superblock as per fs/cifs/connect.c:cifs_match_super()=
.

Would that be a bug?

David

