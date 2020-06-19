Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13DA201DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 00:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgFSWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 18:06:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32294 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728790AbgFSWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592604402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I79nPb0pXt8/3dgBW2qv/EZDlPMjoeNKQYFohhTmzfU=;
        b=NCSB0XGX2FEDQ7vuFMbmRXrbsmB/QxWhlSD5WjbiSBU+T2txDb7ZMao5VGwM3d9on524eE
        PPWGAFx1KVGIm2VEF/X8/veRz6n5BaZ+DKqp0NXUi4jKAt18GIk3n9p1k/1Mf2HW/y6j/b
        1KNsYHJr/QQoRmTnupEi6ovR4CWurNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-IiZRG9gxN6KUc5yUml07TQ-1; Fri, 19 Jun 2020 18:06:40 -0400
X-MC-Unique: IiZRG9gxN6KUc5yUml07TQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66290C7441;
        Fri, 19 Jun 2020 22:06:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8351A60E1C;
        Fri, 19 Jun 2020 22:06:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000005bf70205a82e6e74@google.com>
References: <0000000000005bf70205a82e6e74@google.com>
To:     syzbot <syzbot+82523b7c170a6f515f9a@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: upstream test error: KASAN: use-after-free Write in afs_wake_up_async_call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2213532.1592604397.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 19 Jun 2020 23:06:37 +0100
Message-ID: <2213533.1592604397@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: net-next test error: KASAN: use-after-free Write in afs_wake_up_=
async_call

