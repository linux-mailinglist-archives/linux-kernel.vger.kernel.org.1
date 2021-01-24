Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB41301B04
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 11:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAXKGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 05:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbhAXKGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 05:06:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9153D22AAA;
        Sun, 24 Jan 2021 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611482731;
        bh=zS1RDhAfzFBpp4X6MQvFnoevuBsPi2i3OzTyuHdaL6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGL5Mwbt+SK3CVTSwxiMb3+EMRG59AiAUn1LQSQ03EFdhGPtcXVMc5OVNkRE8++s/
         ChOON+6pqxx1hRUiau6PmQ6h/Ttmip8GHP749MclA8HKg/5vipxQ3Xswo5Ml5HnuGf
         PaRJqFxx/AJygsW8AZZBUvl8esg0x2Yc1xUKwzYc=
Date:   Sun, 24 Jan 2021 11:05:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaurav Kohli <gkohli@codeaurora.org>
Cc:     rostedt@goodmis.org, efremov@linux.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] trace: Fix race in trace_open and buffer resize call
Message-ID: <YA1GaFpirfseZkxd@kroah.com>
References: <1611482193-32540-1-git-send-email-gkohli@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611482193-32540-1-git-send-email-gkohli@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 03:26:33PM +0530, Gaurav Kohli wrote:
> Below race can come, if trace_open and resize of

<snip>

You forgot to cc: stable, and put the git id that this patch is
upstream...
