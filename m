Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994B1D22FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 01:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbgEMXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 19:25:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732580AbgEMXZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589412328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRvLFN1ITMU2V/ezwJVoycF2INOx4EKs0X6HDBhlvdA=;
        b=bEjIIae+ZCRG0hW1ZwbT4SPJq/L1FhSztmX2pbbhMr0W8mKMFiAyNRH2hyW14HgKSAExEN
        9Bmz7ymgInL5c6mhZ8/Vg+jrGMCKenDtJMQbSaRThDvdTAP7VcFcVMU+I3biNlz1BRuRuO
        ekwVO6IZSc+vjcepQL7xToBZh3GiIJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Q3t3JDRnPuyTFHa4LvzaUg-1; Wed, 13 May 2020 19:25:23 -0400
X-MC-Unique: Q3t3JDRnPuyTFHa4LvzaUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87E580183C;
        Wed, 13 May 2020 23:25:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FAED6E708;
        Wed, 13 May 2020 23:25:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <004ec27a-cc3a-c75c-952b-ff371b82b8d1@schaufler-ca.com>
References: <004ec27a-cc3a-c75c-952b-ff371b82b8d1@schaufler-ca.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, stephen.smalley.work@gmail.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3612471.1589412319.1@warthog.procyon.org.uk>
Date:   Thu, 14 May 2020 00:25:19 +0100
Message-ID: <3612472.1589412319@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > -	if (perm & ~KEY_NEED_ALL)
> > -		return -EINVAL;
> > +	switch (need_perm) {
> > +	default:
> > +		return -EACCES;
> ...
> Is the change from -EINVAL to -EACCES a bug fix?
> Does it introduce an incompatibility?

It shouldn't happen.  All the actual cases should be covered explicitly in the
switch.  It's to catch a programming issue in the kernel where a new value
gets added to the enum but not propagated to all the places that check for it.

I'd actually prefer it to be something even more obvious, especially as EINVAL
is so widely used in the kernel.  Should I put a WARN_ON in there?

David

