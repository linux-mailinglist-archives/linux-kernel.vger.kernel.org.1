Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADA62ECE54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbhAGK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbhAGK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610017092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJuYKsFgeD/TaN1guAoXSRGGao5WVLChcuMpd8zsQq4=;
        b=eATXoRTV0j76W6i92snMhCvsEroZV7rPW6UbTm6iEeFtFcbbpIA5R1/RtXrU5/FiaP4Dc7
        SNMWrtxd8NMUyjgGZF9mh6eWgidW+Jj0izMY3UhcIbN3nys1JLuEhozVgRn5XnhKGZefeG
        Xcgr2jti49eVoWYRiE/NDZbDEV7qJTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-PLDymmrbNOGnq5zJt0MzTg-1; Thu, 07 Jan 2021 05:58:09 -0500
X-MC-Unique: PLDymmrbNOGnq5zJt0MzTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B8F4239C;
        Thu,  7 Jan 2021 10:58:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67BC271CB9;
        Thu,  7 Jan 2021 10:58:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210107092855.76093-1-tianjia.zhang@linux.alibaba.com>
References: <20210107092855.76093-1-tianjia.zhang@linux.alibaba.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Tobias Markus <tobias@markus-regensburg.de>,
        Tee Hao Wei <angelsl@in04.sg>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] X.509: Fix crash caused by NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <772252.1610017082.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 07 Jan 2021 10:58:02 +0000
Message-ID: <772253.1610017082@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:

> On the following call path, `sig->pkey_algo` is not assigned
> in asymmetric_key_verify_signature(), which causes runtime
> crash in public_key_verify_signature().
> =

>   keyctl_pkey_verify
>     asymmetric_key_verify_signature
>       verify_signature
>         public_key_verify_signature
> =

> This patch simply check this situation and fixes the crash
> caused by NULL pointer.
> =

> Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate veri=
fication")
> Cc: stable@vger.kernel.org # v5.10+
> Reported-by: Tobias Markus <tobias@markus-regensburg.de>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Looks reasonable:

Acked-by: David Howells <dhowells@redhat.com>

I wonder, though, if cert_sig_digest_update() should be obtained by some s=
ort
of function pointer.  It doesn't really seem to belong in this file.  But =
this
is a separate issue.

David

