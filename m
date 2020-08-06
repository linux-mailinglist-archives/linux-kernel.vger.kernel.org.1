Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58023DF28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgHFRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 13:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbgHFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFEA722D02;
        Thu,  6 Aug 2020 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596715436;
        bh=LKYra0934/64cLM/vomYx32u/6krACnKueDcGfMNhBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSSwZeMuGDqY42iJEUyWkuThPtlpxGO8V7N465yT0bMidpqqJXAqmbv9ualf+9aMZ
         s6trAJaZNjAER01lPMLa1IpudeDuTtKNul+eJ4cwCo81w57vqPIx5H5C+v/SS107fD
         vN/QuBUxs6Kso2Ab7Flb2jxgNv7PeqxJmt6KXSRU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6CC040524; Thu,  6 Aug 2020 09:03:52 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:03:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 12/12] perf intel-pt: Add support for decoding PSB+
 only
Message-ID: <20200806120352.GE16189@kernel.org>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
 <20200710151104.15137-13-adrian.hunter@intel.com>
 <20200720222502.GC1180481@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720222502.GC1180481@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 20, 2020 at 03:25:02PM -0700, Andi Kleen escreveu:
> But looks overall the patches look good to me now.
 
> (for the whole series)
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo
