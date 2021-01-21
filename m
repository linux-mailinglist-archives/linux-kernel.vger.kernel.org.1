Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C92FF5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbhAUUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbhAUUcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:32:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88D37230F9;
        Thu, 21 Jan 2021 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611261098;
        bh=dTC+Fvj5l3NJgeQEFALnCpXRbWU1+9WuIGk8hQ4mUi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTRkv1dnnEpfEgY6zS7wtjYvvzVb0JSz2GGN50rWaYkCASH9Lj/cSYNafrxEzvYbM
         v76gy2G/l5yk1KZt1fhJvER+bcmJ7G/ICROoJhGLdOzoiL2+KtT6mmUFxEy08IGM+d
         x0rKF5A00s1njOjO1BvapLJgZ1LLARequfaG+umGjbGUUvrcUlgIF6BGMsVVP82Kw/
         0NbBoVoTkgSWKY2sRvnIS5NOSyPhvVYNEO8eERLxy50rcJJH+nsj9qCHwfoxR0VR1T
         HGkLbWGa5wneZ2Rw8QXIM09vigSxyo8HJN4cdx+UE6wPE11xsGVcuGR+ykoOdHGf2k
         aVGZhR0Fsc+Lg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 717F640513; Thu, 21 Jan 2021 17:31:36 -0300 (-03)
Date:   Thu, 21 Jan 2021 17:31:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
Message-ID: <20210121203136.GD356537@kernel.org>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
 <DB8PR04MB67951BF5DBE4524CB13BAAE4E6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <c3d8d635-33ab-8d7e-6efc-6a589aebeb52@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d8d635-33ab-8d7e-6efc-6a589aebeb52@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 09:15:54AM +0000, John Garry escreveu:
> On 20/01/2021 05:15, Joakim Zhang wrote:
> > For this patch: Tested-by: Joakim Zhang <qiangqing.zhang@nxp.com>

> > Hi John, Jolsa,

> > Is there any way to avoid breaking exist metric expressions? If not, it will always happened after metricgroup changes.
 
> They are not normally broken like that. Normally we test beforehand, but
> these cases were missed here by me. However if you were testing them
> previously, then it would be expected that you had tested them again for the
> final patchset which was merged.
 
> Anyway, we can look to add metric tests for these.
 
> @Arnaldo, I will send separate formal patch for this today.

Hi John, can you please take a look at my tmp.perf/urgent branch and see
if all is well, i.e. the versions of these patches are the ones that
should be merged and that all the patches discussed are there?

For your convenience:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/urgent

Thanks,

- Arnaldo
