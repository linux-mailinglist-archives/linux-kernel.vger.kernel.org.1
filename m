Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9F22A420
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgGWBA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 21:00:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33053 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728607AbgGWBA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:00:56 -0400
Received: (qmail 1334189 invoked by uid 1000); 22 Jul 2020 21:00:55 -0400
Date:   Wed, 22 Jul 2020 21:00:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: Re: [PATCH] usb: gadget: net2280: fix memory leak on probe error
 handling paths
Message-ID: <20200723010055.GA1333715@rowland.harvard.edu>
References: <20200721201558.20069-1-novikov@ispras.ru>
 <20200722141741.GA1310843@rowland.harvard.edu>
 <2097231595446720@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2097231595446720@mail.yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:56:09PM +0300, Evgeny Novikov wrote:
> Hi Alan,
> 
> I have neither an appropriate hardware nor an experience to deal with 
> issues that you mentioned. Our framework does not allow to detect them 
> as well at the moment. At last, it seems that rather many drivers can 
> suffer from these issues. So, it would be much better if somebody else 
> will suggest necessary fixes and test them carefully.

Heh...  Working from home, I no longer have access to the appropriate 
hardware either.  But at least I do have the necessary experience.  :-)

> BTW, you have already discussed the race within net2280_remove() with 
> my colleague about 3 years ago. But you did not achieve a consensus at 
> that time and no fixes were made after all.

I don't recall that.  Do you have a pointer to the email thread in the 
archives?

> Anyway, one can consider both issues independently on the one fixed by 
> the patch.

Yes.  I'll write and submit a series of patches.

Alan Stern
