Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB371A4301
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJHcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 03:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJHcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:32:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F13B420757;
        Fri, 10 Apr 2020 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586503934;
        bh=CktXQo4G0AH1jtaGrkHCxrmPkUOrXFFdVEeFuTWCX1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNe4xBieXjLUnuCmwRfYb0ygHCl6jpZrIcHotzcXZxcDa5nvLPO86R0g/HsbALL5f
         X3PTRuNoU8e+pJuzFG0KnKAWQJWy7gPgoKTLP0wlgT2ATPiURJEc2ikV0xx3g9RwPL
         TrDiWll6JvJAe7JDSlOnwdC6hIn8oGFVvdjEKPOU=
Date:   Fri, 10 Apr 2020 09:32:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     R Veera Kumar <vkor@vkten.in>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2] staging: android: ion: use macro
 DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Message-ID: <20200410073211.GA1668699@kroah.com>
References: <20200409171318.1730-1-vkor@vkten.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409171318.1730-1-vkor@vkten.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 10:43:18PM +0530, R Veera Kumar wrote:
> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> operation rather than DEFINE_SIMPLE_ATTRIBUTE.

No, it is not "more clear", the two defines are not the same thing, they
do different things.  If they were just identical, we would not need
them both :)

So please be very explicit as to _why_ you want to change this, and show
how you have verified that changing this is the correct thing to do, and
how you tested.  Because the user-visible change can be quite different
with this type of kernel change.

thanks,

greg k-h
