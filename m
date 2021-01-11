Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2722F0FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbhAKKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbhAKKQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:16:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3DBC2231F;
        Mon, 11 Jan 2021 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610360157;
        bh=dj4Tmm4gJIhkv9Vf38kkiEGTna3xWMW9LUtvKdM6hBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejcHc/oJTQ8aFRRxhOHpvwkLkM8uc30qmPUR4RS+Cz1q56RJIzCtnVRaZy4E66Xka
         IqpZYCgW30e290VSwbvLBAO0u2j5wQcW5ECe9mSzQE3D9HRb2/yhexnTwPUHvVs0oR
         LL8s0tZUkFDK8rBnWDLIwg3S10LpFbwszTpkLyEkDcweWxccEzPOft+7xW2TT8S2kH
         d2JNl92Tx8GrX6wUc8KTok/VmMoOqi0DvZUorsW+KEXCCXaKpEEnHajxIVuZSuELc9
         +++8avS6aeW6d7vVSnrohYkhTfl/aw2dh5WSl+fsI/tnNNCoS80nHHcbKTFzK0pLBW
         LWW71Ux3akTSA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kyuF0-0005lK-Ru; Mon, 11 Jan 2021 11:16:02 +0100
Date:   Mon, 11 Jan 2021 11:16:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: Re: [PATCH] USB: otg: Fix error 32 when enable hardware flow control.
Message-ID: <X/wlYs1zerpM9jew@hovoldconsulting.com>
References: <C429CBAD-FE44-42AE-909C-4C33052A7413@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C429CBAD-FE44-42AE-909C-4C33052A7413@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:55:22AM +0000, Pho Tran wrote:
> When hardware flow control is enabled,
> don't allow host send MHS command to cp210x.

You're commit message needs to explain *why* this is needed (and not
just say *what* the patch does).
 
> Signed-off-by: Pho Tran<pho.tran@silabs.com>

Also fix up the Subject prefix.

Johan
