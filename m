Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F12EABA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbhAENPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAENPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:15:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72592229EF;
        Tue,  5 Jan 2021 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609852469;
        bh=wlbXdg6aRtpgKOPhZD6u58GmHEX7rXwhsiEi0BFoGUA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FFvV6gPH/dp3pR/eYC7RAni2FwPHbLeBH1AgxWnXbXN3vP98pMigiUNczCiBzxqOm
         KUhsanU8V2BDwuRW6ObwvTsXGP5dSDzoahPobzpSMOe1wlhLxrWyQHMUdvAoRZ9fV7
         xNV8uo9lch1xLBp/Fqw+sY1PNhhnnbT8Uv9aNMfGPrP96QgpP/wdiNXWHtSwgGD1gk
         C4KGbPbI6THsxwtH0POumuKzhzkeOmxHpuOdk4JULmzHLTQTXSPi6ihuQXAQoLJa49
         NgEkpb6pTaky+WiU7Tv8WUjOyXrQW1pErNWtVSPeE/tt6P838esJEHNsCO620APwaE
         sfCGBZKatmkGQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, peter.chen@nxp.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
In-Reply-To: <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
Date:   Tue, 05 Jan 2021 15:14:24 +0200
Message-ID: <87k0srcyq7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Wesley Cheng <wcheng@codeaurora.org> writes:
> +void composite_reset(struct usb_gadget *gadget)
> +{
> +	/*
> +	 * Section 1.4.13 Standard Downstream Port of the USB battery charging
> +	 * specification v1.2 states that a device connected on a SDP shall only
> +	 * draw at max 100mA while in a connected, but unconfigured state.

The requirements are different, though. I think OTG spec has some extra
requirements where only 8mA can be drawn max. You need to check for the
otg flag. Moreover, USB3+ spec has units of 150mA meaning the device
can't draw 100mA (IIRC).

-- 
balbi
