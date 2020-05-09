Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5561CC315
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgEIRLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 13:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEIRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:11:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB84D2184D;
        Sat,  9 May 2020 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589044293;
        bh=Knc6lihQiyioaGFRTOVqQ9keAhGSuwjLXItKg6yamdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Awx6svb+sXY9Nb1+JkPtcyV+gT732HQk2LBchxvGubEgp3mbS7q9AwBqMxh55g0/t
         Li864Ct2Zx/qanTNcvtRN350fif6Rr+879RB03rX33tTlRlh7X+9aHfnSKofph22sn
         Js8zspBbqLHuW6ZBLywIrEdE3ccr8zKi+rkUJYdU=
Date:   Sat, 9 May 2020 19:11:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vc04_services: interface: vchiq_arm:
 vchiq_connected.c: Block comments should align the * on each line
Message-ID: <20200509171131.GA2495033@kroah.com>
References: <20200509130714.10586-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509130714.10586-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 02:07:14PM +0100, John Oldman wrote:
> Coding style issue

Your subject line needs to be much shorter, don't you think?

Please fix up and resend.

greg k-h
