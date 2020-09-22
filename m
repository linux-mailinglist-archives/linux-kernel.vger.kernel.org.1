Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C4273A30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgIVFb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:31:58 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42062 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgIVFb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:31:58 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 01:31:57 EDT
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 08M5Vsvu016420;
        Tue, 22 Sep 2020 07:31:54 +0200
Date:   Tue, 22 Sep 2020 07:31:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     poeschel@lemonage.de
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/33] Make charlcd device independent
Message-ID: <20200922053154.GC16386@1wt.eu>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144645.2061313-1-poeschel@lemonage.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Mon, Sep 21, 2020 at 04:46:12PM +0200, poeschel@lemonage.de wrote:
> This tries to make charlcd device independent. At the moment hd44780
> device specific code is contained deep in charlcd. This moves this out
> into a hd44780_common module, where the two hd44780 drivers we have at
> the moment (hd44780 and panel) can use this from. The goal is that at
> the end other drivers can use the charlcd interface.
> I add one such driver at the end with the last patch.
> I submitted this already some time ago [1], where the wish was so split
> this into smaller chunks what I try to do with this new patchset.
> Most of the patches pick one specific function in charlcd and move the
> device specific code into hd44780_common.

Regardless of my two comments, this series looks very clean to me, nice
job! For 1..32, feel free to add: Reviewed-by: Willy Tarreau <w@1wt.eu>

Just be careful in your commit messages, I spotted a few "it's own"
instead of "its own", but that's a very minor detail :-)

Willy
