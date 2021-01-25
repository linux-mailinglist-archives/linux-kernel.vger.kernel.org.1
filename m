Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA4C3025CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbhAYOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbhAYN4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:56:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3A8922AEC;
        Mon, 25 Jan 2021 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611582889;
        bh=rMrNFMGxb5KLxZcWGgVTYH8L+FDCa+mWN66kerbrq7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q92+NYeAl2bTiYokwT03KC7K8llbjS+vNVYVGK5ZU/qghwJBAxjXWwNGQlT6Eb9kG
         /DAhyG577FHueMeyKIjW4LdsfQp1FEPRSmYcaBIjNJ7plgg5+w8DSg5zFBR/a2LWfM
         b6LY36/VG8qs19Vg6mOEBttROXhuLGKsP4eWONHo1NNEXQvnjSOVQ6KDtlZGevZcvC
         dyJKs1ub+6HPpTwNoldB8PVBUHUJT0eiWva1X2AAHLEE4TH2lBLAD6XND8eIp55LMd
         o0axzxusqnHUoHg6zE0+jQ4sZ4Q+VNpZti+RLDMMHBs1G5YS4k0KCo7js5Gt4Gcm5G
         TNjmNYCGWKdyg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l42KW-00057E-Ty; Mon, 25 Jan 2021 14:54:57 +0100
Date:   Mon, 25 Jan 2021 14:54:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: Add pid/vid for WSDA-200-USB
Message-ID: <YA7NsCUQJpWsRc2W@hovoldconsulting.com>
References: <C3EAC35C-0CF6-481E-9532-024FFC176991@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3EAC35C-0CF6-481E-9532-024FFC176991@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:26:54AM +0000, Pho Tran wrote:
> Information pid/vid of WSDA-200-USB, Lord corporation company:
> vid: 199b
> pid: ba30
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com>

Applied, thanks.

Johan
