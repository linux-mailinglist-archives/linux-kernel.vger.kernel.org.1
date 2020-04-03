Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8C19D7F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgDCNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 09:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDCNrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:47:13 -0400
Received: from twin.jikos.hovorcovice.czf (twin.jikos.cz [91.219.245.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E97206E9;
        Fri,  3 Apr 2020 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585921632;
        bh=dEnckuhZnIQTDk6pcJdx9stHliKmut/qn0rZ/0fwDtw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kQ/BqlStrRrvoFknUJhkiZTlM1tER5L8skFXd5UFfWVXZVDragSDkZlB2/6162swd
         2rjIrGDCpUgRQQuGkv2N9giOnnPwn2uIW5z8I38zz3fMD92NcWbLXmztj0DUYYbBcY
         lzcLRoD4fp1ZpUZ0TAwdOGRIbVw6SOqu7w9/wlxA=
Date:   Fri, 3 Apr 2020 15:46:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
In-Reply-To: <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
Message-ID: <nycvar.YEU.7.76.2004031546080.7494@gjva.wvxbf.pm>
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com> <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com> <87v9mioj5r.fsf@nanos.tec.linutronix.de>
 <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Linus Torvalds wrote:

> Btw, do you guys have some better object code comparison thing than my
> "objdump plus a few sed scripts to hide code movement effects"

FWIW, I am routinely using Joerg's

	https://github.com/joergroedel/asmtool

for exactly this.

-- 
Jiri Kosina
SUSE Labs
