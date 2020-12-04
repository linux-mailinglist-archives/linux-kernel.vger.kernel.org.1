Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC92CEE02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgLDMXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgLDMXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:23:07 -0500
Date:   Fri, 4 Dec 2020 13:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607084547;
        bh=5OtuoZcRnAswo0cWnYCAPv33DNXGwiLq6bVWVMztwGA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2u7lEDGtdmRl3wFlrQ0BLDuvfEjaDUugHFqUgqF4IGKhwgq0Q0uuPNXuq2CPU4dE
         h62IgBPk0bwd/Ix1D0ewSM08HSis1FzXB0qPicTfTR1eQb37MIk5s70+YB3PfZTI3h
         SReVXE0CgYMUNtWUl2QhMugRt4Loft7MUlLbLZdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <X8oqTyRNKMHChbA7@kroah.com>
References: <cover.1607063223.git.linux@leemhuis.info>
 <7115b6c20ae3e6db0370fe4002dd586011205e1c.1607063223.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7115b6c20ae3e6db0370fe4002dd586011205e1c.1607063223.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 07:43:48AM +0100, Thorsten Leemhuis wrote:
> Add the full text of the CC-BY-4.0 license to the kernel tree as well as
> the required tags for reference and tooling.
> 
> The license text was copied directly from the following url, but for
> clarification a 'Creative Commons' was added before 'Attribution 4.0
> International' in the first line:
> https://creativecommons.org/licenses/by/4.0/legalcode.txt
> 
> CC-BY-4.0 is GPLv2 compatible, but when for example used for the
> kernel's documentation it can easily happen that sphinx during
> processing combines it with text or code from files using a more
> restrictive license[1]. This bears pitfalls, hence point that risk out
> and suggest to only use this license in combination with the GPLv2.
> 
> [1] https://lkml.kernel.org/r/20201201144314.GA14256@lst.de
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Christoph Hellwig <hch@lst.de>
> ---
>  LICENSES/dual/CC-BY-4.0 | 410 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 410 insertions(+)
>  create mode 100644 LICENSES/dual/CC-BY-4.0

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
