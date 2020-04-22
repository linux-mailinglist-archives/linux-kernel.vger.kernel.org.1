Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8C1B4CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDVSni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDVSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:43:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73899C03C1A9;
        Wed, 22 Apr 2020 11:43:38 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRKLP-0006iR-64; Wed, 22 Apr 2020 20:43:35 +0200
Date:   Wed, 22 Apr 2020 20:43:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.4-rt3
Message-ID: <20200422184335.pdqtv6643wntpxcy@linutronix.de>
References: <20200416164510.kbrklqahdng5uhij@linutronix.de>
 <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
 <20200422181232.a33sfm6udmy2zcvy@linutronix.de>
 <20200422183112.nfbxob7gv33fsqgp@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422183112.nfbxob7gv33fsqgp@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-22 20:31:12 [+0200], Daniel Wagner wrote:
> Correct, all tests pass and from a quick glance there are no backtraces in the
> logs. IIRC, lava detects warnings and backtraces in the logs and marks them as
> error.
> 
> v5.6.4-rt seems to be in a good shape as far my quick tests tell me.

Oki, thanks.

Sebastian
