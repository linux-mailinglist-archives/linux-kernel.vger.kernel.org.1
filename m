Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE52CFC7D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgLEST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:19:58 -0500
Received: from netrider.rowland.org ([192.131.102.5]:55771 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728247AbgLESCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:02:54 -0500
Received: (qmail 1179704 invoked by uid 1000); 5 Dec 2020 10:15:11 -0500
Date:   Sat, 5 Dec 2020 10:15:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Minh =?iso-8859-1?B?Qvlp?= Quang <minhquangbui99@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: dummy-hcd: Fix uninitialized array use in init()
Message-ID: <20201205151511.GA1179536@rowland.harvard.edu>
References: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com>
 <20201204161249.GA1141609@rowland.harvard.edu>
 <CACtPs=Gg3C0KxdFnETHujAyis4hhKnCdV4_ZWqprHkXCXahFvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACtPs=Gg3C0KxdFnETHujAyis4hhKnCdV4_ZWqprHkXCXahFvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 07:47:01PM +0700, Minh Bùi Quang wrote:
> Vào Th 6, 4 thg 12, 2020 vào lúc 23:12 Alan Stern
> <stern@rowland.harvard.edu> đã viết:
> > Does this initialization end up using less memory than an explicit
> > memset() call?
> 
> You mean speed?

No, I mean memory space.

A memset call requires a certain amount of instruction space (to push 
the arguments and make the call) but no static data space.  
Initialization requires some instruction space (to copy the data) and 
static data space as well (to hold the data that is to be copied).

Alan Stern

> In my opinion, there is no difference in speed between 2 ways.
> When I compile this array initialization using gcc 5.4.0,  this
> initialization becomes
> mov instructions when MAX_NUM_UDC=2 and becomes rep stos when
> MAX_NUM_UDC=32. I think it makes no difference when comparing with memset()
> 
> Thanks,
> Quang Minh
