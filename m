Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AEC299288
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786061AbgJZQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1420671AbgJZQd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:33:56 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AE63205ED;
        Mon, 26 Oct 2020 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603730036;
        bh=bWoNngAufiPIkjmarMtBMPFzySoJrh+DrRGpysC4MY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8+OGZGK3tF65qryZdcaBl7eaZ7kySP9E1kTyIUN/dEK9j4zeyONQrbhPU2CtgrT0
         hT23WoJI3fYTEsxOODh4xyqAgfEvsYBn5366csXMJRR5kL8oHlWMEDMtS3Tyel2mOP
         MO+MdWKraAdASnyQStKwzKmId05aSpAo8UI7Km84=
Date:   Mon, 26 Oct 2020 09:33:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: initialize ChaCha20 constants with correct
 endianness
Message-ID: <20201026163354.GB858@sol.localdomain>
References: <20200916045013.142179-1-ebiggers@kernel.org>
 <20200918204207.GC80112@mit.edu>
 <20200918215705.GA126697@gmail.com>
 <20201007035145.GD912@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007035145.GD912@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 08:51:45PM -0700, Eric Biggers wrote:
> On Fri, Sep 18, 2020 at 02:57:05PM -0700, Eric Biggers wrote:
> > On Fri, Sep 18, 2020 at 04:42:07PM -0400, Theodore Y. Ts'o wrote:
> 
> Ted, any further feedback on this?  Are you planning to apply this patch?
> 
> - Eric

Ping.
