Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC06288685
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbgJIKEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbgJIKEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602237870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6oUXl8cXDiQxWYoF9OWbqCnK1IBZgB0WGXU+7KILpBs=;
        b=UIg7qUQdqFTezvKHsgOMTqUm2OAhzJmCEI4Vzm+kfZ04v1gP0BLAXukbU8uy/8GzH+LhIS
        /VArnfq2I8JKt72ecNRPrP5bmKpyrZMd1Byb8/mlFAg5Uhx/XaQtifs1e7MWACz/sSARNF
        2MqCcArGBV+i0qLN0Ts+xZxzel9mibQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-vlyUsbZHNJ-WtKzGTvkj6A-1; Fri, 09 Oct 2020 06:04:28 -0400
X-MC-Unique: vlyUsbZHNJ-WtKzGTvkj6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5DB1019625;
        Fri,  9 Oct 2020 10:04:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-196.rdu2.redhat.com [10.10.116.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E2116266E;
        Fri,  9 Oct 2020 10:04:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200924134052.1156-1-hdanton@sina.com>
References: <20200924134052.1156-1-hdanton@sina.com> <000000000000650d4005b00bcb0c@google.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in strncasecmp
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <471039.1602237864.1@warthog.procyon.org.uk>
Date:   Fri, 09 Oct 2020 11:04:24 +0100
Message-ID: <471040.1602237864@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> +			/*
> +			 * care to detect writers because
> +			 *
> +			 * read_seqbegin_or_lock(&net->cells_lock, &seq);
> +			 *
> +			 * is unable to block 
> +			 *
> +			 * write_seqlock(&net->cells_lock);
> +			 *
> +			 */

That shouldn't be true.  The loop may make one or two passes, the first
without the lock, the second with.  The RCU read lock is supposed to be held
in both cases too (but see below).

One of the call sites, however, afs_probe_cell_name(), doesn't call
afs_lookup_cell_rcu() with the RCU read lock held - which is an error, but not
obviously the one that's biting here.

David

