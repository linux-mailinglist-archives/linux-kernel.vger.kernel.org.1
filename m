Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA24228B24E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgJLKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387463AbgJLKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602498969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7Xk0qyHOBfk4sUAOvT0bJnN0sVSulkImHrJ66Dlx2k=;
        b=CL1sM/IezDG9zjq6jfjHilsiSxbHoS/hQx4PrYp+ICVAR3YnlELLztbJlpz50D7CmvRifD
        fX7tr5MY1CzkF+vsRYBmKG8dhdWMWZL/HSzJm+0wL113GAHl5QtNqIu6ZZqQ0Bx1+x1oVf
        vcmCn4Mu7UjFFfS+Ee2VAJ5MEkB+SX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-bfn4AL3sOBSyofzYolpmJQ-1; Mon, 12 Oct 2020 06:36:05 -0400
X-MC-Unique: bfn4AL3sOBSyofzYolpmJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5061879514;
        Mon, 12 Oct 2020 10:36:02 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id A3C9A1A8EC;
        Mon, 12 Oct 2020 10:35:58 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:35:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Zamir SUN <sztsian@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tony Jones <tonyj@suse.de>, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>, powertop@lists.01.org,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [ANNOUNCE] libtraceevent.git
Message-ID: <20201012103557.GG1099489@krava>
References: <20201007130750.49349844@gandalf.local.home>
 <20201012101208.GF1099489@krava>
 <CAHnb8o4tPPGEP1u8LUcip__XrRKT5U-hrAQCry3JJk9SKKqqag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHnb8o4tPPGEP1u8LUcip__XrRKT5U-hrAQCry3JJk9SKKqqag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 06:19:14PM +0800, Zamir SUN wrote:
> On Mon, Oct 12, 2020 at 6:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Oct 07, 2020 at 01:07:50PM -0400, Steven Rostedt wrote:
> > > I split out tools/lib/traceevent from the kernel tree using "git subtree",
> > > which recreates all the commits of a directory and makes that directory a
> > > stand alone. I then updated the Makefiles, and copied over some of the
> > > header files used to build the library. I pushed this up to:
> > >
> > >   https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> > >
> > > My hope is that this will now be the source of all updates to the
> > > libtraceevent library that can be used as a stand alone package that both
> > > perf and tracecmd can use. I would also like powertop and rasdaemon to use
> > > this as well.
> >
> > hi,
> > I'm adding this as fedora package, is there a source arhive somewhere
> > in git.kernel.org for libtraceevent that spec could download?
> >
> 
> Hi Jiri,
> 
> I was also working on it before. My way to get the source code is to
> manually generate the tarball like what trace-cmd did before.
> 
> See my copr
> https://copr.fedorainfracloud.org/coprs/zsun/test/build/1699358/
> And the spec
> 
> https://download.copr.fedorainfracloud.org/results/zsun/test/fedora-rawhide-x86_64/01699358-libtraceevent/libtraceevent.spec
> 
> I haven't have time to follow-up Steven's reply of Oct 9th about the
> document compiling yet. If you are willing to work on it now maybe you
> can start on top of mine. Otherwise I'll follow-up the packaging
> later.

we discussed on irc and Zamir will continue on this ;-)
plz let me know if I can help with something

thanks,
jirka

