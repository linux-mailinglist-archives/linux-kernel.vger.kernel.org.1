Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5771D74A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgERKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 06:01:48 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50097 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:01:47 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6F727200017;
        Mon, 18 May 2020 10:01:45 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/3] TTY improve n_gsm support
In-Reply-To: <20200518084517.2173242-4-gregory.clement@bootlin.com>
References: <20200518084517.2173242-1-gregory.clement@bootlin.com> <20200518084517.2173242-4-gregory.clement@bootlin.com>
Date:   Mon, 18 May 2020 12:01:45 +0200
Message-ID: <87ftbxfto6.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hello,
>
> This series is the second version of patch improving n_gms support
> especially with TELIT LE910. However the fix should benefit to any
> modem supporting cmux.

You can just ignore the emails from this point, I forgot to remove the
remaining .patch!

Sorry for the noise

Gregory

>
> The first patch is just about improving debugging output.
>
> The second one removes a tty optimization which make the LE910 hang.
>
> The last one fixes an issue observed on the LE910 but should benefit
> to all the modem. We observed that pretty quickly the transfer done
> using the virtual tty were blocked. We found that it was due of a
> wakeup to the real tty. Without this fix, the real tty wait for
> indefinitely.
>
> Thanks to Jiri Slaby for the review.
>
> Changelog:
>  v1 -> v2:
>  - don't replace the pr_info by pr_debug
>  - remove the superfluous printk("\n");
>  - use --follow option with git log to find the original commit to fix
>  - use tty_port_tty_wakeup
>  - use 'for' loop instead of 'while'
>
> Gregory
>
> Gregory CLEMENT (3):
>   tty: n_gsm: Improve debug output
>   tty: n_gsm: Fix SOF skipping
>   tty: n_gsm: Fix waking up upper tty layer when room available
>
>  drivers/tty/n_gsm.c | 48 +++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
>
> -- 
> 2.26.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
