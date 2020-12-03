Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851112CD6AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgLCN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbgLCN0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:26:23 -0500
Date:   Thu, 3 Dec 2020 14:26:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607001942;
        bh=zTg0LRTp2jk/sIarx18z8q2py24tLNT7rye1Bm9xA3Q=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=oX4Q1PTJ0gW+smYtC0ojk9WJJh3RiMRdU/g9hf3FYfJlDZIIaeed2u+JkxEdJZFwb
         /GoeYCVMSRhNDk6XX2L8RYcV2jyLQV2rIhups/uapAuFnRtJ0LeNg/JWvy2/gSspAv
         Qz5Rt7CsT1QPs1a5TTeTRMHxrp1I2vyOPGpGCd38=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ertza Warraich <ertza.afzal@gmail.com>
Cc:     balbi@kernel.org, dave.jing.tian@gmail.com, kt0755@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: NULL pointer dereference bug
Message-ID: <X8jnmfppPk5Wii6p@kroah.com>
References: <CAD+hOztkbvSfugYDWSw9UpmBM0vTcmHp=7kfJmYZF6CdC+eZXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+hOztkbvSfugYDWSw9UpmBM0vTcmHp=7kfJmYZF6CdC+eZXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:56:08PM -0500, Ertza Warraich wrote:
> We report a null ptr deref bug (in linux-5.8.13) found by FuzzUSB (a
> modified version of syzkaller).

5.8.y is end-of-life, you should test 5.9.y at the oldest.

Anyway, without a reproducer or a patch for this, it's not going to
probably go very far :(

thanks,

greg k-h
