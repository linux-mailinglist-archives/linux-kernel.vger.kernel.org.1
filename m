Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BEE217D75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 05:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgGHDRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 23:17:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728061AbgGHDRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594178241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ko96yNRVsBzWQyxp2ttImemcgs2F2qK+jDpmfiagf0M=;
        b=V2iWl9t7btsu4iTsifj51BY4lDw0g51k7POFSf7XGMNKSnDKwvcaPUqbvEpMA1/gGYlXH4
        O8p8z1xWfWeRcyeQFnmrT7wdx5ieE89NPIh8AVCAj6CRYcISpQXP1mVfo8FO/6X38slO52
        VD4rEBZNKfZwApYMKsDzbFR5JBYV2ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-QvLS50kvPlCMtOEiRxEl2g-1; Tue, 07 Jul 2020 23:17:12 -0400
X-MC-Unique: QvLS50kvPlCMtOEiRxEl2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39811107ACCA;
        Wed,  8 Jul 2020 03:17:11 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 132D178475;
        Wed,  8 Jul 2020 03:17:07 +0000 (UTC)
Date:   Wed, 8 Jul 2020 11:17:04 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kdump
Message-ID: <20200708031704.GA10532@dhcp-128-65.nay.redhat.com>
References: <20200627103151.71942-1-grandmaster@al2klimov.de>
 <20200701075803.GB3878@dhcp-128-65.nay.redhat.com>
 <1de76ef5-e447-2274-c45a-3b0356bd63ae@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de76ef5-e447-2274-c45a-3b0356bd63ae@al2klimov.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/20 at 07:33pm, Alexander A. Klimov wrote:
> 
> 
> Am 01.07.20 um 09:58 schrieb Dave Young:
> > On 06/27/20 at 12:31pm, Alexander A. Klimov wrote:
> > > Rationale:
> > > Reduces attack surface on kernel devs opening the links for MITM
> > > as HTTPS traffic is much harder to manipulate.
> > > 
> > > Deterministic algorithm:
> > > For each file:
> > >    If not .svg:
> > >      For each line:
> > >        If doesn't contain `\bxmlns\b`:
> > >          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > >            If both the HTTP and HTTPS versions
> > >            return 200 OK and serve the same content:
> > >              Replace HTTP with HTTPS.
> > > 
> > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > > ---
> > >   If there are any URLs to be removed completely or at least not HTTPSified:
> > >   Just clearly say so and I'll *undo my change*.
> > >   See also https://lkml.org/lkml/2020/6/27/64
> > > 
> > >   If there are any valid, but yet not changed URLs:
> > >   See https://lkml.org/lkml/2020/6/26/837
> > > 
> > >   Documentation/admin-guide/kdump/kdump.rst | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> > > index 2da65fef2a1c..8cfa35f777f5 100644
> > > --- a/Documentation/admin-guide/kdump/kdump.rst
> > > +++ b/Documentation/admin-guide/kdump/kdump.rst
> > > @@ -65,20 +65,20 @@ Install kexec-tools
> > >   2) Download the kexec-tools user-space package from the following URL:
> > > -http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
> > > +https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
> > >   This is a symlink to the latest version.
> > >   The latest kexec-tools git tree is available at:
> > >   - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > -- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > +- https://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > >   There is also a gitweb interface available at
> > > -http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
> > > +https://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
> > >   More information about kexec-tools can be found at
> > > -http://horms.net/projects/kexec/
> > > +https://horms.net/projects/kexec/
> > >   3) Unpack the tarball with the tar command, as follows::
> > > @@ -511,7 +511,7 @@ dump kernel.
> > >   You can also use the Crash utility to analyze dump files in Kdump
> > >   format. Crash is available on Dave Anderson's site at the following URL:
> > > -   http://people.redhat.com/~anderson/
> > > +   https://people.redhat.com/~anderson/
> > 
> > Would you mind to update above url as well?
> I'll update all of the URLs not changed yet, but (please) not in this patch
> round.
> 
> See also https://lkml.org/lkml/2020/6/26/837

If this series can be taken soon then we can wait and submit a patch
later.

Or just drop this one from your series, I can submit another one to take
the https and crash url together later.

Either works.

> 
> > 
> > Dave have moved it to below url instead:
> > https://crash-utility.github.io/
> > 
> > Thanks
> > Dave
> > 
> 

