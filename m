Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158022C21A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbgKXJhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:37:02 -0500
Received: from verein.lst.de ([213.95.11.211]:53607 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbgKXJhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:37:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB23F67373; Tue, 24 Nov 2020 10:36:58 +0100 (CET)
Date:   Tue, 24 Nov 2020 10:36:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <20201124093658.GA13174@lst.de>
References: <cover.1606137108.git.linux@leemhuis.info> <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info> <20201124091852.GB11695@lst.de> <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:31:33AM +0100, Thorsten Leemhuis wrote:
> Am 24.11.20 um 10:18 schrieb Christoph Hellwig:
>> On Tue, Nov 24, 2020 at 09:00:01AM +0100, Thorsten Leemhuis wrote:
>>> For context: Patch 2 of this series adds a text to the Documentation/ directory
>>> which (for now) uses "GPL-2.0+ OR CC-BY-4.0", as I want to make it easy and
>>> attractive for others to base their work on it. I'm not strongly attached to
>>> CC-BY-4.0, but it seemed like the best choice: it's designed for such usage and
>>> afaics better than using MIT for text files.
>>
>> And you've not Cced me on that patch 2 or patch 3, which makes Ccing
>> me on this pretty useless as I can't judge the context.
>
> Argh, sorry, slipped through. You can find it here:
>
> https://lore.kernel.org/linux-doc/2f314e58cb14c1579f843f8c72bdb4bbb83ac20a.1606137108.git.linux@leemhuis.info/
>
> FWIW, here it is for easy access (just sent with thunderbird instead of
> git send-mail, hopefully should be enough for this):

So what is so special with this documentation that it needs a
(for the kernel tree) unusual license?  How to we make sure people
don't accidentally end up including things they can't?
