Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4543303BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbhAZLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403782AbhAZL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611660349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7xj1vVc4HNNMNiCYZvylA2+cbCnK0udL5Jus77CY5w=;
        b=Dvm9ZTjRiK7EPxNyRb2OOKjVgqtgqzV8jHDfKaOBWA5eBX2k2V2rpGssQMzgkupMJkqogO
        ddh96BLOOPc9BA7Y4hVD+MmWKoq4XwKeMNXiDdV0wlEZiQHRG/Xpm9WwdkSqemM9y35QUS
        kPNBUbmBg7KfeWnwQp62eIygSqTpZCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-k2dwZpoEMeOE1nsI7jRpkw-1; Tue, 26 Jan 2021 06:25:46 -0500
X-MC-Unique: k2dwZpoEMeOE1nsI7jRpkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D0E107ACE3;
        Tue, 26 Jan 2021 11:25:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 778AB62950;
        Tue, 26 Jan 2021 11:25:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200921112218.GB2139@willie-the-truck>
References: <20200921112218.GB2139@willie-the-truck> <20200721195132.GJ10769@hirez.programming.kicks-ass.net> <202006142054.C00B3E9C9@keescook> <20200612183450.4189588-1-keescook@chromium.org> <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com> <544539.1595328664@warthog.procyon.org.uk> <202007211144.A68C31D@keescook> <3211866.1595933798@warthog.procyon.org.uk> <20200729111120.GA2638@hirez.programming.kicks-ass.net>
To:     Will Deacon <will@kernel.org>
Cc:     dhowells@redhat.com, peterz@infradead.org,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain the old value
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2697075.1611660339.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 26 Jan 2021 11:25:39 +0000
Message-ID: <2697076.1611660339@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> wrote:

> > @@ -219,9 +235,14 @@ static inline void refcount_add(int i, r
> >   *
> >   * Return: true if the increment was successful, false otherwise
> >   */
> > +static inline __must_check bool __refcount_inc_not_zero(refcount_t *r=
, int *oldp)
> > +{
> > +	return __refcount_add_not_zero(1, r, oldp);
> > +}
> =

> Where returning both a bool to indicate whether the old value was zero
> and also the old value itself is a bit OTT.

Actually, with the i386 cmpxchg, that makes sense.  You can use the Z flag=
 to
give you the bool, saving on checking the old value.

David

