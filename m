Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA022AF460
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKKPFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:05:04 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47455 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgKKPFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:05:03 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0ABF4rYp009431;
        Wed, 11 Nov 2020 16:04:53 +0100
Date:   Wed, 11 Nov 2020 16:04:53 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Christian Hesse <list@eworm.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 5.9.8
Message-ID: <20201111150453.GA9427@1wt.eu>
References: <1605041246232108@kroah.com>
 <20201111153604.6a4fb08c@leda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111153604.6a4fb08c@leda>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:36:04PM +0100, Christian Hesse wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> on Tue, 2020/11/10 21:56:
> > I'm announcing the release of the 5.9.8 kernel.
> 
> This is not yet linked on kernel.org - same goes for lts version 5.4.77.
> I guess this is not by intention, no?

Strange, both are indeed not listed on kernel.org but are available in
the download directory and can be retrieved from there:

    https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/
    https://cdn.kernel.org/pub/linux/kernel/v5.x/

Maybe it's just the bot that updates the front page that was stopped.

Willy
