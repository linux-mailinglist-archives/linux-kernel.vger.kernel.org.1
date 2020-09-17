Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA326E517
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgIQTKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgIQTJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:09:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5583620672;
        Thu, 17 Sep 2020 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369774;
        bh=88YiASQeOkMQg5ZJ0wdw+Ae6BXOe/FlpvxT2A0yYuIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKvYXUBBUQ8eC14qWUGNia4bpU1vG2LhO+Ad2CwaINiRYA2nLZIKbFwM05SAwUYrD
         YIEfRMRmZ/2awRgkgCcGT8UFec1XWiI0rFv//O4GHnULt+DRl9vxsDA4UQsNgpb3Zo
         DhizfRxCT/IYfu8XyfWgr2zAdO0PEUYYcYGDNJyY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6730F400E9; Thu, 17 Sep 2020 16:09:32 -0300 (-03)
Date:   Thu, 17 Sep 2020 16:09:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yu@ghostprotocols.net, Yu-cheng <yu-cheng.yu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf intel-pt: Improve handling for tid is -1
Message-ID: <20200917190932.GD1426933@kernel.org>
References: <20200909084923.9096-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909084923.9096-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 09, 2020 at 11:49:21AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is a minor non-urgent fix for Intel PT.
> 

Thanks, applied both.
 
> Adrian Hunter (2):
>       perf script: Display negative tid in non-sample events
>       perf intel-pt: Fix "context_switch event has no tid" error
> 
>  tools/perf/builtin-script.c | 10 ++++++----
>  tools/perf/util/event.c     |  2 +-
>  tools/perf/util/intel-pt.c  |  8 ++++----
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
