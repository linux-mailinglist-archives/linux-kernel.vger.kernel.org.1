Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D699F248431
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHRLvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRLvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:51:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCEC206B5;
        Tue, 18 Aug 2020 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597751508;
        bh=hhb0IY4cPJ9eA2KCKViAjlMIC4OAAyM8melebR30u8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f51mk/XV6ujRPLb3qrLXWcQgwTFWr19kCIkPf5ElInD5Zn80o+RcraSph/e9lj2/r
         Oz9GwrPASJwRavATyGWcV7qCIQl0uDhgsTIT1Xe2877KSX+QlfZAV4BK8DlGIPLp3V
         +Ff9bD3PLkQ/Q5mW+bsjuFmFUtCLmgmjYocpV4LE=
Date:   Tue, 18 Aug 2020 13:52:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] tty: n_gsm, eliminate indirection for
 gsm->{output,error}()
Message-ID: <20200818115212.GA376000@kroah.com>
References: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:56:48AM +0200, Jiri Slaby wrote:
> gsm->output and ->error are set only to gsmld_output and gsm_error,
> respectively. Call these functions directly and remove error and output
> function pointers from struct gsm_mux completely.
> 
> Note: we need a forward declaration of gsmld_output now.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/n_gsm.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Thanks for this series, and for the vt cleanup series, all now queued
up.

greg k-h
