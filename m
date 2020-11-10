Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D962AD9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgKJPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbgKJPMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:12:13 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9E820781;
        Tue, 10 Nov 2020 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605021133;
        bh=1mblF7kr35Z4eiJcZUT7eprES5a/ixX706vxu/k08Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6affz/E4aV4Ui0igg+FgUuyrqzfW1yeSjciWelPZnac0MX47oXKUqccdT9o4yIrS
         Zq/tiSs8t2198qP/DHxFANqDghshFh9S2MEnZ6/38ZiQR69l9SDdltxHmPKMLa19fC
         zNJBg03AgkSHkY24s1rAZv4UX2cWWcgAGcHJo85E=
Date:   Tue, 10 Nov 2020 16:13:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v12 2/3] Since the original
 trace_binder_transaction_received cannot precisely present the real finished
 time of transaction, adding a trace_binder_txn_latency_free at the point of
 free transaction may be more close to it.
Message-ID: <X6quBb28IVvyRhox@kroah.com>
References: <1604995521.14886.9.camel@mtkswgap22>
 <1605017955-18027-1-git-send-email-Frankie.Chang@mediatek.com>
 <1605017955-18027-3-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605017955-18027-3-git-send-email-Frankie.Chang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:19:14PM +0800, Frankie Chang wrote:
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
> 
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> Acked-by: Todd Kjos <tkjos@google.com>

What happened to the subject line here?

The changelog body is in the subject line, and the subject is gone?

Can you fix this up for all of these patches and resend?

thanks,

greg k-h
