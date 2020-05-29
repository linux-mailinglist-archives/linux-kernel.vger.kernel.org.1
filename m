Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6627C1E8374
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgE2QSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 12:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgE2QSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:18:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD842100A;
        Fri, 29 May 2020 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590769113;
        bh=/XVaklsVQ/1aXo3hQM/56PGlQcdyOQCpinbJtq27874=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwIEMET5H4Ci9MTcDm1Qr5N8X8YoPxF/bjgCG5unHGna18VFfteaL1hMXNWaOBEdq
         kch+mkc59jladg6eh22JmcH/qZHB+A1RnwQHK64ip76CH72hR+FIPhmtd/BzTsIcCL
         gouOKhAoMwwTPQdUZOCqx7yjcER7sGeVGljzyYsg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D94440AFD; Fri, 29 May 2020 13:18:30 -0300 (-03)
Date:   Fri, 29 May 2020 13:18:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200529161830.GD537@kernel.org>
References: <20200504115625.12589-1-leo.yan@linaro.org>
 <20200522030919.GE32389@leoy-ThinkPad-X240s>
 <20200526102602.GA27166@willie-the-truck>
 <20200526104337.GA7154@leoy-ThinkPad-X240s>
 <20200526195438.GC2206@willie-the-truck>
 <3a80a66f-b991-ec55-77a5-a8fc4fa69e5e@arm.com>
 <20200529152800.GB21552@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529152800.GB21552@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 29, 2020 at 11:28:01PM +0800, Leo Yan escreveu:
> Hi James,
> 
> On Fri, May 29, 2020 at 03:58:23PM +0100, James Clark wrote:
> > Hi Will and Leo,
> > 
> > I've tested this on an Arm N1 machine and it looks good to me.
> 
> This is great!  Will respin the new patch set with adding your test tag
> and send to ML.  Thanks a lot for the effort.
> 
> Hi Will, Arnaldo, sorry for late replying you due to other works and
> thanks for suggestions in other emails.

Np, please do it on top of my tmp.perf/core branch, it'll become
perf/core as soon as testing that is ongoing finishes.

- Arnaldo
