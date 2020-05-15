Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3091D5A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 22:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgEOUJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 16:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgEOUJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:09:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96EC82070A;
        Fri, 15 May 2020 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589573351;
        bh=wyr4NuvPd6cNEe6KL+vN74Z9EH//w3uUVPsxfEGAvaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IK3hjbXnJ8E8onU+LetpRC4yHNiwpLocJTEDmlLTmv1NUQF5T/q9MTvyRKQBOjRsm
         DWspGGbqX3ARbIRhZUnyBQiTErfNa/Xl76XMgNkR7ZBvw+qea/fpwLg4//aJYOkapM
         qxLYg69PxehZVJQOOcPWqhUyW564sDWZH4OX2n2M=
Date:   Fri, 15 May 2020 15:13:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: Replace zero-length array with flexible-array
Message-ID: <20200515201353.GC30837@embeddedor>
References: <20200507184356.GA13448@embeddedor>
 <8c165c0a-be47-b150-96bd-0e7dde7157e6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c165c0a-be47-b150-96bd-0e7dde7157e6@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:03:47PM -0700, John Johansen wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this into my tree

Great. :)

Thanks, John.
--
Gustavo
