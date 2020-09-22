Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25DF273A33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgIVFgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:36:55 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42064 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgIVFgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:36:51 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 08M5MRpj016410;
        Tue, 22 Sep 2020 07:22:27 +0200
Date:   Tue, 22 Sep 2020 07:22:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     poeschel@lemonage.de
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 28/32] auxdisplay: hd44780: Remove clear_fast
Message-ID: <20200922052227.GA16386@1wt.eu>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-29-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144645.2061313-29-poeschel@lemonage.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Mon, Sep 21, 2020 at 04:46:40PM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> We remove the hd44780_clear_fast (display) clear implementation. charlcd
> will fall back to use hd44780_common_clear_display then, which is much
> much faster.

I might have got confused, but it looks to me like patches 27 and 28
basically undo patch 26: in 26 you moved code to hd44780 and wrote a
fallback, just to later delete that code.

I seem to remember that the reason for the clear_fast() implementation
is that the default clear_display() is quite slow for small displays,
compared to what can be achieved by just filling the display with spaces
(in the order of tens of milliseconds vs hundreds of microseconds). But
I could be mistaken given how old this is, so please take my comment
with a grain of salt.

Willy
