Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D31297931
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757035AbgJWV7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757027AbgJWV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:59:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B8C0613CE;
        Fri, 23 Oct 2020 14:59:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603490388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcqtPkA0tz7ylkWcpgHi1whok+ruukbSXl7bVbRNeHw=;
        b=FpQmBJoq1nNNC4QO/xEsdNA1Wbti7sa5bKvyG9sxwcqPPWtOcPaCfWHtjhhrHtdUsbWyXk
        WuJFdPY9XA7e+0DEWHd8Rf+IBNRbxbf0fGtk3WY35MEYWRsCO/al04Qy+n8N35/YhhZLyT
        +qyXEDBepFoJ/UzLTB1z9KkOc67HKEEspRF1UkSXJFofyra8sQxfXRyr6iIdIJ522WMsTn
        rGHA9pvAWa0xtjYG5RpmS4+VYuClBkA7FcnnuaQjQsQavxrmtjMX1yyL73Onjqp8lR1m3x
        uqEwc+8Y5+pRUNn7WDf5/n76QQ5uM03H/QHZiUgjVoT9Lqy3Ug2xR58HjkD51A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603490388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcqtPkA0tz7ylkWcpgHi1whok+ruukbSXl7bVbRNeHw=;
        b=nHmm/QYqpi4s8doFzwGapHfMVQpfgwSLj29GjpCVLTMZfVMcMdPOuaBxwzoLga1IiapECr
        VsJQfTGT65LC3sCw==
To:     Elliot Berman <eberman@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
In-Reply-To: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
Date:   Fri, 23 Oct 2020 23:59:48 +0200
Message-ID: <87v9f04n8r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22 2020 at 15:04, Elliot Berman wrote:
> In a heterogeneous multiprocessor system, specifying the 'maxcpus'
> parameter on kernel command line does not provide sufficient control
> over which CPUs are brought online at kernel boot time, since CPUs may
> have nonuniform performance characteristics. Thus, add bootcpus kernel
> parameter to control which CPUs should be brought online during kernel
> boot. When both maxcpus and bootcpus is set, the more restrictive of the
> two are booted.

What for? 'maxcpus' is a debug hack at best and outright dangerous on
certain architectures. Why do we need more of that? Just let the machine
boot and offline the CPUs from user space.

Thanks,

        tglx
