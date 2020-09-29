Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931C27C2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgI2KwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:52:06 -0400
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:49477
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgI2KwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:52:05 -0400
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id 95E361430A410; Tue, 29 Sep 2020 12:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1601376723; bh=S4qRhmQnANACcgAsVG/DL9GYSVFl4YpEydWlE5Zr2Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ5SCbFzDRm4dN6U+6m/9xGYPd9nKBC0cDUYWnO70jRjSK1W6dsLgFyeYAHhRRkK4
         hGvGy2CfTg+VS/p2BwjSZvM7VU/0YSpcRkDH2kyYOHmIr6gi1q3vz/cWxZiySJHhsj
         /QdFJQt/aJOQqzNYzWtK5xjTmBCa2JSOFUnjnlpVbzDVH/WYHFlIbUpSPfJJVi/Ofv
         bPPRXvGYyq2xbfho+O+8CxyeN5ryfqTSejVkrZBp4whlcwSwAsqReID7WjQNgUbk8p
         lCTmS673EGxk/BpX9j7jzcaISeLJq44r+QtnpNnjeZP/RSw3x9GbctyGQawjVtn5F8
         vvfWOcjWk3/Hw==
Date:   Tue, 29 Sep 2020 12:52:03 +0200
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Martin Hostettler <textshell@uchuujin.de>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>,
        b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
Message-ID: <20200929105203.GG24673@neutronstar.dyndns.org>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
 <20200928175956.GF24673@neutronstar.dyndns.org>
 <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:12:46AM +0900, Tetsuo Handa wrote:
> On 2020/09/29 2:59, Martin Hostettler wrote:
> > On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
> >> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> >> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> >>
> > 
> > It seems this is/was used by "svgatextmode" which seems to be at
> > http://www.ibiblio.org/pub/Linux/utils/console/
> > 
> > Not sure if that kind of software still has a chance to work nowadays.
> > 
> 
> Thanks for the information.
> 
> It seems that v.v_vlin = curr_textmode->VDisplay / (MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1)
> and v.v_clin = curr_textmode->FontHeight . Thus, v.v_clin is font's height and seems to be non-zero.
> But according to https://bugs.gentoo.org/19485 , people are using kernel framebuffer instead.
> 

Yes, this seems to be from pre framebuffer times.

Back in the days "svga" was the wording you got for "pokes svga card
hardware registers from userspace drivers". And textmode means font
rendering is done via (fixed function in those times) hardware scanout
engine. Of course having only to update 2 bytes per character was a huge
saving early on. Likely this is also before vesa VBE was reliable.

So i guess the point where this all starts going wrong allowing the X parts
of the api to be combined with FB based rendering at all? Sounds the only
user didn't use that combination and so it was never tested?

Then again, this all relates to hardware from 20 years ago...

 - Martin Hostettler
