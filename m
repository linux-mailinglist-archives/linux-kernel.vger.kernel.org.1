Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33F22A4DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgKCSLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:11:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgKCSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604427082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nFesghkP08Z42FKyu9BtT7BVRb53GykVY3//gLTQhfY=;
        b=OwXZwIHJBpgIawj+68iWRHuPYIkDBd45OnOYpWALcOETe0E1xrCd7Xwt79LSVIUZLjClmG
        NPKST/ezytZE2rU+0ivNUZtMQb7yl0p8bkNa24IxQrOQ7t/v5BtaJsLUCaMPdVaMqNOweq
        WfKiy9zXa8rmG1YuLN2fQ2c6OBDkMBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-3XlsnigaN2yJ3PQXbZX9sw-1; Tue, 03 Nov 2020 13:11:20 -0500
X-MC-Unique: 3XlsnigaN2yJ3PQXbZX9sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B643D18BA282;
        Tue,  3 Nov 2020 18:11:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 582246EF4B;
        Tue,  3 Nov 2020 18:11:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Nov 2020 19:11:18 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:11:15 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mark Mossberg <mark.mossberg@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201103181114.GC23992@redhat.com>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com>
 <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com>
 <20201103175237.GD4111@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103175237.GD4111@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03, Borislav Petkov wrote:
>
> On Tue, Nov 03, 2020 at 06:47:44PM +0100, Oleg Nesterov wrote:
> > > I'm thinking this should not use the atomic variant if it can get called
> > > in !atomic context too.
> >
> > For what?
>
> I'm thinking copy_code() should not use copy_from_user_nmi() if former
> can be called in non-atomic context too.

I understand, but why do you think this makes sense?

Say, do you think it is fine to block in fuse_readpage() ?

Anyway, this is off-topic and I won't argue.

Oleg.

