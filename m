Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985F91DB602
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgETONY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 10:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETONY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:13:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C0B207F9;
        Wed, 20 May 2020 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589984003;
        bh=11URDiH9fhaUtaMINC8AwSJTzPEpmnUhW8fYbWAtjb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBgdN1VKLG8rPKZ7lESchnXOWqeDeDawX+ebOizzct6tzoLJinx2DZkLnGSifhAF0
         6tHRMQn8QC21CA9yJKqK0iQ9XPSGf7GTqxd7gfqhPndY7iwFq9wpq2GP0jL88KS1q6
         hDfUEX3I6Fh+9anrpKNgNyJFGPXuikkHysOlG9v4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE11340AFD; Wed, 20 May 2020 11:13:19 -0300 (-03)
Date:   Wed, 20 May 2020 11:13:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 0/5] perf stat: Support overall statistics for
 interval mode
Message-ID: <20200520141319.GI32678@kernel.org>
References: <20200520042737.24160-1-yao.jin@linux.intel.com>
 <20200520105406.GB157452@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520105406.GB157452@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 20, 2020 at 12:54:06PM +0200, Jiri Olsa escreveu:
> On Wed, May 20, 2020 at 12:27:32PM +0800, Jin Yao wrote:
> >  v6:
> >  ---
> >  1. Add comments in perf_evlist__save_aggr_prev_raw_counts.
> >  2. Move init_stats(&walltime_nsecs_stats) under interval condition check.

> >  Following patches are changed in v6.
> >     perf stat: Save aggr value to first member of prev_raw_counts
> >     perf stat: Report summary for interval mode

> Reviewed-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied,

- Arnaldo
