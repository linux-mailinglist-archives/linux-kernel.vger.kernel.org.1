Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824C827EBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgI3PBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:01:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgI3PBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:01:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601478072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2mUucJcLi35AIJNXuqLMLoqUTa21lTZCK2EZ0nq498=;
        b=Mm0hNhxPs3agsAG1cbbRINpyO4Qs9qIwd11DJWGXUiC4VOLIYnffsuwiicfpRn81rhxWLf
        FMBFFlick53K5umVDr/MKdProI8Ex6HB4xUJSaXSf/c+EdmW7Cg/l2jRT3PvJjaRZcZPB/
        ullXkX7d/zvEu2A2KPvVJ3jTEOog9vI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7451AB8F;
        Wed, 30 Sep 2020 15:01:12 +0000 (UTC)
Date:   Wed, 30 Sep 2020 17:01:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [RFC PATCH] kthread: do not modify running work
Message-ID: <20200930150109.GK29288@alley>
References: <20200926040426.11936-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926040426.11936-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-09-26 12:04:26, Hillf Danton wrote:
> 
> It does not make much sense to rearm timer for the delayed work if
> it is worker's current work atm because it's good to do work only
> once.

Quite typical scenario is to queue delayed work from its own callback.
It allows to do the work in regular intervals.

This patch would break it. Or do I miss anything?

Best Regards,
Petr
