Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D82AA3E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgKGIem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgKGIel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:34:41 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9C820704;
        Sat,  7 Nov 2020 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604738079;
        bh=VQEIbjgIJN/CnKwg2D7bKy1wLmUA3zkwBcSJPJaFNtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jS3v4nPDiyzQ+usZu5wTHDpE3l2O+nUeSEOT4McUCzkS+y30py91an90kdpCevIJA
         QFdjmZYa6EqjZkmQXt1IU8Yo71v0nwTRurU4ER1FtRjAjOBbFJDEXciNOpLuGmXveh
         cq6jVyTdnVBngN4n4wtwF/XnUt3EsG85XHB42nbQ=
Date:   Sat, 7 Nov 2020 09:34:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 0/6] platform/chrome: cros_ec_typec: Add cable
Message-ID: <20201107083436.GB19079@kroah.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:40:57AM -0800, Prashant Malani wrote:
> The following series adds Type C cable registration to the cros-ec-typec
> port driver using the Type C connector class framework. The first few
> patches perform a few minor re-organizations to prepare for the cable
> registration patch.
> 
> The last couple of CLs update the USB PD VDO header file to add a
> captive cable connector for the Type C cable plug field, and then use
> the added macro to add the corresponding field of the Type C cable
> descriptor in the cros-ec-typec driver.
> 
> v1:
> https://lore.kernel.org/lkml/20201106012758.525472-1-pmalani@chromium.org/
> 
> Changes since v2:
> - Changed local variable uint32_t to u32 in patch 6/6.

Looks good to me, for all of these:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

