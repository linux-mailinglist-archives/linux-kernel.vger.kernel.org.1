Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A193C1F9A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgFOOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 10:42:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54033 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730565AbgFOOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:42:58 -0400
Received: (qmail 18788 invoked by uid 1000); 15 Jun 2020 10:42:57 -0400
Date:   Mon, 15 Jun 2020 10:42:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH v2] usb: replace hardcode maximum usb string length by
 definition
Message-ID: <20200615144257.GA18707@rowland.harvard.edu>
References: <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
 <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:17:35PM +0800, Macpaul Lin wrote:
> Replace hardcode maximum usb string length (126 bytes) by definition
> "MAX_USB_STRING_LEN".
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
> Changes for v2:
>   - Add definition "MAX_USB_STRING_LEN" in ch9.h instead of in usb.h.
>     Thanks for Alan's suggestion.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
