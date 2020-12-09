Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944172D4483
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbgLIOj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbgLIOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:39:56 -0500
Date:   Wed, 9 Dec 2020 15:40:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607524752;
        bh=Ndua0Qb0+XJsoggkT9dt03GOXR+ewfsxw2/Ib/4nYqY=;
        h=From:To:Subject:References:In-Reply-To:From;
        b=qty7MVFzIWgcNAGIlk06+sJNTaADV5rt37SPKFWgCVl+V8bzFvtnfXT/y4eOO/thW
         ykm5MgSc/uDGKzK0XKvgZ/MNAR+gH5xI6VQIYYTrr82tD1STL3GC3INyijfh96itN5
         4AXoPrQF0a0dpjgL6W9r2DrPMJotYsUCtOzDQ9So=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <X9Dh3exc0rN1YitF@kroah.com>
References: <20201130220626.854574234@ens-lyon.org>
 <20201130220719.168900798@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130220719.168900798@ens-lyon.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:26:41PM +0100, Samuel Thibault wrote:
> This merely adds the missing synth parameter to all io functions.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

This patch breaks the build :(

Can you rebase and resend this whole series, as the other patches do not
apply anymore due to the recent fixes in the speakup code.

thanks,

greg k-h
