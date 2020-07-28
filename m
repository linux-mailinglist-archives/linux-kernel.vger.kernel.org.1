Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C298E230845
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 13:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgG1LCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 07:02:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52298 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgG1LCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595934120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XNR5WY2cWDahy2gyeJK0kb6s2X+lgnpqYhuDhcd8ew8=;
        b=VcuHUzhCv0/HWuzPt8up0AR2UeTOBbBjktdG4yO7Ov4wl/oVBsN2+k+me6VID71/RJc/k7
        59KOjHfmxEyn1xWkbMCrzKxaOnq1gCnMWnAIZWdqe8mi5XNriFjTKEh61WBeH3cpQXs88V
        KuEYubyKip3w8zYulatcdJdQzcqKXEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-kajcVqc3M8WsewvTSNVy_w-1; Tue, 28 Jul 2020 07:01:56 -0400
X-MC-Unique: kajcVqc3M8WsewvTSNVy_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4551010059AC;
        Tue, 28 Jul 2020 11:01:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1518712F6;
        Tue, 28 Jul 2020 11:01:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <202007211144.A68C31D@keescook>
References: <202007211144.A68C31D@keescook> <202006142054.C00B3E9C9@keescook> <20200612183450.4189588-1-keescook@chromium.org> <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com> <544539.1595328664@warthog.procyon.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     dhowells@redhat.com, Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3212524.1595934111.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 28 Jul 2020 12:01:51 +0100
Message-ID: <3212525.1595934111@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> > I've been gradually undoing some of the conversions as there's no equi=
valent
> > of atomic_add_return() and atomic_dec_return() that allow me to log th=
e
> > altered refcount through a tracepoint.
> =

> Please do not _undo_ the changes; just add the API you need.

And _please_ do not convert atomic_inc/dec_return() into refcount_read() +
refcount_xxx().  They are _not_ equivalent.

David

