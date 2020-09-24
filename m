Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2F276C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgIXIe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgIXIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:34:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC26C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OUHUdYJD7r+VuVVENErfQFGZk/hWw89tE0SaaaDXEkg=; b=mfl5OeBPIblDvnWsP3HHx5Ez12
        MaSGxgBXIxx0ipqkpyqu+85OmiAqAXD8CGI5aNqzdkbxlcImP5Eg9FbSmtxMfq2TfCcGo9R4bqWPy
        Eq0QT6gOEzkm1tRDXAAlFs5palDRIB3QmNQz100LlbCXotXaq3WAu5Yay+DbuAVQ9LCfvFIIo9z86
        tE42jdwc6SlQmXPxbuqzLQpEel1CYsn9GP2Wfev1rsOFVOZX66VCRM3daOYrAoC6uqrZEcj9f3/wK
        ok/I73Kr8TIxibWuM8YSb64mwIqJqTsysCLyKCtZr6IiCH/AyhcCTrEU60xGEVFvyNNj2LDU0m4a0
        PkYnttGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLMhk-00053L-U2; Thu, 24 Sep 2020 08:34:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26578300455;
        Thu, 24 Sep 2020 10:34:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E103B2BC0B6AD; Thu, 24 Sep 2020 10:34:14 +0200 (CEST)
Date:   Thu, 24 Sep 2020 10:34:14 +0200
From:   peterz@infradead.org
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, qais.yousef@arm.com,
        mingo@kernel.org, cai@lca.pw, tyhicks@canonical.com, arnd@arndb.de,
        rameezmustafa@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] measure latency of cpu hotplug path
Message-ID: <20200924083414.GB1362448@hirez.programming.kicks-ass.net>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 04:37:44PM -0700, Prasad Sodagudi wrote:
> There are all changes related to cpu hotplug path and would like to seek
> upstream review. These are all patches in Qualcomm downstream kernel
> for a quite long time. First patch sets the rt prioity to hotplug
> task and second patch adds cpuhp trace events.
> 
> 1) cpu-hotplug: Always use real time scheduling when hotplugging a CPU
> 2) cpu/hotplug: Add cpuhp_latency trace event

Why? Hotplug is a known super slow path. If you care about hotplug
latency you're doing it wrong.
