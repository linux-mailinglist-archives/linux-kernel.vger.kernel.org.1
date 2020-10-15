Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3C28F6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbgJOQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389258AbgJOQbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:31:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC8722240;
        Thu, 15 Oct 2020 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602779503;
        bh=lshOq+K0CpFLNxvyVZCkuH7FKLCn2Q7EgpXW3c2Hfg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjSDgGOIn18+q2Dh6pnsk0pi1CvvNflP0cinPQSy+wwJJ1HsFfmk0b92g9BpoQHHk
         /YXSdac6hNV28h7ChJK4/kiNyrEEIJVl1EEKNqgsR0svTFiBXAxskwnsvwWsIet9p/
         KuJkAshdcm6nGpOACm+Ba9QA1+wzySLHNYIuXSt0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42C57403C2; Thu, 15 Oct 2020 13:31:40 -0300 (-03)
Date:   Thu, 15 Oct 2020 13:31:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf test 67 dumps core on linux v5.9
Message-ID: <20201015163140.GB308748@kernel.org>
References: <a0474694-ab14-3131-0076-a67dba0586f1@linux.ibm.com>
 <20201015125259.GB1461394@krava>
 <7dab863f-6a2b-edf1-5049-9398cb53a68d@linux.ibm.com>
 <20201015145044.GC1461394@krava>
 <20201015150917.GD1461394@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015150917.GD1461394@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 15, 2020 at 05:09:17PM +0200, Jiri Olsa escreveu:
> ah when puting it on top of perf/core I found it's already fixed there:
>   a55b7bb1c146 (tag: perf-tools-tests-v5.10-2020-09-28) perf test: Fix msan uninitialized use.
 
> so we should be fine

For 5.10, yes, but probably we need to send this to stable@ since Thomas
reported it failing on v5.9.

Does a55b7bb1c146 have a Fixes: tag?

Yes!

[acme@five perf]$ git show a55b7bb1c146 | grep Fixes:
    Fixes: commit f5a56570a3f2 ("perf test: Fix memory leaks in parse-metric test")
[acme@five perf]$ git tag --contains f5a56570a3f2 | grep ^v | head -1
v5.9
[acme@five perf]$

So v5.9.1 will probably get this automagically cherry-picked.

Good.

- Arnaldo
