Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89752B0BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKLR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgKLR4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:56:09 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ED8216C4;
        Thu, 12 Nov 2020 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605203768;
        bh=NLkY9uLvlled2LN7QJuMDGGIC5/iJgTKQOxS3vcxyvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X35jN8XfS9fwfsxO56CAJAlotKsXdJT1OgaPJR8KJZ/EibfzSxBfySb21N1G2gHAY
         kXi+ca1MmvUeFUvt2ie6kqQsvyCpoUbH+pThkCtFxJizmWnVacfsJVOu1TW9F9734v
         CuDAhVYWPtcBe/NYnfNTU1GW7UCjR2TOcHmpUcE8=
Date:   Thu, 12 Nov 2020 18:57:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Boero <boeroboy@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <X613chtPVIg8kquH@kroah.com>
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com>
 <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:13:30PM +0000, John Boero wrote:
> Yes the patch is backwards sorry.  Testing alt proposal from
> stern@rowland.harvard.edu.  It may be a buggy driver
> but it would be nice if a buggy driver couldn't bring down
> the entire usb core. lsusb hangs until reboot or reset of usb.

buggy kernel drivers can do anything, including deleting the contents of
your disk.  We don't protect the kernel from itself, sorry :)

good luck!

greg k-h
