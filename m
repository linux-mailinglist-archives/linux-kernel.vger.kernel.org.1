Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9EF257141
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 02:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHaAoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 20:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgHaAoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:44:11 -0400
Received: from X1 (unknown [65.49.58.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10C9207BB;
        Mon, 31 Aug 2020 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598834651;
        bh=6LFPsle47n36rc0FcyNKsEGD+oQ4SDQDYywUFSKldSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FqO+brb/S1ZYZR+ybuH+M8gh/BEZ8/GsluEaod9qSVDzwNgYPGNyU7DDH2mFQJtGk
         1rt59pZPUr/dPHYYhq9IJH9JCvqG/i49ZHYaUV8gikAXPEDtE0GC2ilTIEc2ySqG8J
         bmXa2J5CykCnsfwLD9XSikkCFf2IWpjf+0P9Yy9s=
Date:   Sun, 30 Aug 2020 17:44:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mrinal Pandey <mrinalmni@gmail.com>
Cc:     skhan@linuxfoundation.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, keescook@chromium.org, re.emese@gmail.com,
        maennich@google.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: Re: [PATCH] scripts: Add intended executable mode and SPDX license
Message-Id: <20200830174409.c24c3f67addcce0cea9a9d4c@linux-foundation.org>
In-Reply-To: <20200827092405.b6hymjxufn2nvgml@mrinalpandey>
References: <20200827092405.b6hymjxufn2nvgml@mrinalpandey>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 14:54:05 +0530 Mrinal Pandey <mrinalmni@gmail.com> wrote:

> commit b72231eb7084 ("scripts: add spdxcheck.py self test") added the file
> spdxcheck-test.sh to the repository without the executable flag and license
> information.

The x bit shouldn't matter.

If someone downloads and applies patch-5.9.xz (which is a supported way
of obtaining a kernel) then patch(1) will erase the x bit anyway.

Is some other script invoking spdxcheck-test.sh directly, instead of
using `/bin/sh spdxcheck-test.sh'?  If so, please let's fix that.
