Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3597C273A32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgIVFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:36:50 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42064 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgIVFgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:36:50 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 08M5R1q2016413;
        Tue, 22 Sep 2020 07:27:01 +0200
Date:   Tue, 22 Sep 2020 07:27:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     poeschel@lemonage.de
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 31/32] auxdisplay: charlcd: Do not print chars at end
 of line
Message-ID: <20200922052701.GB16386@1wt.eu>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-32-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144645.2061313-32-poeschel@lemonage.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 04:46:43PM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> Skip printing characters at the end of a display line. This fits to the
> behaviour we already had, that the cursor is nailed to last position of
> a line.

Just very old memories, but wasn't this used with the ability to shift
the display ? IIRC the HD44780 has a 2x64 chars buffer and you can make
the buffered characters appear when you shift the display. That's akin
to seeing the display as an adjustable window over the buffer. I don't
remember having used that feature, so if it didn't previously work, please
disregard my comment, I just want to be sure we don't break a feature
others might be relying on.

Willy
