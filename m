Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187D23C895
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgHEJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 05:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEJEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:04:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5078D22B40;
        Wed,  5 Aug 2020 09:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596618249;
        bh=QPLG5ZgVtxfAcgI2IMlcl38QZKfiBDdcZJQT1y1XdjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzikWSLYGBy/+9k8QenQ0XIlFAllIQ9BBNHnVaNr6JA3sBITKOG1GBNLkVqyLOTJ6
         th7OGbBLVepzILFrgnkP5iMs4SesbLqd17YOd8Q3xq7Z5QVR48u/6WGC074q8NJeoG
         FTugKa72K/lxQxDegw4oXIJQSI1IJvYho+AC5vDM=
Date:   Wed, 5 Aug 2020 11:04:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: refactor to avoid duplication at hif_tx.c
Message-ID: <20200805090425.GA655071@kroah.com>
References: <20200805085608.GA100079@tsnow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805085608.GA100079@tsnow>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:56:08AM +0300, Tomer Samara wrote:
> Add functions wfx_full_send(), wfx_full_send_no_reply_async(),
> wfx_full_send_no_reply() and wfx_full_send_no_reply_free()
> which works as follow:
> wfx_full_send() - simple wrapper for both wfx_fill_header()
>                   and wfx_cmd_send().
> wfx_full_send_no_reply_async() - wrapper for both but with
>                                  NULL as reply and size zero.
> wfx_full_send_no_reply() - same as wfx_full_send_no_reply_async()
>                            but with false async value
> wfx_full_send_no_reply_free() - same as wfx_full_send_no_reply()
>                                 but also free the struct hif_msg.

Please only do one-thing-per-patch.  Why shouldn't this be a 4 patch
series?

thanks,

greg k-h
