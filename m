Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D1251CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 18:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHYQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 12:06:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:06:55 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kAbTJ-0003Fl-8x; Tue, 25 Aug 2020 16:06:53 +0000
Date:   Tue, 25 Aug 2020 18:06:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
Message-ID: <20200825160652.pxhwofc6nz7u3jgj@wittgenstein>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
 <ec1410782019a2e43399445206e673273fd12c31.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec1410782019a2e43399445206e673273fd12c31.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:01:01AM -0700, Joe Perches wrote:
> On Tue, 2020-08-25 at 17:41 +0200, Christian Brauner wrote:
> > Namespace maintainership has never been formalized which has led to confusion
> > when people need to determine where to send patches and who should take a look
> > at them. Especially, since we have a dedicated list
> > containers.lists.linuxfoundation.org already for a long time. In preparation of
> > this patch I added the containers.lists.linuxfoundation.org mailing list to be
> > archived on lore.
> > 
> > This will not just make it easier to catch and review patches specific to
> > namespaces and containers but also for changes not specifically touching
> > namespaces but which nevertheless will have impact on namespaces and
> > containers.
> > 
> > Add an entry for Eric (who agreed to this) and me and add a first batch of
> > files that are relevant. Currently, only a small set of files are added and
> > only such namespaces that haven't gotten a separate maintainers entry (e.g.
> > time namespaces). I expect this to grow more entries and/or regular expressions
> > over time. For now these entries here are sufficient. I intend to route this
> > patch upstream soon.
> > 
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  MAINTAINERS | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f0068bceeb61..272211cdc327 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11892,6 +11892,26 @@ S:	Supported
> >  W:	https://www.cspi.com/ethernet-products/support/downloads/
> >  F:	drivers/net/ethernet/myricom/myri10ge/
> >  
> > +NAMESPACES AND CONTAINERS
> > +M:     Christian Brauner <christian.brauner@ubuntu.com>
> > +M:     Eric W. Biederman <ebiederm@xmission.com>
> > +L:     containers.lists.linuxfoundation.org
> > +S:     Supported
> > +T:     https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/
> > +T:     https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/
> > +F:     ipc/namespace.c
> > +F:     kernel/nsproxy.c
> > +F:     kernel/pid_namespace.c
> > +F:     kernel/user_namespace.c
> > +F:     kernel/utsname.c
> > +F:     include/linux/nsproxy.h
> > +F:     include/linux/ipc_namespace.h
> > +F:     include/linux/ns_common.h
> > +F:     include/linux/nsproxy.h
> > +F:     include/linux/pid_namespace.h
> > +F:     include/linux/user_namespace.h
> > +F:     include/linux/utsname.h
> 
> Please sort the filename order alphabetically.
> 
> F:	include/linux/ipc_namespace.h
> F:	include/linux/ns_common.h
> F:	include/linux/nsproxy.h
> F:	include/linux/nsproxy.h
> F:	include/linux/pid_namespace.h
> F:	include/linux/user_namespace.h
> F:	include/linux/utsname.h
> F:	ipc/namespace.c
> F:	kernel/nsproxy.c
> F:	kernel/pid_namespace.c
> F:	kernel/user_namespace.c
> F:	kernel/utsname.c

Thanks, fixing now.
Christian
