Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6615827D400
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgI2Q5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgI2Q5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:57:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47EC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:57:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so5356456wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQq4copkzrTWJFWPrIjoaGpC7LzDugYFHrKyuAj+WCk=;
        b=MzZghrQtN3nF8Y/lUEqyS+JQazMX4C8+eDh7eh/JV1dh3GOplVIGXXBw19lWPfy3ie
         4KC69ffpLyrDofRK+U2y6PDp9oQE6MdrBUO29+NC4yMyvU8RzsbuzWKxPr26qCD5YsPr
         R42W/BKz4oQEgnTPwd62+BkpjZfezYgWC17ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nQq4copkzrTWJFWPrIjoaGpC7LzDugYFHrKyuAj+WCk=;
        b=goT+/x1ipPH8enb8pa0OX7s+yU9PeHCsRESGs7C/SNycKLG59Bh8AtAcR+OALw0Pxy
         kTk+DWHhRSmNAxHEhR3N5KjJIx95yW/LNYqbTzfZGamqMK43zWtXxnYpvb8GmJVZnrcM
         UunSKI5MQA2MWmh6V+M6Q3wUVZEkzxHMfvyvmqVvEDzr98gNsDtDtANykyjugepLrWcU
         Yc46y1EcwK2iZZbqTe5uhz+oBZ4wfGPKARIahMqZ3yaGV+blA6z8aJdTaa2Qy1ckzymk
         /2jSZ+AvLydwqmRPQ4crPFUvFIs+1vl11VgeXFts4zdcOFXDiiiZMiygvKAUbySXMFm2
         WYPg==
X-Gm-Message-State: AOAM533pbnhT7Br5Vrvhlb51+JXoZM7mT5QUPohh4lCrbUxcmCm60AHt
        I21sSZ/P/9/pZqVdl6ZCfm33HA==
X-Google-Smtp-Source: ABdhPJxSWkIHkpAEXbL2VmRDFNprfEkhWbClVdbLQTZbv7RVDpq4HuSembcT2Wrqfw7IxPzBCnBXdw==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr5501099wmc.142.1601398620840;
        Tue, 29 Sep 2020 09:57:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u126sm8002518wmu.9.2020.09.29.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 09:56:59 -0700 (PDT)
Date:   Tue, 29 Sep 2020 18:56:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Martin Hostettler <textshell@uchuujin.de>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <20200929165657.GS438822@phenom.ffwll.local>
Mail-Followup-To: Martin Hostettler <textshell@uchuujin.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>,
        b.zolnierkie@samsung.com, deller@gmx.de,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>
References: <000000000000226d3f05b02dd607@google.com>
 <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN>
 <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
 <20200928175956.GF24673@neutronstar.dyndns.org>
 <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
 <20200929105203.GG24673@neutronstar.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929105203.GG24673@neutronstar.dyndns.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 12:52:03PM +0200, Martin Hostettler wrote:
> On Tue, Sep 29, 2020 at 10:12:46AM +0900, Tetsuo Handa wrote:
> > On 2020/09/29 2:59, Martin Hostettler wrote:
> > > On Sun, Sep 27, 2020 at 08:46:30PM +0900, Tetsuo Handa wrote:
> > >> VT_RESIZEX was introduced in Linux 1.3.3, but it is unclear that what
> > >> comes to the "+ more" part, and I couldn't find a user of VT_RESIZEX.
> > >>
> > > 
> > > It seems this is/was used by "svgatextmode" which seems to be at
> > > http://www.ibiblio.org/pub/Linux/utils/console/
> > > 
> > > Not sure if that kind of software still has a chance to work nowadays.
> > > 
> > 
> > Thanks for the information.
> > 
> > It seems that v.v_vlin = curr_textmode->VDisplay / (MOFLG_ISSET(curr_textmode, ATTR_DOUBLESCAN) ? 2 : 1)
> > and v.v_clin = curr_textmode->FontHeight . Thus, v.v_clin is font's height and seems to be non-zero.
> > But according to https://bugs.gentoo.org/19485 , people are using kernel framebuffer instead.
> > 
> 
> Yes, this seems to be from pre framebuffer times.
> 
> Back in the days "svga" was the wording you got for "pokes svga card
> hardware registers from userspace drivers". And textmode means font
> rendering is done via (fixed function in those times) hardware scanout
> engine. Of course having only to update 2 bytes per character was a huge
> saving early on. Likely this is also before vesa VBE was reliable.
> 
> So i guess the point where this all starts going wrong allowing the X parts
> of the api to be combined with FB based rendering at all? Sounds the only
> user didn't use that combination and so it was never tested?
> 
> Then again, this all relates to hardware from 20 years ago...

Imo userspace modesetting should be burned down anywhere we can. We've
gotten away with this in drivers/gpu by just seamlessly transitioning to
kernel drivers.

Since th only userspace we've found seems to be able to cope if this ioctl
doesn't do anything, my vote goes towards ripping it out completely and
doing nothing in there. Only question is whether we should error or fail
with a silent success: Former is safer, latter can avoid a few regression
reports since the userspace tools keep "working", and usually people don't
notice for stuff this old. It worked in drivers/gpu :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
