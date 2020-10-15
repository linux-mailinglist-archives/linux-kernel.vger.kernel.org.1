Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E687E28F208
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgJOMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJOMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:25:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB3E2223F;
        Thu, 15 Oct 2020 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602764725;
        bh=4J1S7USanwZNN7qIzRrJ/hOpBggw7ss1lJF3WCHWT9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vfo03Jz6KhYC+GYDC2xf5GsmdJ963zUpFR8Fiut0kz1gduMJtEry2+CQuqpTwwXBn
         GAcdgGR5FxZKgAt9udqfp4434RFyz/KigCykp+dtoiWfib17yN+uzelc3rUu1sjJ47
         kLnBqM20BZhNujmhi9Gh631ycnGkI7ARl5urrgLY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 555D94047F; Thu, 15 Oct 2020 09:25:22 -0300 (-03)
Date:   Thu, 15 Oct 2020 09:25:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        kjain@linux.ibm.com, irogers@google.com, yao.jin@linux.intel.com,
        yeyunfeng@huawei.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf jevents: Fix event code for events referencing std
 arch events
Message-ID: <20201015122522.GA2896742@kernel.org>
References: <1602170368-11892-1-git-send-email-john.garry@huawei.com>
 <20201012105430.GH1099489@krava>
 <5b0aefe2-e0d5-b5ff-654c-4e93c427050f@huawei.com>
 <20201012112419.GJ1099489@krava>
 <20201014164905.GN3100363@kernel.org>
 <fa6351ab-4d2d-8de7-96e1-102d6fa0dd50@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6351ab-4d2d-8de7-96e1-102d6fa0dd50@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 14, 2020 at 06:46:12PM +0100, John Garry escreveu:
> On 14/10/2020 17:49, Arnaldo Carvalho de Melo wrote:
> > Ok, applied,
> 
> Thanks
> 
> > please consider adding a Fixes tag next time.
> > 
> 
> Can do if it helps, but I only thought it appropriate when fixing something
> merged to mainline.

Please do, I think it appropriate in all cases, people doing backports
may decide to pick something and if it has some subtle issue this can be
automatically checked for by looking at any later Fixes for that
specific cset.

I decided not to do any rebase on perf/core, so those Fixes will remain
valid.

- Arnaldo
