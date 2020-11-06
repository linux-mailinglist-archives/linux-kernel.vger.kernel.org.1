Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0622A9568
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgKFLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbgKFLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604662217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrZ4oLrRKAlkIXCkiskrapF3SJUeI8FJdBVtlw792IE=;
        b=B3fTBQNN7+yPRyU8pyn06pRydRetpXpc5uxstF0pvzUbZo+TAqKmTwqhPjKnsiJWCPjPP2
        4mMUC+dnrY0emJBa75hqrxLkIccic1Rd7VCh8qek/7v2Q6g34OQLa6xhAEfyp+9rfGOmEZ
        mfzsLdbLsdZ79LUDpoxbvzjVt3seez8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-fC1An0zuMgOrKv4hm-MBGg-1; Fri, 06 Nov 2020 06:30:15 -0500
X-MC-Unique: fC1An0zuMgOrKv4hm-MBGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF8B5186DD28;
        Fri,  6 Nov 2020 11:30:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C07F1A4D6;
        Fri,  6 Nov 2020 11:30:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000debe9105b36bfd65@google.com>
References: <000000000000debe9105b36bfd65@google.com>
To:     syzbot <syzbot+f0f857c714a8800e048c@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, fweisbec@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: INFO: rcu detected stall in process_one_work (3)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796663.1604662211.1@warthog.procyon.org.uk>
Date:   Fri, 06 Nov 2020 11:30:11 +0000
Message-ID: <1796664.1604662211@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: afs: Fix cell removal

