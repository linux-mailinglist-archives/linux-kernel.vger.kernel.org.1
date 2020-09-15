Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D795D26A4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIOMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgIOMFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:05:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02B420732;
        Tue, 15 Sep 2020 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600170937;
        bh=2VEbaXBZNOtNnr1APTKiGyrRF0w4H7zFRXjc2gxWcAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kR+6+MyIeIvpC7x04oiEbCh5DUDjsuBoZaqnk8oohtkP1wgu5Nig8ExkC61m1Epdl
         WyuvCZb0If2OOWcNWv1bSAbTrI+2r6273GbZ1UeDe4JLy85lfmjAA5Gg7AYeW8VbT9
         GaWqdZHYjFEHh6/4hB4SMRAvI0o4pfunam6OWYIQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A97A140D3D; Tue, 15 Sep 2020 08:55:35 -0300 (-03)
Date:   Tue, 15 Sep 2020 08:55:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf vendor events amd: remove trailing commas
Message-ID: <20200915115535.GA720847@kernel.org>
References: <20200912041101.2123-1-henrywolfeburns@gmail.com>
 <20200915004125.971-1-henrywolfeburns@gmail.com>
 <CAM9d7cjnYm8cBFJBVSkbnyfNw2-SApsAkm7xLdNkmnSOhJZOZw@mail.gmail.com>
 <11f884ef-9a5d-e09b-b9e8-218953ab4699@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f884ef-9a5d-e09b-b9e8-218953ab4699@amd.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 10:06:28PM -0500, Kim Phillips escreveu:
> On 9/14/20 9:49 PM, Namhyung Kim wrote:
> > On Tue, Sep 15, 2020 at 9:41 AM Henry Burns <henrywolfeburns@gmail.com> wrote:
> >>
> >> amdzen2/core.json and amdzen/core.json have the occasional trailing
> >> comma. Since that goes against the JSON standard, lets remove it.
> >>
> >> Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks, applied.

- Arnaldo
