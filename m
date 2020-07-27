Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784BD22E9CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0KNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 06:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0KNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:13:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590042070B;
        Mon, 27 Jul 2020 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595844783;
        bh=t4D1FuJzCWxTOpgMJa4HQg6WIwmibM3xExErnAiX4MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dj/HLeYeVtEppj3YU0JNqU8s+eqN16yDQYhj7XUfNc+X18cXtccn7QnThuR6Nfm+o
         3vX9lL58a6TrLeFDe2qSynwfKapt27eqkPaY7kaQPiDlfb6eFtNCVB4pCwdVd34XLb
         ZUTYbbPTQdsYVCCdu/xAesOifcVmZEMgfnVNewik=
Date:   Mon, 27 Jul 2020 12:12:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Forest Crossman <cyrozap@gmail.com>
Cc:     linux-usb@vger.kernel.org, mathias.nyman@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: xhci: define IDs for various ASMedia host
 controllers
Message-ID: <20200727101259.GA1925099@kroah.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
 <20200727090629.169701-2-cyrozap@gmail.com>
 <20200727092654.GD1764157@kroah.com>
 <CAO3ALPwJq4=GairV8ksHenRtXwg2mYNDKtnYcf99eN6Eo6es5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3ALPwJq4=GairV8ksHenRtXwg2mYNDKtnYcf99eN6Eo6es5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 05:03:43AM -0500, Forest Crossman wrote:
> On Mon, Jul 27, 2020 at 4:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 27, 2020 at 04:06:28AM -0500, Forest Crossman wrote:
> > > Signed-off-by: Forest Crossman <cyrozap@gmail.com>
> >
> > I can not take patches without any changelog text, sorry.
> 
> Ah, whoops, I'm very sorry about that! Should I send a v2 of just this
> patch? Or would it be better to send the whole series again?

Whole series is always easier to handle.

thanks,

greg k-h
