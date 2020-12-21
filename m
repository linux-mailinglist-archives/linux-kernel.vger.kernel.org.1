Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1262E0302
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 00:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgLUXsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 18:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgLUXsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 18:48:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C713D21E92;
        Mon, 21 Dec 2020 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608594462;
        bh=iU5QKciB+MHjyA1mvuMuRcabOlnAMk2QVJ+Q9MF6hsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFV8SQsZrzpTaO/5xhHMYiEtCly7fhGJZIJdsHoGjuWl4LLfKHWsDYqGwtpeMyzkh
         crru+lF+/tbt7L/LTWuspgRBffEOfqFJZW2Wygn926H/1swaeD4qbBKOecOr2NtHkm
         SBthMfDNaOqsorL94AvtD50JP9h0K4q4r0+icftvMJAdnhISQ8D/mBNAfeTW4/zdia
         1HrDoytTtLxA5gng6vCaZZmO8BEt17VAtqNJznkMfIqms3YlL1RID5YlaxM5Tqjlsw
         Sq/1TChDbTgpGQQs1NnUfzX1kWzILzAlbxVBNzzPjFPQF8rnpa2pUjJ6ITQ/2TcvnZ
         Qq7KOFAgEZx7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 233FC411E9; Mon, 21 Dec 2020 20:47:55 -0300 (-03)
Date:   Mon, 21 Dec 2020 20:47:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 3/4] perf tools: Update powerpc's syscall.tbl
Message-ID: <20201221234755.GC433286@kernel.org>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
 <1608278364-6733-4-git-send-email-yangtiezhu@loongson.cn>
 <20201218112659.GB325926@kernel.org>
 <20201218113209.GD325926@kernel.org>
 <1608301824.eljlhiafee.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608301824.eljlhiafee.naveen@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 18, 2020 at 08:08:56PM +0530, Naveen N. Rao escreveu:
> Hi Arnaldo,
> 
> Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 18, 2020 at 08:26:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Dec 18, 2020 at 03:59:23PM +0800, Tiezhu Yang escreveu:
> > > > This silences the following tools/perf/ build warning:
> > > > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
> > > 
> > > Hi Ravi, Naveen,
> > > 
> > > 	Can I get your Reviewed-by or Acked-by for this change and the
> > > other that adds s390's syscall.tbl to check_headers.sh so that we get
> > 
> > oops s/s390/powerpc/g :-)
> > 
> > > notified when the copy drifts, so that we can see if it still continues
> > > working and we can get new syscalls to be supported in things like 'perf
> > > trace'?
> 
> Yes, this looks good to me:
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> FWIW, I had posted a similar patch back in April, but glad to have this go
> in ;)
> http://lkml.kernel.org/r/20200220063740.785913-1-naveen.n.rao@linux.vnet.ibm.com

My bad :-\
 
> 
> Thanks,
> Naveen
> 

-- 

- Arnaldo
