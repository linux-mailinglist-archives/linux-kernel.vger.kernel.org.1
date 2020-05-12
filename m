Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793701CE967
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgEKX7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 19:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgEKX7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:59:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6201B206D9;
        Mon, 11 May 2020 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589241571;
        bh=L4VABxveNVwchcVUSQ8OFXctOzFp7NnpxV6moCUD/4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3bVDGDbFH/Rbi+0kBb+7UzrnBaamX1lgUkoutInS8GaF2gZW3Vl7ewU53K1oPLqh
         8gfpDFqjG7M0Ls1fJt4M1Qahtf5duPUsXwKPNCFGH0BTIBsXKEdsg3y1+0sUd/Bk0U
         zzPtXiieFlqX2ro7opKBhRAm6oMBB5EwWlSsOA0k=
Date:   Mon, 11 May 2020 19:04:04 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] perf tools: Replace zero-length array with flexible-array
Message-ID: <20200512000404.GA4897@embeddedor>
References: <20200511195643.GA9850@embeddedor>
 <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 05:20:08PM -0300, Arnaldo Melo wrote:
> 
> Thanks, applied
> 

Thanks, Arnaldo. 

I wonder if could also take the other two:

https://lore.kernel.org/lkml/20200511200911.GA13149@embeddedor/
https://lore.kernel.org/lkml/20200511201227.GA14041@embeddedor/

--
Gustavo
