Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51E6283CE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgJEQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:56:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgJEQ4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601917004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdtzG7p2c3nnRpys49yiZh2OYseAcz7iHEB+i7Ihqlo=;
        b=M+7ogRbNJOsVRt5NB1T4Fck4ERNNeEZoRbPxlWxmdMjSg6odhlYgyHuAJ+sZMUQpe23ec1
        CLd7MaqpeNy+TsK23KSlxDm8POOcXRRvuYMlQ7FcW1Io0yRou0mnqHJJO9q4kNMd82CL4N
        N1W73COrTnD+jeLGKgPMpXdDQMP9Jrg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BC44AD32;
        Mon,  5 Oct 2020 16:56:44 +0000 (UTC)
Date:   Mon, 5 Oct 2020 18:56:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] printk: Use fallthrough pseudo-keyword
Message-ID: <20201005165643.GA32369@alley>
References: <20201002224627.GA30475@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002224627.GA30475@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-10-02 17:46:27, Gustavo A. R. Silva wrote:
> Replace /* FALL THRU */ comment with the new pseudo-keyword macro
> fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The patch is committed in printk/linux.git, branch for-5.10.

Best Regards,
Petr
