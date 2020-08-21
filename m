Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A4124D7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHUO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 10:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgHUO4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:56:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C1F72078B;
        Fri, 21 Aug 2020 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598021770;
        bh=1F00c5PlwMHWsnjZaFcuXTeu72VAUoyG13Qex7R6Wr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruQ9NJrOR/8+uNLYeFZS+DXy8E7H/y6okO1uLyfZXD2xmgvtmkIBa4vxUz6Gn0hxv
         xIBbP4eOLI1iN+xaSIt5b2HvL953t9Gaf3ZmaZwYOcTDaD9qycxfKqC+qY9zkr7IaO
         Es+mDJ1KfVZXDEwJ3AS/46380W4S7cOCjoptGdr8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF68D40D3D; Fri, 21 Aug 2020 11:56:08 -0300 (-03)
Date:   Fri, 21 Aug 2020 11:56:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Wei Li <liwei391@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Correct the help info of option
 "--no-bpf-event"
Message-ID: <20200821145608.GA3280597@kernel.org>
References: <20200819031947.12115-1-liwei391@huawei.com>
 <C77EA4D3-4AC9-4CED-8995-CA99285198BA@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C77EA4D3-4AC9-4CED-8995-CA99285198BA@fb.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 19, 2020 at 03:38:30PM +0000, Song Liu escreveu:
> 
> 
> > On Aug 18, 2020, at 8:19 PM, Wei Li <liwei391@huawei.com> wrote:
> > 
> > The help info of option "--no-bpf-event" is wrongly described as
> > "record bpf events", correct it.
> > 
> > Fixes: 71184c6ab7e6 ("perf record: Replace option --bpf-event with --no-bpf-event")
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Thanks for the fix!
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Thanks, applied.

- Arnaldo
