Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A31A6CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbgDMUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 16:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387774AbgDMUJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:09:30 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4A72063A;
        Mon, 13 Apr 2020 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586808568;
        bh=zrpaTO626U3khMEyvZcZ5u056Jg+wZrdt1dCTBdvMP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPhI/EJZTitmciKYOuOh0Q5SS15IOIyn7/uF87GAEi1Jkm7m/rd0x92otJbc5QOYc
         p4hdKBrpiStoNBKXuZFxKSHa531USh0ZXIbJGy5LHomZSxfWl0j8ww6YCDEtvy9Jxm
         DNG6wf02C3ESWdsSN3+w6rhnHJyUoGWpw40zLgnA=
Date:   Mon, 13 Apr 2020 13:09:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH] MAINTAINERS: add an entry for kfifo
Message-Id: <20200413130928.f83d06c271f4131874d60334@linux-foundation.org>
In-Reply-To: <20200413104250.26683-1-brgl@bgdev.pl>
References: <20200413104250.26683-1-brgl@bgdev.pl>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 12:42:50 +0200 Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> I'm not sure why this patch hasn't made it into v5.7 - it's been in next
> for weeks now. :(

I was awaiting Stefani's ack, which we now have.
