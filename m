Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FCA292235
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 07:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgJSFgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 01:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgJSFgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 01:36:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8604E22243;
        Mon, 19 Oct 2020 05:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603085764;
        bh=Zk79g/OjzH33ikD0zfQymM10qYqKglhwHW8e74xHsMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1LUENWcGmr/2/wRTldnySOcoQvqLk9H7ijJriTR91Iric9NJ5MsIR+0YBVO9Vy2Km
         mw9NqazMLjAOLwNhXBgciTs5uzms0gOOuIogZpV1bmJSddQFBfaVITl3xYzLPUyYAD
         gjlI+KnaBpLeOfumiVWRQbz6XSnXMFL7KBoADcCQ=
Date:   Mon, 19 Oct 2020 07:36:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     septs <job@septs.email>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, septs <kernel@septs.pw>
Subject: Re: [PATCH 1/1] usb: serial: option: add Quectel EC200T module
 support
Message-ID: <20201019053601.GB686460@kroah.com>
References: <20201018105111.8727-1-kernel@septs.pw>
 <20201018124937.GA3133964@kroah.com>
 <e51b0a3c-43ee-4b75-b32d-65ee2d43afb6@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51b0a3c-43ee-4b75-b32d-65ee2d43afb6@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:07:10AM +0800, septs wrote:
> Add usb product id of the Quectel EC200T module.
> 
> Signed-off-by: septs <kernel@septs.pw>

As my bot said before, you need to use your "legal name" here.  Is this
how you sign documents?  If so, that's fine, but I have to ask.

thanks,

greg k-h
