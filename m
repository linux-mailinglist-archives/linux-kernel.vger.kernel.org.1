Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1CC2EBDA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbhAFMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:24:47 -0500
Received: from foss.arm.com ([217.140.110.172]:40274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAFMYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:24:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08ED3D6E;
        Wed,  6 Jan 2021 04:24:01 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4A593F70D;
        Wed,  6 Jan 2021 04:23:59 -0800 (PST)
Date:   Wed, 6 Jan 2021 12:23:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     tingwei@codeaurora.org
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Set DBGCLAIM when self-host debug is enabled
Message-ID: <20210106122356.GC26994@C02TD0UTHF1T.local>
References: <512a30e6cc6877687c10c0f9ccc3c4c5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512a30e6cc6877687c10c0f9ccc3c4c5@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 06:29:53PM +0800, tingwei@codeaurora.org wrote:
> Hi Will and Mark,

Hi Tingwei,

> In recent implementation of save/restore ARM debug registers in
> EL2/EL3, we found it's necessary to know whether self-host debug is
> enabled so EL2/EL3 can avoid saving/restoring debug registers but no
> one is using debug.

In what situation are you considering? I assume you mean idle sequences
using CPU_SUSPEND?

Generally our expectation for CPU_SUSPEND is:

* Where StateType==0, the debug state is preserved with all other
  PE state.

* Where StateType==1 and the PE returns "warm" without having entered a
  powerdown state, the debug state is preserved along with all other PE
  state.

* Where StateType==1, and the PE returns "cold" after having entered a
  powerdown state (i.e. we return via the entry point address), the
  debug state is not preserved.

... and I'm missing where you could avoid saving the state. What
situation(s) did you have in mind?

> In ARM PSCI, it has one option to set DBGCLAIM[1] to 1 to indicate
> that debug is in use by a self-host debugger. Do you think it's
> resonable to add this to Kernel?
> 
> For example, can we set DBGCLAIM[1] to 1 in enable_debug_monitors()
> and clear it in disable_debug_monitors().

I was under the impression that this was solely for the benefit of an
external debugger, and should have no functional impact on the PSCI
implementation from the kernel's PoV, so as above I think we need a
better description of the case you're trying to address.

Thanks,
Mark.
