Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D83231E01
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgG2MFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 08:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2MFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:05:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E6920809;
        Wed, 29 Jul 2020 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596024343;
        bh=hIAez5LHosIyjz9fqsXYQe2NA7DmHfGd756pQ/7U0fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jpZeO7uOdMKIFglTnomMkb7HObX66tgRG484NQVGkr4ebcor/vjnR12OGIACBpb2
         wSe9kC/eJSfywnoob0NjovpgnEV5vUCqqcDI0fhmb2Qnv9Bho20Szds6fYGKkj8ZRS
         ZPAMClCECRF83q3OWKwAGMCg8QUu50TXQaM9kIE8=
Date:   Wed, 29 Jul 2020 14:05:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCHv2] staging/speakup: Move out of staging
Message-ID: <20200729120533.GA2883831@kroah.com>
References: <20200729003531.907370-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729003531.907370-1-samuel.thibault@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 02:35:31AM +0200, Samuel Thibault wrote:
> The nasty TODO items are done.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Now applied, thanks for all of the work so far.

I will be glad to merge patches for this subsystem to Linus if you want
me to collect them.  If so, feel free to forward them on to me, or send
me a pull request.

thanks,

greg k-h
