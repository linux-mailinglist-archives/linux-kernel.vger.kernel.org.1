Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFA26B7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgIPAdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgIONnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:43:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334E8C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:18:12 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:16:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600175820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eTf/Xpvfci7Uom1nuV/bQXtf6AOiQbHvzQmjt+WjQ8=;
        b=zoQWhKAXurLmGNUeXwn4LAA1uazNAWTunzszVEicbhhcWTa4/EImWJlPyx7uhhD3lBz/BT
        aReEIfh8SGlRSgaQ163pEEtjt1J65UEgOOSyRn+KsMtOfjGXt8jxbIeEAvbyUm06oeIhkN
        wEhKwOqnRS0ig1L6NVSPHOUeks86rJxdxQud927wXWPL7l1MMp8atnI6X9FJV8p3OgjKsF
        7/AEqbKLws+CjRnq+SfyQWPYaWs3G1jOpGE3mLs/VNNS5qQso0MyUa+NjzY4lBZk6LndHS
        Zc6MVkSk4Lf2yoypH26RRGnaCe8mrwWgdxK9RFVcy5y8bPjRKXoQBKDDbzI/xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600175820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eTf/Xpvfci7Uom1nuV/bQXtf6AOiQbHvzQmjt+WjQ8=;
        b=Oh48LeP9lV1jxaOpMt1xFuluXXSjSy1LN05MBV32lhS4mnaKAo9FMphFGF43jwFouqUmn3
        o+iXr+rUPVo/GhCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Make the space reserved for the pid wider
Message-ID: <20200915131658.ob4dptbptg2wj57j@linutronix.de>
References: <20200904082331.dcdkrr3bkn3e4qlg@linutronix.de>
 <20200915104648.hac2ljgzrqc7z244@linutronix.de>
 <20200915090520.2047abe8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200915090520.2047abe8@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-15 09:05:20 [-0400], Steven Rostedt wrote:
> Hi Sebastian,
Hi Steven,

> I'm still buried in email from my PTO, with lots of patches I need to
> review and apply (or comment on). And I'm also behind in internal work
> affairs. I'm not ignoring this, just taking some time to get to it :-/

Sorry, I forgot that PTO part=E2=80=A6

> -- Steve

Sebastian
