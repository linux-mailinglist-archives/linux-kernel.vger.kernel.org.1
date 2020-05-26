Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0541AB2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438319AbgDOUsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 16:48:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:52640 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438047AbgDOUsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:48:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F2D91739;
        Wed, 15 Apr 2020 20:48:52 +0000 (UTC)
Date:   Wed, 15 Apr 2020 14:48:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: timekeeping: Use correct prototype for deprecated
 functions
Message-ID: <20200415144851.4ae5c041@lwn.net>
In-Reply-To: <CAK8P3a1Ktqne6vB0kFR+CuRgFjsRDCoXsndo-G9JSRaCv_qHfQ@mail.gmail.com>
References: <20200414221222.23996-1-chris.packham@alliedtelesis.co.nz>
        <CAK8P3a1Ktqne6vB0kFR+CuRgFjsRDCoXsndo-G9JSRaCv_qHfQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 10:10:50 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Apr 15, 2020 at 12:12 AM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> >
> > Use the correct prototypes for do_gettimeofday(), getnstimeofday() and
> > getnstimeofday64(). All of these returned void and passed the return
> > value by reference. This should make the documentation of their
> > deprecation and replacements easier to search for.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>  
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.

jon
