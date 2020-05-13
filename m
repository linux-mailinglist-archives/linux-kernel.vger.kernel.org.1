Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99001D08B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgEMGe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 02:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgEMGe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:34:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FB4206A5;
        Wed, 13 May 2020 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589351697;
        bh=mak/AviUJOOy+rYq05rrccTXeIivuFgnT5Ks24gbTjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQqYFmw9te5u23iB//yWDy6wTXEvZhUTb+IBe9/3VkXASUDNgqmpErqKHsv/Nwuo8
         NO02m8i3oBNfTSXF1qMKcQxI5uCQ7tXrhM6LkhADPCXBMFkru5LwFt8is6IljiaABt
         6kHdHo8YJ/6V7++CFPFi4cyZW8r01vhp9IE+eqNk=
Date:   Wed, 13 May 2020 08:34:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ashwin H <ashwinh@vmware.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Steven Rostedt <srostedt@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
Message-ID: <20200513063455.GA752913@kroah.com>
References: <d29f87f3f3abb4e496866253bd170faad976f687.1589305630.git.ashwinh@vmware.com>
 <20200513055548.GA743118@kroah.com>
 <89DE19F6-4CB0-4324-A630-C8574C8D591C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89DE19F6-4CB0-4324-A630-C8574C8D591C@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:13:17AM +0000, Ashwin H wrote:
> This patch fixes CVE-2018-20669 in 4.19 tree.

Ok, but what does that mean for us?

You need to say why you are sending a patch, otherwise we will guess
wrong.

greg k-h
