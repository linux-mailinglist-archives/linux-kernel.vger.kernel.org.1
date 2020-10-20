Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB928B207
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgJLKMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729583AbgJLKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602497540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7UY0NqcxaCpDu11VSHh3rOGwOGkuQSUNrquH3JIcFk=;
        b=NfWp+kBZvRwcSGDjYIa5vvOrn2aO3zZHKfOzlJqX780mCPsvz03B/qgDSY8yfSABzPaeRJ
        Xw5YrZd5UFf6GAeJAURDzBE+RYiHpBkko+fkziPsa6dIcmmbo0w/nNJvhA8TjD/ahoFBd6
        DfSBMhCbmhFFKfosLLutxWH8qX4FCU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-49nESNQbPXK-3K0C6gKbSw-1; Mon, 12 Oct 2020 06:12:16 -0400
X-MC-Unique: 49nESNQbPXK-3K0C6gKbSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 262AB4239D;
        Mon, 12 Oct 2020 10:12:14 +0000 (UTC)
Received: from krava (unknown [10.40.195.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id E09015C225;
        Mon, 12 Oct 2020 10:12:09 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:12:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Zamir SUN <sztsian@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        zsun@redhat.com, Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tony Jones <tonyj@suse.de>, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>, powertop@lists.01.org,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [ANNOUNCE] libtraceevent.git
Message-ID: <20201012101208.GF1099489@krava>
References: <20201007130750.49349844@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007130750.49349844@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 01:07:50PM -0400, Steven Rostedt wrote:
> I split out tools/lib/traceevent from the kernel tree using "git subtree",
> which recreates all the commits of a directory and makes that directory a
> stand alone. I then updated the Makefiles, and copied over some of the
> header files used to build the library. I pushed this up to:
> 
>   https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/
> 
> My hope is that this will now be the source of all updates to the
> libtraceevent library that can be used as a stand alone package that both
> perf and tracecmd can use. I would also like powertop and rasdaemon to use
> this as well.

hi,
I'm adding this as fedora package, is there a source arhive somewhere
in git.kernel.org for libtraceevent that spec could download?

thanks,
jirka

