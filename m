Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D881C6A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgEFHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 03:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgEFHid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:38:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B216220735;
        Wed,  6 May 2020 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588750376;
        bh=Y1LEEe+kkf6vU7B4UsWqodC8jLCx0BRsN/zYtJeEjvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5feX9SVlod6nQUrokIJem+6I1ByfhYGOk+CesqWuk2wyAkt4RXSZAzsX7v1+XHzw
         4DHHxD+eEyyVXNUeQgoKdApHpR2IzkSgNtvuBR/5AtvjmSXKGWNQuEdjTsPn/kaqLI
         9lKQllYCeCb3g9sV3dmmZ0E2yTndn+rdkJrAGN70=
Date:   Wed, 6 May 2020 09:32:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: serial: Add reg-io-width compatible
Message-ID: <20200506073253.GB2336830@kroah.com>
References: <20200506070009.16809-1-hyunki00.koo@samsung.com>
 <CGME20200506070024epcas2p2868e11349d2fee83d340df7fa181f704@epcas2p2.samsung.com>
 <20200506070009.16809-2-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506070009.16809-2-hyunki00.koo@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:00:06PM +0900, Hyunki Koo wrote:
> Add a description for reg-io-width options for the samsung serial
> UART peripheral.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

You dropped the reviewed-by tag that Rob gave on the previous version of
this patch.

Please put that back and resend.

thanks,

greg k-h
