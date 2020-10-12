Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E58928B3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgJLL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbgJLL2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:28:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0BE32080D;
        Mon, 12 Oct 2020 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602502124;
        bh=sTuFov17QoNXvw1Tg9+jfAMUuJ6kBXheaeeiufRm4Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztBicItN8ZBStXxDAbrbg12G6I7X99E+HqS6WiwUApfZ7XM++w65xYT684QAJ0mEn
         OwLtTucPhNu8dNb/7h5MvdkC3Mh55Tbyn3X98e7S+8Hvd7IsdPyS0+NddQ5UWKxh1l
         Q6Eh2PP5Lc1W1drEcBis4+HaIP98YUghXB5lYxxY=
Date:   Mon, 12 Oct 2020 13:29:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rickyniu <rickyniu@google.com>
Cc:     balbi@kernel.org, astrachan@google.com, amit.pundir@linaro.org,
        lockwood@android.com, benoit@android.com, jackp@codeaurora.org,
        vvreddy@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kyletso@google.com
Subject: Re: [PATCH 0/3] f_accessory upstream
Message-ID: <20201012112923.GE356911@kroah.com>
References: <20201012111024.2259162-1-rickyniu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012111024.2259162-1-rickyniu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 07:10:21PM +0800, rickyniu wrote:
> Below commit is to add log and send uevent:
> 0003-ANDROID-usb-f_accessory-send-uevent-for-51-52-reques.patch

I don't understand the text in this changelog, what does it mean?

confused,

greg k-h
