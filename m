Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAE292DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgJSTAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbgJSTAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:00:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91135223BE;
        Mon, 19 Oct 2020 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603134016;
        bh=JpPEglovs+iBqp2rW9bt36UaOZZFrg19WLW7mEp8pP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WodXMDU4M/EFZ+qHDbgVPOmUs2j3IYdCKX8AHnc/XbKNDPweFpSrI7f+y/R5lfwgq
         J2g0lXpsFbekLr3xNw7I0dFEZKsTuxY0NMkKVl6rZn/xVY74+9LMGF3ijp+YcYqfwV
         6/qGectQAeaCzhgdT/vFqkeIYPbXNtDDcW0c9yJo=
Date:   Mon, 19 Oct 2020 21:00:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: remove unneeded break
Message-ID: <20201019190059.GA3338882@kroah.com>
References: <20201019175915.3718-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019175915.3718-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 10:59:15AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/tty/serial/imx.c | 5 -----

This is the imx driver, you should say that in the subject line like you
did for the other tty change you just sent out.

thanks,

greg k-h
