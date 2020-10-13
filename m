Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6594228D53E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbgJMUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgJMUNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602619989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IJmGWX98yWRkjCLBh0udfqamxZ1s7DNR34V91jc9yw=;
        b=Kt2FpMbQEEMewvw8Rp66Ovss/6GyQHxGbT+vgMD0aOV4czx/Iyr6qe8lhJVW58AOpVqFLb
        6v8UDYg9JF+J1ozyjXVSifw7cds6h3jVZHpiK+zCnL44aeoJpZnmodj0TGWasz/Jqunq0D
        Q2I9HLVgSQjzXV1sxsH4ZEu8t2HiUtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-NA3vqfUgPtWBVQ0EdU7XtA-1; Tue, 13 Oct 2020 16:13:01 -0400
X-MC-Unique: NA3vqfUgPtWBVQ0EdU7XtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C40A01009639;
        Tue, 13 Oct 2020 20:12:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAE3C27CCC;
        Tue, 13 Oct 2020 20:12:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000e32a8b05b01f808a@google.com>
References: <000000000000e32a8b05b01f808a@google.com>
To:     syzbot <syzbot+2d0585e5efcd43d113c2@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in fscache_alloc_cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <157940.1602619974.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Oct 2020 21:12:54 +0100
Message-ID: <157941.1602619974@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git f8eb8d1c6a853f617ca9ee233bb2d230401c5bdc

