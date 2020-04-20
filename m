Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3E71B19E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDTXCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTXCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:02:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527F5C061A0E;
        Mon, 20 Apr 2020 16:02:20 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F116E9B7;
        Mon, 20 Apr 2020 23:02:19 +0000 (UTC)
Date:   Mon, 20 Apr 2020 17:02:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] docs: ioctl-number.rst: add habanalabs driver IOCTL
Message-ID: <20200420170218.07a866e3@lwn.net>
In-Reply-To: <d3ba8ac2-660f-a388-4f8d-0157607448a0@infradead.org>
References: <20200418174132.10597-1-oded.gabbay@gmail.com>
        <d3ba8ac2-660f-a388-4f8d-0157607448a0@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 10:45:08 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 4/18/20 10:41 AM, Oded Gabbay wrote:
> > Habanalabs driver in misc exposes several IOCTLs to userspace. Document the
> > letter and IOCTLs number range in ioctl-number.rst.
> > 
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

jon
