Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84176257FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHaRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 13:33:12 -0400
Received: from mail.ispras.ru ([83.149.199.84]:45078 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHaRdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:33:12 -0400
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 72BAF40D4004;
        Mon, 31 Aug 2020 17:33:09 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 31 Aug 2020 20:33:09 +0300
From:   lutovinova@ispras.ru
To:     peter.senna@gmail.com
Cc:     martin.donnelly@ge.com, martyn.welch@collabora.co.uk,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, lutovinova@ispras.ru
Subject: fotg210-udc: Error in type cast in fotg210_in_fifo_handler()
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b8b01720ee550840c7c0fc39d3e9e5f9@ispras.ru>
X-Sender: lutovinova@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If in fotg210_udc_probe() after initialization 
INIT_LIST_HEAD(&ep->queue)
and after a registration of an interrupt handler in fotg210_irq()
fotg210_in_fifo_handler() is calling then in fotg210_in_fifo_handler()
list_entry() tries to get struct fotg210_request from ep->queue.next, 
but
after initialization ep->queue.next is from struct fotg210_udc.

Also this problem appears in  fotg210_out_fifo_handler().

In fotg210_ep0in() and fotg210_ep0out()
there is checking by list_empty() before calling list_entry ().

Found by Linux Driver Verification project (linuxtesting.org).
