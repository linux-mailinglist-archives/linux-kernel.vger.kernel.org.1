Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8394C2FAB70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394235AbhARU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:27:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:40920 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437986AbhARU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:26:59 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 65E372AE;
        Mon, 18 Jan 2021 20:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 65E372AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611001568; bh=+A3bHHXAp+bngxz1bb5KJ0GvcDjSHupE8AYMS93O5us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4W03KX2LM4h+o7+vReJuNIag6FKn6ZeUInoZpgZdSzp92yJWIKWEjGpbKE1cemRP
         4BT88HzNkkDDF8FkG4kfcQb+g1IeohMybc9S9c5RukMxWAAyMyBWx+3lEJttZGhFJP
         PtJnEeu2WcfR6YfT29l0rOnuLMcmtCn6WBCs+SfaLgP3VpwDwJV7C1sSdvz+nPl+Gh
         INOf8D/VAO2N1pcv5E7enrIHv+/QS+a/S1yo2xaKWWj3x0icJFAd6kRWZC/e/oZhw6
         SicEu3zfMvjmwISr5KkTXbrKPquI0q0gw3CbbcBEb0D66Q4UQl9aYPloyZdkQR2FUp
         h8qtFs8JrVv+g==
Date:   Mon, 18 Jan 2021 13:26:07 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     lukas.bulwahn@gmail.com, sudip.mukherjee@codethink.co.uk,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-doc@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] docs: Remove make headers_check from checklist
Message-ID: <20210118132607.78d3c2d3@lwn.net>
In-Reply-To: <1610458861-2832-1-git-send-email-milan.lakhani@codethink.co.uk>
References: <1610458861-2832-1-git-send-email-milan.lakhani@codethink.co.uk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 13:41:01 +0000
Milan Lakhani <milan.lakhani@codethink.co.uk> wrote:

> Remove the make headers_check step from submit-checklist.rst as this is
> no longer functional.
> 
> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> ---
>  Documentation/process/submit-checklist.rst | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.

jon
