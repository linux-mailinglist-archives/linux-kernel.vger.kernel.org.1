Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE652A956C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgKFLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbgKFLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604662231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrZ4oLrRKAlkIXCkiskrapF3SJUeI8FJdBVtlw792IE=;
        b=K0MvMdL6F/VXyMzuMmHRO+kMmAsyp99Lrg2dHPBqNrKr7LC/0fcUpkKPI+/iyT+7DQXPiH
        +EGroacc89FboozmgQD+RzhBvDQR7IT5RGlIV99AVOXdRsJeRuIQjGds6+Vbnu5Em9t2Mm
        jFMwkTEkHwx85GpH3RsjJzo6+QbPvBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-4CIlwkNPOZakdbv_95wdfg-1; Fri, 06 Nov 2020 06:30:30 -0500
X-MC-Unique: 4CIlwkNPOZakdbv_95wdfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6931D805F09;
        Fri,  6 Nov 2020 11:30:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E28C37366F;
        Fri,  6 Nov 2020 11:30:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0000000000003be64605b2fd88b2@google.com>
References: <0000000000003be64605b2fd88b2@google.com>
To:     syzbot <syzbot+dc8c077c7091175cbdb1@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, fweisbec@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: INFO: rcu detected stall in sys_mount (5)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1796697.1604662226.1@warthog.procyon.org.uk>
Date:   Fri, 06 Nov 2020 11:30:26 +0000
Message-ID: <1796698.1604662226@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: afs: Fix cell removal

