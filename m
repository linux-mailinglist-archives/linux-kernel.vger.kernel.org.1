Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B002905B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408053AbgJPNHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395498AbgJPNHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602853622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWUO5Kx1XzjNBUUh1uK2wm/TLp0TE60XaeXMP1/+WFQ=;
        b=WAnVoNv+kupk8b2iHD/srIIHSnEtS0TEPssdgZv0aTGqMZg5eefZi2hvynNNRW56NCYumO
        AfFUprTxrScgaZVSFPn9ogI6aRSb+QcHmMo2OFfR4JkfPjyjJUhaCC9gpaDsGT9NLgXE2O
        PpUtZTnDkiD8M5rMb3oMfziKLDPykWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442--SpAUN7wOgiiepT9YaOyLg-1; Fri, 16 Oct 2020 09:06:58 -0400
X-MC-Unique: -SpAUN7wOgiiepT9YaOyLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16145186DD28;
        Fri, 16 Oct 2020 13:06:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5D361002C00;
        Fri, 16 Oct 2020 13:06:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000650d4005b00bcb0c@google.com>
References: <000000000000650d4005b00bcb0c@google.com>
To:     syzbot <syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, Hillf Danton <hdanton@sina.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in strncasecmp
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1399789.1602853614.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 16 Oct 2020 14:06:54 +0100
Message-ID: <1399790.1602853614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git 	f25a7033ecb675101f8bc060a7c5fbe0c9076fd3

