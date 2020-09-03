Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7125CA11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgICURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbgICURl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:17:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34AD3206C0;
        Thu,  3 Sep 2020 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599164261;
        bh=i9fCm279asHJGFQqByJ/TKwxNMBskl3TNRr6GR5Zt3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBKPUFd1QJh2YoCsStANm9WAWfvpeou916xy+/s/whAL9//VIcI7ukL15/jeikz5g
         uvXUXvKjHKrh1zL+wAdeEph2V+n5SnRJr+TgMBmhImASOve63VLIX+rHNRUIpK6yRk
         0SX5whNbk/DGvuv3enEpsc84NRigT2+WeCqnObNo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AA0040D3D; Thu,  3 Sep 2020 17:17:39 -0300 (-03)
Date:   Thu, 3 Sep 2020 17:17:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/6] perf tools: Use AsciiDoc formatting for --control
 option documentation
Message-ID: <20200903201739.GN3495158@kernel.org>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-4-adrian.hunter@intel.com>
 <00c35eb4-ed31-d5b0-eec7-f72ddd642b66@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c35eb4-ed31-d5b0-eec7-f72ddd642b66@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 07:12:43PM +0300, Alexey Budankov escreveu:
> 
> On 01.09.2020 12:37, Adrian Hunter wrote:
> > The --control option does not display well in man pages unless AsciiDoc
> > formatting is used.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/Documentation/perf-record.txt | 46 ++++++++++++------------
> >  tools/perf/Documentation/perf-stat.txt   | 46 ++++++++++++------------
> >  2 files changed, 46 insertions(+), 46 deletions(-)
> 
> Thanks Adrian for all the formating corrections.
> 
> Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Thanks, applied.

- Arnaldo
