Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08829D73C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgJ1WW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732650AbgJ1WWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FEC24699;
        Wed, 28 Oct 2020 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603877875;
        bh=BkH7NGQ3stg8sHIeUQW/CzjagGjDM1DLytvfTkbinSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=07Myxs/VbHsC6gZKtmfqw6TVY/h07QGwzR+LugaP6ilLnVi5V7AQD6SggKikQ1ZRc
         y172F1gCKTpsYMp2PErCZQFbhxGMD4I8KWCR/xfpYcZvARpv4Xz8ncb5+/SIOJ42n/
         Ls6qCxpEm2G2Hwh/bOeX4gOLspjxW5dUlJhXxARk=
Date:   Wed, 28 Oct 2020 10:38:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] USB: serial: keyspan_pda: fix up write
 implementation
Message-ID: <20201028093848.GD1953863@kroah.com>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 06:45:46PM +0100, Johan Hovold wrote:
> This series fixes a number of long-standing issues with the keyspan_pda
> driver and reworks its write implementation so that it can be used with
> any line discipline or for a system console.
> 
> The last few patches cleans up the xircom device support and some style
> issues.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
