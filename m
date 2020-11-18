Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398F2B7D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgKRMFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727946AbgKRMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605701120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9uON15dFZGCGHSCsCbMLG73inMwC0/+d9qTS/tVTe/c=;
        b=GhDPdsSosx0YkqGZPQMsQ+bgN9k83jucDHaVmRwS77lAxZJU3tTVfFVZjrStA6rXTlVjJF
        gzeKZ6haUs7uhR1ea8QybcRHuWQVDiyLeEXIWjo4joBbKtWt7ngEWfoAnDIn8KFhaxrsN8
        jbnXf0cIQdggR/rZKUjRQbQ4Uz2BOHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-i6SkQU4VNC6mLtKLB6HxyA-1; Wed, 18 Nov 2020 07:05:18 -0500
X-MC-Unique: i6SkQU4VNC6mLtKLB6HxyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F7E9803F57;
        Wed, 18 Nov 2020 12:05:17 +0000 (UTC)
Received: from localhost (ovpn-115-101.rdu2.redhat.com [10.10.115.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB48D60DA0;
        Wed, 18 Nov 2020 12:05:16 +0000 (UTC)
Date:   Wed, 18 Nov 2020 07:05:15 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC] Add kernel-doc test script
Message-ID: <20201118120515.GA1509407@habkost.net>
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
 <20201117223612.GN1235237@habkost.net>
 <19ebee73-0e7a-7dc1-5948-072ae153e383@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19ebee73-0e7a-7dc1-5948-072ae153e383@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:21:11AM +0100, Paolo Bonzini wrote:
> On 17/11/20 23:36, Eduardo Habkost wrote:
> > +# the -man output includes the build date
> > +export KBUILD_BUILD_TIMESTAMP=1991-08-25
> 
> Nice :)
> 
> > +ok=yes
> > +
> > +# don't even try to test other formats if -none fails:
> > +test none -none || exit 1
> > +
> > +test rst2 -rst -sphinx-version 3.0.0 || ok=no
> 
> Do you want 3.0.0 here too?

Oops!  No!  I'll fix it.

> 
> > +test rst3 -rst -sphinx-version 3.0.0 || ok=no
> > +test man -man || ok=no
> 
> Also since you are at it you might as well rename the function to something
> other than "test", it's a bit confusing due to the "test" shell builtin.

Good point.  I'll do.

-- 
Eduardo

