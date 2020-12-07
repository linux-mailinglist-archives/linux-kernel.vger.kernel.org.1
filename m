Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E482D1E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLGX1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgLGX1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:27:34 -0500
Date:   Tue, 8 Dec 2020 08:26:49 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607383613;
        bh=5zNEx2PxyOOMXy7TjK1GRXG1D3Jwjiy1cQkIBAZ0HAQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=bz9MIH4534r36sqh5mdjAinyZ33lWqf/d6HPF98g5tknLOb/xcOEqrG8qwcImzuul
         GDgP5KntBedgvR/a/3IztB4vi4+Xprq0QFV2DWtjal1stYC94DeivynIfg+/qrGbW9
         O3Fj0/iiYeGjD8FR2kEqITU1kcQjKF0ZtDUiWukyE0s9IR21KDtBYdV7KEHu88Jxcx
         EW00jqW1k2McSgia4qIJkORRaIeuUTDuOXkARDnyniQUAa4jucPSzDVJAGEpCjdULV
         Ef+ndZtu5sQ6vpdH+MbVzgTrSaZ0Hw18eaVjmh5mrodlYyO0JgN8hOb0bQD0q7OnLE
         04xNFwuVZ/Big==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: Ftrace startup test and boot-time tracing
Message-Id: <20201208082649.93bdd57eb397296c81baf64c@kernel.org>
In-Reply-To: <20201207152540.2d569a36@gandalf.local.home>
References: <20201207230259.250ecc2a52281def3f8335f4@kernel.org>
        <20201207152540.2d569a36@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 7 Dec 2020 15:25:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 7 Dec 2020 23:02:59 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > There will be the 2 options, one is to change kconfig so that user can not
> > select FTRACE_STARTUP_TEST if BOOTTIME_TRACING=y, another is to provide
> > a flag from trace_boot and all tests checks the flag at runtime.
> > (moreover, that flag will be good to be set from other command-line options)
> > What would you think?
> 
> Yeah, a "disable_ftrace_startup_tests" flag should be implemented. And
> something that could also be on the kernel command line itself :-)
> 
>  "disabe_ftrace_startup_tests"
> 
> Sometimes when debugging something, I don't want the tests running, even
> though the config has them, and I don't want to change the config.

OK, BTW, I found tracing_selftest_disabled, it seemed what we need.

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
