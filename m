Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9845926D17C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQDPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgIQDPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:15:32 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 23:15:32 EDT
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDA42078D;
        Thu, 17 Sep 2020 03:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600312053;
        bh=RQRBoaQqDALDP4kOlcUyHxmW7glid2QWf8ufXBgsveI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iwk7g+uGaaYCujkc7/ItS11t29T650I74YOla9t4oOYV6DfPh9T0/RCV/RM4OXEDm
         AdU33vBshNENwyhCzn7sl/ZHEXT2VRRGexmFhC+sPCDvWCWYAzwDSnSDP3+Avijf7s
         MXNRcM4eTVQGj2x+6vHGx8PMuFLuPCnokClFM8OY=
Date:   Thu, 17 Sep 2020 12:07:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf probe: Support debuginfod client
Message-Id: <20200917120728.d5ecb9587ff3366b6c04228b@kernel.org>
In-Reply-To: <20200916201753.GC16238@redhat.com>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
        <20200916181307.GB16238@redhat.com>
        <20200916185218.GA1322686@kernel.org>
        <20200916201753.GC16238@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 16:17:53 -0400
"Frank Ch. Eigler" <fche@redhat.com> wrote:

> Hi -
> 
> > > Nice, even uses the source code fetching part of the webapi!
> > 
> > So, can I take that as an Acked-by or Reviewed-by? 
> 
> Sure.

Thanks Frank and Arnaldo!

> 
> > I need to support this in pahole...
> 
> pahole/dwarves use elfutils, so it already has automatic support.
> 
> https://sourceware.org/elfutils/Debuginfod.html

I'm still not sure that which interface of elfutils I should use
for this "automatic" debuginfod support. Are there good documentation
about it?
Since this series just for the kernel binary, I have to check we
can do something on user-space binaries.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
