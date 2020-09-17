Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE51C26DDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIQOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727164AbgIQOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600351297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgSiIgESpv8Nm6obdQ8Me9R8mmKN7CQa620hOyz1Zeo=;
        b=EBQkL0lvg3f55Rz3UdPPQWOHoHjJGwcB1c4JgkkMFIjUqlogVojDy7H2/JlJA8sE/i34aA
        uf3ec2LFyt4CFzlJIQOYlQszj1zDrWyvBC0urirSXwJH3M6PGzQscPZAbbq3Oj263J49M/
        +RMIkcbjem4K/Oewb04xt4WYeUSn5rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-S97W0OWFNgeM5Ey_BDgmDQ-1; Thu, 17 Sep 2020 09:54:46 -0400
X-MC-Unique: S97W0OWFNgeM5Ey_BDgmDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5805D1017DCE;
        Thu, 17 Sep 2020 13:54:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.phx2.redhat.com [10.3.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 390686715F;
        Thu, 17 Sep 2020 13:54:45 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94)
        (envelope-from <fche@redhat.com>)
        id 1kIuN1-0007CX-8Z; Thu, 17 Sep 2020 09:54:43 -0400
Date:   Thu, 17 Sep 2020 09:54:43 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf probe: Support debuginfod client
Message-ID: <20200917135443.GA24128@redhat.com>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
 <20200916181307.GB16238@redhat.com>
 <20200916185218.GA1322686@kernel.org>
 <20200916201753.GC16238@redhat.com>
 <20200917120728.d5ecb9587ff3366b6c04228b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917120728.d5ecb9587ff3366b6c04228b@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

> > > I need to support this in pahole...
> > 
> > pahole/dwarves use elfutils, so it already has automatic support.
> > https://sourceware.org/elfutils/Debuginfod.html
> 
> I'm still not sure that which interface of elfutils I should use
> for this "automatic" debuginfod support. Are there good documentation
> about it?

The libdwfl part of the elfutils API falls back to debuginfod lookups
internally, so e.g. systemtap had to do nothing to benefit.


> Since this series just for the kernel binary, I have to check we
> can do something on user-space binaries.

It should work identically & transparently.  If you're using one of
a few key packages of a few mainstream distros, the public debuginfod
server may already have the material available.


- FChE

