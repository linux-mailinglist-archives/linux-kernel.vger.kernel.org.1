Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06125CA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgICUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgICUQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:16:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E5F206C0;
        Thu,  3 Sep 2020 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599164215;
        bh=+0jm6rZJrbAcWwW0UViffpwaFAsI9EvGj27NR5fdisg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffsbCyXrGWhwLSinjOTHdBOEUZwmaUsY1nCOlg92BtrvhoH8ev4Hb7s2LlRL3aRTr
         /3hJ56wkHpzqiRNovbbVtghNF08MlrHp/hxhvlZr+RcYdY7G2IDJu/3OGxAJ2stBzU
         NlspxHNzLWprwUt0oDzpoDi46zfL26E21ZL8ipCg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5DD2C40D3D; Thu,  3 Sep 2020 17:16:53 -0300 (-03)
Date:   Thu, 3 Sep 2020 17:16:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/6] perf tools: Handle read errors from ctl_fd
Message-ID: <20200903201653.GM3495158@kernel.org>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-3-adrian.hunter@intel.com>
 <3172471f-7343-6efb-e549-ba7d95d7dfb3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3172471f-7343-6efb-e549-ba7d95d7dfb3@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 07:11:14PM +0300, Alexey Budankov escreveu:
> 
> On 01.09.2020 12:37, Adrian Hunter wrote:
> > Handle read errors from ctl_fd such as EINTR, EAGAIN and EWOULDBLOCK.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/util/evlist.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Thanks, applied.

- Arnaldo
