Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5153026E5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgIQT4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgIQT4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 15:56:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35335206DB;
        Thu, 17 Sep 2020 19:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600372607;
        bh=EowOzlDowBgKvpfS15oV3ZUep7H9vlTV6OLVhaJINaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKdNZnG9f6vONayvp0czWjt8rok7ZWg1z8p3jtUG9U8IwOXQqsM+ugJI0Ca8/vqwi
         6pxiPN+sf7hr0+zwl5yCVeHVpCHjEtxHOMpSFnVKASP19cU1uNqfW6QiIm3UFgt4ML
         xOQltvmljqxUb/QsjMLCmTpbtfK1jWXVl1rbYybM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B5D1400E9; Thu, 17 Sep 2020 16:56:45 -0300 (-03)
Date:   Thu, 17 Sep 2020 16:56:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf probe: Support debuginfod client
Message-ID: <20200917195644.GA1431236@kernel.org>
References: <160027467316.803747.10741549521899847231.stgit@devnote2>
 <20200916181307.GB16238@redhat.com>
 <20200916185218.GA1322686@kernel.org>
 <20200916201753.GC16238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916201753.GC16238@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 16, 2020 at 04:17:53PM -0400, Frank Ch. Eigler escreveu:
> Hi -
> 
> > > Nice, even uses the source code fetching part of the webapi!
> > 
> > So, can I take that as an Acked-by or Reviewed-by? 
> 
> Sure.

Thanks, applied both now that the things that made some 'perf probe'
'perf test' entries to fail is out of the way, all passes now with these
patches.

- Arnaldo
