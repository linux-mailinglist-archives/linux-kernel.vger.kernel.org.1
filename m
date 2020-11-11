Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18CB2AF7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgKKSBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKKSBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:01:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052A5206B6;
        Wed, 11 Nov 2020 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605117690;
        bh=rWIlCSVLkxy6U/Oi8BLJipuAg6hfbgdqGmwN3XRb5NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhB4e5zezCUflGLHAy5npSm00xFopJIbgN4b5ju8T3p34nghdDlSzKKE85MLRAAns
         hb6VapXatmNnYp6avXw33gpt2kbM9b1++XJOUHby6vVXMfSBDDSgMv1RtMqEMNH+AM
         995Y4fU95RHGjpV3xK1/f0cEw0fiX1B90AMIzehc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29330411D1; Wed, 11 Nov 2020 15:01:27 -0300 (-03)
Date:   Wed, 11 Nov 2020 15:01:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Andre Przywara <Andre.Przywara@arm.com>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/22] perf arm-spe: Refactor printing string to buffer
Message-ID: <20201111180127.GD380127@kernel.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
 <20201111071149.815-7-leo.yan@linaro.org>
 <20201111153555.GG355344@kernel.org>
 <a1ca3412-3815-e2a8-0334-f3059802df6a@arm.com>
 <20201111173922.GA380127@kernel.org>
 <20201111175827.GR6882@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111175827.GR6882@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 11, 2020 at 05:58:27PM +0000, Dave Martin escreveu:
> 
> On Wed, Nov 11, 2020 at 05:39:22PM +0000, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 11, 2020 at 03:45:23PM +0000, Andr� Przywara escreveu:
> > > On 11/11/2020 15:35, Arnaldo Carvalho de Melo wrote:
> > > > Isn't this 'ret +=' ? Otherwise if any of these arm_spe_pkt_snprintf()
> > > > calls are made the previous 'ret' value is simply discarded. Can you
> > > > clarify this?

> > > ret is the same as err. If err is negative (from previous calls), we
> > > return that straight away, so it does nothing but propagating the error.

> > Usually the return of a snprintf is used to account for buffer space, ok
> > I'll have to read it, which I shouldn't as snprintf has a well defined
> > meaning...

> > Ok, now that I look at it, I realize it is not a snprintf() routine, but
> > something with different semantics, that will look at a pointer to an
> > integer and then do nothing if it comes with some error, etc, confusing
> > :-/

> Would you be happier if the function were renamed?

> Originally we were aiming for snprintf() semantics, but this still
> spawns a lot of boilerplate code and encourages mistakes in the local
> caller here -- hence the current sticky error approach.

> So maybe the name should now be less "snprintf"-like.

Please, its important to stick to semantics for such well known type of
routines, helps reviewing, etc.

I'll keep the series up to that point and will run my build tests, then
push it publicly to acme/perf/core and you can go from there, ok?

I've changed the BIT() to BIT_ULL() as Andre suggested and I'm testing
it again.

- Arnaldo
