Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3327AD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgI1Lrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1Lrh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:47:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB0620657;
        Mon, 28 Sep 2020 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601293656;
        bh=39YhlJCdQCPV00YZJbaNuDDr5xHzCAOsWoinmbZIpew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tElBZwDYrRnTpN/MBD5ijF2t8tvXOx1Up5vhgHA3w+2mexfKzcIFoCC/mo4SjMlw6
         /HFZAa9r8wkQi6U9cVhUmPE04i5nN77Qo1P2QBykeM7pr/lYmUnlMO3f7unerS6pME
         VEQsGSPOFPiI3jvCg62yZr68OizNNbByjk23ePjw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A1F4B400E9; Mon, 28 Sep 2020 08:47:33 -0300 (-03)
Date:   Mon, 28 Sep 2020 08:47:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        irogers@google.com
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to
 v1.08
Message-ID: <20200928114733.GD2883319@kernel.org>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com>
 <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 23, 2020 at 09:25:06AM +0800, Jin, Yao escreveu:
> Hi Arnaldo,
> 
> On 9/23/2020 3:42 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 22, 2020 at 11:19:17AM +0800, Jin Yao escreveu:
> > > - Update CascadelakeX events to v1.08.
> > > - Update CascadelakeX JSON metrics from TMAM 4.0.
> > > 
> > > Other fixes:
> > > - Add NO_NMI_WATCHDOG metric constraint to Backend_Bound
> > > - Change 'MB/sec' to 'MB' in UNC_M_PMM_BANDWIDTH.

Applied.

- Arnaldo
