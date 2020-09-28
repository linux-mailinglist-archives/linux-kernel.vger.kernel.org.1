Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAD27B40F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgI1SFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:05:55 -0400
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:52797
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgI1SFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:05:54 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 14:05:54 EDT
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id 9BCF71430A404; Mon, 28 Sep 2020 19:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1601315997; bh=zxamZpi3kSU9G+GXTPakbJErD/WY1mYQwmtEPBU7ZC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1HF5W8sg+Fx0UJpLZCZ4nPr3K28U4Tme52Fa1L3eyBgZ1+7l6BNktaLBxaUzmHCX
         iIVvXyJlDX11mF7UVoF0VC+jrfJXnSJuH8LSwzDNsaOcwv6PsbrPR8tnxy40B8EOId
         CnPg76oQLTLGf0P/9b1tuFS3yq1bELL+2cJO3kfizuFRpWRDCRwe8QnpvfUkVvub2Q
         NKY99T2dOSISEmCjhimA9az6bAg037O798uHbsHDOguRZCgYsDkhsYTranteGdKPBi
         QA2V+E8aLjQvguwb8IKpDahCjakN3nBaCAvt1BoZo8i1IXmxD2FRYvAqxtN0rbCovS
         Z32aAWOHEZnQw==
Date:   Mon, 28 Sep 2020 19:59:56 +0200
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>,
        b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
Message-ID: <20200928175956.GF24673@neutronstar.dyndns.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> 

It seems this is/was used by "svgatextmode" which seems to be at
http://www.ibiblio.org/pub/Linux/utils/console/

Not sure if that kind of software still has a chance to work nowadays.

 - Martin Hostettler
