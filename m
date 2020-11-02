Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B084C2A3465
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKBTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBTky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:40:54 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2472225E;
        Mon,  2 Nov 2020 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346052;
        bh=xFTV7jxi0Z5FmX9TvpJwworvBiIkraPMD/kpaDtN+A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juv/VWknHk6qwA/PAJJq7bClhe0qpWTvHnaqbry/qAv/AxzjYRMrtXFHMdQg2T9/i
         AdoE3Dw+wXXqTsUCog2bHScSmi1qrcLjGrBJXDVg9OE/uXkBf45UcmJIkEsdbmniZC
         Z8DIw0oXwvDGOpLMrDFUksEsBMOXhOdW5SGzj4IQ=
Date:   Mon, 2 Nov 2020 20:41:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: Re: [PATCH] MAINTAINERS: update email, git repo of habanalabs driver
Message-ID: <20201102194146.GB2429929@kroah.com>
References: <20201102191753.13809-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102191753.13809-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:17:53PM +0200, Oded Gabbay wrote:
> Update the email to my kernel.org email address and update the git
> repository address to the git.kernel.org
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
