Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1112E1F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgLWQ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgLWQ1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:27:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 661B8222BB;
        Wed, 23 Dec 2020 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608740795;
        bh=+Offe3OdzvPzP+NpiZ1iKOygDtkwq3AsAvLa8AaOfKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeiF8mSmjPQFTWO0MacYwyqRCI/Ya178W6ceUfMC54LZm6pEMieJhKtjB1EgiQsbB
         eoQApRe76GodNiaXUIT5q6eIt0j5sDhRjCNp+1qeij1X1GyiPYnEgK07ZwHfZzvYnC
         ZNeJ4kvueYJ+1TxZU2auUISGVuVQKYHtgo4wtJquGFjXS/9IcZSeN+tQyWIr0TmG1k
         Zw2sM0q+eZFCqVlWme84yHb5Z3vH5kUJt2MmrvRXsV3lNc85Ty/7nVdwSxx88aHY95
         2q7RLO+lysoY2aXPUG95wFyrcgkBRTR9uYns5CzVTdTbF7UU6HvlzrNpD1MvuGSNEt
         7NRbCvDmUrPcA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 26AEE411E9; Wed, 23 Dec 2020 13:26:49 -0300 (-03)
Date:   Wed, 23 Dec 2020 13:26:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 3/4] perf tools: Update powerpc's syscall.tbl
Message-ID: <20201223162649.GB477817@kernel.org>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
 <1608278364-6733-4-git-send-email-yangtiezhu@loongson.cn>
 <20201218112659.GB325926@kernel.org>
 <20201218113209.GD325926@kernel.org>
 <1608301824.eljlhiafee.naveen@linux.ibm.com>
 <20201221234755.GC433286@kernel.org>
 <1608737054.bq8cv7ll62.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608737054.bq8cv7ll62.naveen@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 23, 2020 at 08:54:59PM +0530, Naveen N. Rao escreveu:
> Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 18, 2020 at 08:08:56PM +0530, Naveen N. Rao escreveu:
> > > Hi Arnaldo,
> > > 
> > > Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Dec 18, 2020 at 08:26:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Fri, Dec 18, 2020 at 03:59:23PM +0800, Tiezhu Yang escreveu:
> > > > > > This silences the following tools/perf/ build warning:
> > > > > > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
> > > > > > > Hi Ravi, Naveen,
> > > > > > > 	Can I get your Reviewed-by or Acked-by for this change and
> > > the
> > > > > other that adds s390's syscall.tbl to check_headers.sh so that we get
> > > > > oops s/s390/powerpc/g :-)
> > > > > > notified when the copy drifts, so that we can see if it still
> > > continues
> > > > > working and we can get new syscalls to be supported in things like 'perf
> > > > > trace'?
> > > 
> > > Yes, this looks good to me:
> > > Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > 
> > > FWIW, I had posted a similar patch back in April, but glad to have this go
> > > in ;)
> > > http://lkml.kernel.org/r/20200220063740.785913-1-naveen.n.rao@linux.vnet.ibm.com
> > 
> > My bad :-\
> 
> No worries, thanks for checking on this one.

Applied now, with your Reviewed-by, I had to refresh the update as there
were more changes after Tiezhu's update.

- Arnaldo
