Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2E12D05D8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgLFQHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:07:51 -0500
Received: from netrider.rowland.org ([192.131.102.5]:54057 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726547AbgLFQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:07:51 -0500
Received: (qmail 1213044 invoked by uid 1000); 6 Dec 2020 11:07:09 -0500
Date:   Sun, 6 Dec 2020 11:07:09 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: dummy-hcd: Fix uninitialized array use in init()
Message-ID: <20201206160709.GA1212872@rowland.harvard.edu>
References: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com>
 <20201204161249.GA1141609@rowland.harvard.edu>
 <CACtPs=Gg3C0KxdFnETHujAyis4hhKnCdV4_ZWqprHkXCXahFvw@mail.gmail.com>
 <20201205151511.GA1179536@rowland.harvard.edu>
 <20201206112405.GB3006@minh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201206112405.GB3006@minh>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 06:24:05PM +0700, Bui Quang Minh wrote:
> On Sat, Dec 05, 2020 at 10:15:11AM -0500, Alan Stern wrote:
> > On Sat, Dec 05, 2020 at 07:47:01PM +0700, Minh Bùi Quang wrote:
> > > Vào Th 6, 4 thg 12, 2020 vào lúc 23:12 Alan Stern
> > > <stern@rowland.harvard.edu> đã viết:
> > > > Does this initialization end up using less memory than an explicit
> > > > memset() call?
> > > 
> > > You mean speed?
> > 
> > No, I mean memory space.
> > 
> > A memset call requires a certain amount of instruction space (to push 
> > the arguments and make the call) but no static data space.  
> > Initialization requires some instruction space (to copy the data) and 
> > static data space as well (to hold the data that is to be copied).
> > 
> > Alan Stern
> > 
> 
> Thank you for your clarification, I didn't think about it before.
> 
> As I check when compiling the code, with MAX_NUM_UDC=32 the initialization
> becomes
> 
>         xor    eax,eax
>         mov    ecx,0x40
>         rep stos DWORD PTR es:[rdi],eax
> 
> With MAX_NUM_UDC=2, the initialization becomes
> 
>         mov    QWORD PTR [rbp-0x30],0x0
>         mov    QWORD PTR [rbp-0x28],0x0
> 
> As I see, initialization does not require additional static data space.
> Am I right?

Ah, okay, good.  I didn't realize the compiler was smart enough to do 
this.  Thanks for checking.

Alan Stern
