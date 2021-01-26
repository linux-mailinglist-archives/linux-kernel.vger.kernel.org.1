Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F36304F09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbhA0Be7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390777AbhAZSii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:38:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2115222228;
        Tue, 26 Jan 2021 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611686275;
        bh=xUeA3b+24ASFTVknmkJ3IDzVp+8929p2ULJFb29osFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0ablg5T6qZtXP2ARalwLVEog0zkjGaO2/u2WJdTvirQfIzxSc7I1o4JuSy+1hSXO
         +07VPZmdtqzq6Hw/laDccCMhP8OpIKcBOl1squbx27aJp+q/svkeojv2SE6a+gLLwk
         /DcPaPWUJsnevHhnqF1WhrAWT0mDT5wMIAJIDZYU=
Date:   Tue, 26 Jan 2021 19:37:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 1/4] This merely adds the missing synth parameter to all
 io functions.
Message-ID: <YBBhgVZpTn9T2eL5@kroah.com>
References: <20210111223737.697336-1-samuel.thibault@ens-lyon.org>
 <20210111223737.697336-2-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111223737.697336-2-samuel.thibault@ens-lyon.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:37:34PM +0100, Samuel Thibault wrote:
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

I can't take a patch without any changelog text :(

Can you fix this up and resend the series?  Sorry for the delay in
reviewing this.

greg k-h
