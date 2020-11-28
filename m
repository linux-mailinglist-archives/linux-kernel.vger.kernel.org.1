Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F032C7114
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbgK1Vwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732896AbgK1TEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:04:36 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8485822240;
        Sat, 28 Nov 2020 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606566245;
        bh=6COpZqVdNAt/u2BLcs4EICsnG0a1dS0n42uvYkTvtQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idFMQ6T4kBcEvnGJc+9g/5wJfLyb8m5a+J0vpFWbfADk+qFMwvJR08eo2h0ICYE5O
         S/Xarxay7CWh5xVBIKeykn4qCT5qmZDmOkZG6y0E57GhTO0RJz74C+9QXBFKjFNnwv
         6Bu/7qQNpDeMl9/9xId8aiBodeis4+fcekwgmTDg=
Date:   Sat, 28 Nov 2020 13:25:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vishawanath Jadhav <jvishwanath66@gmail.com>
Cc:     linux-kernel@vger.kernel.org, surenb@google.com
Subject: Re: [PATCH] Staging: android: ashmem: Fixed a coding style issue.
Message-ID: <X8JBqME9UGVJBerm@kroah.com>
References: <20201128121627.GA27317@worker-node1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128121627.GA27317@worker-node1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 05:46:27PM +0530, Vishawanath Jadhav wrote:
> Fixed a coding style issue, file_operations structure should be declared as a constant.

Did you test build this change?

Also, properly wrap your changelog at 72 columns like the editor asks
you to, and use get_maintainer.pl to know who and what list to send
patches to.

thanks,

greg k-h
