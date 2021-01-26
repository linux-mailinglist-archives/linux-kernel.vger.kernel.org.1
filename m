Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A00303B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbhAZLFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:05:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:42836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbhAZGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:05:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C527AF99;
        Tue, 26 Jan 2021 06:04:41 +0000 (UTC)
Date:   Mon, 25 Jan 2021 22:04:33 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 0/7] Generic RB-tree helpers
Message-ID: <20210126060433.2oqgwogx6xrgcsan@offworld>
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210125150953.679129361@infradead.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Peter Zijlstra wrote:
>
>Hai all,
>
>I found myself needing to write yet another rbtree and remembered I had these
>patches gathering dust. I've had them in a git tree pretty much ever since I
>posted them last and the robot is telling me they build/work/dance/sing fine.
>
>I'm proposing to stick them in tip and get on with life. What say you?

I like consolidating this code with helpers, reduces LoC and improves
readability imo. Feel free to add my:

Acked-by: Davidlohr Bueso <dbueso@suse.de>
