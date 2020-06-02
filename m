Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91D91EB380
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 04:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFBCth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 22:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgFBCth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:49:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 847562068D;
        Tue,  2 Jun 2020 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591066176;
        bh=c8rJ66oPk+P+BJheKqWDDI9HoB7rPissm2/CA+EDED4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sp/xx56iLz4aACaVjIeO1JEGzPKVSovJ8TZMuCXkhzkzezVQGXwKmLKSr3huJpTpK
         mplUAcl9wif8Tg0qvT7esP1H8hZxx+91z183ltJeI4qSjdsfnC4ihG4WJZ6tii/c4N
         EKf3q+m2r38rEjIlPvZqdJ7G0i3iDLg+QojyIgkw=
Date:   Mon, 1 Jun 2020 19:49:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200601194936.244303d858d2d0c47fc87821@linux-foundation.org>
In-Reply-To: <20200602013332.GY1079@brightrain.aerifal.cx>
References: <20200424221948.1120587-1-arnd@arndb.de>
        <20200507143552.GA28683@infradead.org>
        <20200528054600.GA29717@infradead.org>
        <20200528161416.GY1079@brightrain.aerifal.cx>
        <20200529143059.GA25475@infradead.org>
        <20200529175335.GK1079@brightrain.aerifal.cx>
        <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
        <20200601181259.GV1079@brightrain.aerifal.cx>
        <20200602013332.GY1079@brightrain.aerifal.cx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 21:33:32 -0400 Rich Felker <dalias@libc.org> wrote:

> Hmm, it looks like Andrew Morton just pulled most of these into -mm,
> apparently independently of me getting them in my for-next a few hours
> ago, since his versions lack my signed-off-by. That's ok though, as
> long as they go up. Some details since further action is needed on a
> few:

It would be better if these were to go via the sh tree.  So please go
ahead and merge them up - I'll drop my copies when they turn up in
-next via the sh tree.

