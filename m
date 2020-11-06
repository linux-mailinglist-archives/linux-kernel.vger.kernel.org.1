Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF12AA074
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgKFWdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbgKFWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:33:14 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540D020882;
        Fri,  6 Nov 2020 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604701993;
        bh=Eh/4W7NEPV1VldWDlxVKg4wANk1kTBVCNkvRmrQbIj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a59RwQdF30Qx2/1yARH0BcRGOLF3VrNRovLw3yP6xrCyGGVJOV2hpvG8PPvYWEv0r
         jr3iZBJL6HOLaywmfcRaxYB/ZB5aPy207J/7VqgjB5ozANPAXmPepimoCgdabpdQno
         FF68Pp2cPC12LsFcqOh6WKnoHjRCueYYiylwGqqo=
Date:   Fri, 6 Nov 2020 14:33:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v2] reboot: allow to specify reboot mode via sysfs
Message-Id: <20201106143312.830f2a7410efcf397614b9d4@linux-foundation.org>
In-Reply-To: <20201106200704.192894-1-mcroce@linux.microsoft.com>
References: <20201106200704.192894-1-mcroce@linux.microsoft.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Nov 2020 21:07:04 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:

> The kernel cmdline reboot= option offers some sort of control
> on how the reboot is issued.
> Add handles in sysfs to allow setting these reboot options, so they
> can be changed when the system is booted, other than at boot time.

Please include a description of why you believe the kernel needs this
feature.  Use cases, end-user benefits, etc.

We've survived this long without it - what changed?
