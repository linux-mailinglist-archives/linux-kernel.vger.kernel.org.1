Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6540126FC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIRM0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRM0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:26:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799C220874;
        Fri, 18 Sep 2020 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600431966;
        bh=MgT0FYMJK2K/Jm4w80YHNpra6kKaVDveMsajimPz2Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gE3bN4KHI3anx8o7B50GCaZootbtCbScst9M/Nt7AOCzOh9WZivaQOObK67IiA0/D
         qqjwwvjb6RIicTyT7kXjUEjKCo96mNV1MSJOFpwi691eZePfyEy9vxiKlDYnzgifVk
         laa0teGZEKBwBdphlWvkEK9kN+E/YPGUW0PfD8LQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88F3C400E9; Fri, 18 Sep 2020 09:26:04 -0300 (-03)
Date:   Fri, 18 Sep 2020 09:26:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Frank Ch . Eigler" <fche@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf probe: Fall back to debuginfod query if
 debuginfo and source not found
Message-ID: <20200918122604.GA1766541@kernel.org>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
 <160027469272.803747.13799945548211140499.stgit@devnote2>
 <20200918004022.GB1525630@kernel.org>
 <20200918114745.08b667cc1c64f99d11892ea6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918114745.08b667cc1c64f99d11892ea6@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 18, 2020 at 11:47:45AM +0900, Masami Hiramatsu escreveu:
> On Thu, 17 Sep 2020 21:40:22 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > util/probe-finder.c:1989:35: error: unused parameter 'new_path' [-Werror=unused-parameter]
> >  1989 |     const char *sbuild_id, char **new_path)
> >       |                            ~~~~~~~^~~~~~~~
> >   CC       /tmp/build/perf/util/lzma.o

> > I.e. please test  with:

> > [acme@quaco perf]$ grep DEBUGINFOD tools/perf/Makefile.perf
> > # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
> > [acme@quaco perf]$

> Oops, right. I forgot to install libdebuginfod also on host side...
> Let me update the series.

Reapplied, retrying, thanks for the quick response, always appreciated.

- Arnaldo
